Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161463AbWJ3XY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161463AbWJ3XY5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161541AbWJ3XY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:24:57 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:41661 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1161463AbWJ3XY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:24:56 -0500
Message-ID: <454689C7.6030009@vmware.com>
Date: Mon, 30 Oct 2006 15:24:55 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] Skip timer works.patch
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com> <20061027145650.GA37582@muc.de> <45425976.3090508@vmware.com> <200610271416.12548.ak@suse.de> <4546669F.8020706@vmware.com> <20061030225016.GA95732@muc.de> <45468620.5060805@vmware.com> <20061030231251.GB98768@muc.de>
In-Reply-To: <20061030231251.GB98768@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> That is the one that can panic, for now.  Fixing the paravirtualized 
>> case is easy, but we can't assume paravirtualization just yet.
>>     
>
> Hmm, this means standard vmware boot is not reliable unless that magic option
> is set?   That doesn't sound good.  
>   

It doesn't happen often, but it is a possibility that the kernel 
calibrates the delay wrong because of timing glitches caused by CPU 
migration, paging, or other phenomena which are supposed to be 
transparent to the kernel (but cause temporal lapse).  In that case, the 
kernel may not make enough progress in a spin delay loop to properly 
reach the number of microseconds required for N number of timer ticks to 
occur.  In theory this can happen on a real machine, as SMM mode could 
be active, doing USB device emulation or something that takes a while 
during the lpj calibration and throwing the computation off.

By changing the parameters (N ticks at K Hz in T seconds), it is easy to 
create an unstable measurement that can achieve high failure rates, 
although in practice the Linux parameters appear to be reasonable enough 
that it is not a major problem.

Zach
