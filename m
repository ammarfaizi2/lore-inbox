Return-Path: <linux-kernel-owner+w=401wt.eu-S933840AbWLKOXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933840AbWLKOXq (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 09:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934264AbWLKOXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 09:23:46 -0500
Received: from nz-out-0506.google.com ([64.233.162.238]:28038 "EHLO
	nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934488AbWLKOXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 09:23:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=rmCvjA02Wu1wvh/GKMy5YyLWmJ0XkpHAy27dA0/FCmqIQcrki8xtkMxc4O+fcT1cZYEPolUrFrxl0D98ZwSrrfaIuGsJJn6mUEUhqGoV76owaIelpt8Ps/DKyO2kb+EQNeWl9MYwzhWAS3j4qFdT+rNC/y8AtpKVgyPjS1mRugM=
Message-ID: <457D69E7.9040708@gmail.com>
Date: Mon, 11 Dec 2006 23:23:35 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
CC: jgarzik@pobox.com, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata: don't initialize sg in ata_exec_internal() if
 DMA_NONE
References: <200612081914.41810.arnd.bergmann@de.ibm.com> <20061211140258.GB18947@htj.dyndns.org>
In-Reply-To: <20061211140258.GB18947@htj.dyndns.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> I'll follow up with conversion to ata_do_simple_cmd().

The current situation is...

ata_exec_internal_sg()	: no user except for ata_exec_internal() yet
ata_exec_internal()	: one data transferring user. other are non-data
ata_do_simple_cmd()	: three users

So, adding another exec_internal variant doesn't look so hot.  It seems
we already have enough variants considering the small number of users.
I think it's best to leave it alone for now.

Thanks.

-- 
tejun
