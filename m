Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030642AbWKOQRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030642AbWKOQRF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030641AbWKOQRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:17:04 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:41972 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1030639AbWKOQRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:17:01 -0500
Message-ID: <455B3D99.8040705@cfl.rr.com>
Date: Wed, 15 Nov 2006 11:17:29 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Mathieu Fluhr <mfluhr@nero.com>, Arjan van de Ven <arjan@infradead.org>,
       jgarzik@pobox.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: READ SCSI cmd seems to fail on SATA optical devices...
References: <1163434776.2984.21.camel@de-c-l-110.nero-de.internal>	 <4558BE57.4020700@cfl.rr.com>	 <1163444160.27291.2.camel@de-c-l-110.nero-de.internal>	 <1163446372.15249.190.camel@laptopd505.fenrus.org>	 <1163519125.2998.8.camel@de-c-l-110.nero-de.internal>	 <455 <455B3A78.7010503@gmail.com>
In-Reply-To: <455B3A78.7010503@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2006 16:17:32.0936 (UTC) FILETIME=[8E258880:01C708D1]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14814.003
X-TM-AS-Result: No--16.126400-5.000000-4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
>> The patch _seems_ to solve my problem. I am just really astonished when
>> I read the diff file :D. Can I expect that it will be merged to the
>> official kernel sources ?
> 
> It seems that some devices choke when the bytes after CDB contain 
> garbage.  I seem to recall that I read somewhere ATAPI device require 
> left command bytes cleared to zero but I can't find it anywhere now. 
> Maybe I'm just imagining.  Anyways, yeah, I'll push it to upstream.
> 

The original patch memsets the entire buffer only to copy over most of 
it right after.  Could you amend the patch so that it memcpys first, 
then memsets only the remainder of the buffer?  No sense wasting cpu 
cycles.

