Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030622AbWKOQEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030622AbWKOQEU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030624AbWKOQET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:04:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:3231 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030622AbWKOQES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:04:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=tPASZmeudIzQO7f3jdfSr5EKYaiYivm+JxS1zIiOreOXzYsWE0r1II7xUqFFv3QbbT50IK5zRWGWFGSskVJDcI9QC/ZsJ2m7jVro/+Jj8kf+Kqh5kmME3QSaVSpTra+vtdWIEZkSAzCFIUzzrnHAm4NMhpXjAY/9rxr6qZQ5fSw=
Message-ID: <455B3A78.7010503@gmail.com>
Date: Thu, 16 Nov 2006 01:04:08 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Mathieu Fluhr <mfluhr@nero.com>
CC: Arjan van de Ven <arjan@infradead.org>, Phillip Susi <psusi@cfl.rr.com>,
       jgarzik@pobox.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: READ SCSI cmd seems to fail on SATA optical devices...
References: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>	 <4558BE57.4020700@cfl.rr.com>	 <1163444160.27291.2.camel@de-c-l-110.nero-de.internal>	 <1163446372.15249.190.camel@laptopd505.fenrus.org>	 <1163519125.2998.8.camel@de-c-l-110.nero-de.internal>	 <4559FBCF.9050203@gmail.com> <1163603958.3029.3.camel@de-c-l-110.nero-de.internal>
In-Reply-To: <1163603958.3029.3.camel@de-c-l-110.nero-de.internal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Fluhr wrote:
> On Wed, 2006-11-15 at 02:24 +0900, Tejun Heo wrote:
>>> ... and the problem is not in accessing the device itself (this is
>>> working like a charm) but understanding why a SCSI READ(10) cmd
>>> sometimes fails as a ATA-padded READ(10) cmd - as discribed in the
>> Annex
>>> A of the MMC-5 spec - ALWAYS works.
>>> -> I would suspect somehow a synchronisation problem somehow in the
>>> translation of SCSI to ATA command...
>> Can you try the attached patch and see if anything changes?
>>
> 
> The patch _seems_ to solve my problem. I am just really astonished when
> I read the diff file :D. Can I expect that it will be merged to the
> official kernel sources ?

It seems that some devices choke when the bytes after CDB contain 
garbage.  I seem to recall that I read somewhere ATAPI device require 
left command bytes cleared to zero but I can't find it anywhere now. 
Maybe I'm just imagining.  Anyways, yeah, I'll push it to upstream.

-- 
tejun
