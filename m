Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753553AbWKFRof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbWKFRof (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 12:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753590AbWKFRof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 12:44:35 -0500
Received: from nz-out-0102.google.com ([64.233.162.197]:12624 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1753553AbWKFRoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 12:44:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=CY4vLPCF7+TK9U+h7NP8xujuKmsAV1grHcKqYXAUN8p8He+ueokmt4Nr2Q7qiw3LvshDsuXHqX9/ysrSVc7FjmghWufIng9yXIpjFKS0nxrHk9kGFzAlxD3rODy+EtP/cXHqsLcyIwv6FxGeWRiiErk7MJXtz7YNNsqd/GshXMw=
Message-ID: <454F747A.9050209@gmail.com>
Date: Tue, 07 Nov 2006 02:44:26 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: SATA powersave patches
References: <20060908110346.GC920@elf.ucw.cz> <45015767.1090002@gmail.com> <20060908123537.GB17640@elf.ucw.cz> <4501655F.5000103@gmail.com> <20060910224815.GC1691@elf.ucw.cz> <4505394F.6060806@gmail.com> <20060918100548.GJ3746@elf.ucw.cz> <450E771E.1070207@gmail.com> <20061106135751.GA13517@elf.ucw.cz>
In-Reply-To: <20061106135751.GA13517@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> I'm probably doing something wrong, but...
> 
> I'm on commit 
> 
> commit 9a7b050525f7d70d2ed62affb691b9d4ca2b82d2
> tree b8195e5625dc5bad6757b0dddec0dacf416a0779
> parent 50c3086de212ce56eaa2bf284586fb021615b5e1
> author Tejun Heo <htejun@gmail.com> Mon, 16 Oct 2006 07:24:57 +0900
> committer Tejun Heo <htejun@gmail.com> Mon, 16 Oct 2006 07:24:57 +0900
> 
>     [PATCH] sata_sil24: implement PORT_RST
> 
>     As DEV_RST (hardreset) sometimes fail to recover the controller
>     (especially after PMP DMA CS errata).  In such cases, perform
> PORT_RST
>     prior to DEV_RST.
> 
>     Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> (2.6.19-rc1)
> 
> and I do not see powersave tunable:
> 
> root@amd:/sys/module# ls libata/parameters/
> ata_probe_timeout         atapi_enabled hotplug_polling_interval
> atapi_dmadir              fua
> 
> ...how do I pull working version?

I haven't updated link powersave patch yet.  Core implementation was 
agreed on but interface hasn't been decided yet.  Maybe it's about time 
to add /sys/class/ata_{host|device}/.  So, the patchset is pushed back 
for the time being.

>>>> So, I think option #1 is the way to go - implementing leveled dynamic 
>>>> power management infrastructure and adding support in the block layer. 
>>>> What do you think?
>>> Would be nice :-).
>> So, do you think we're ready for another PM infrastructure update?  :-P
> 
> Well... things are pretty quiet in that area just now... So yes.

If I understood correctly, the high power consumption of ahci controller 
can be solved by dynamically turning off command processing while the 
controller is idle, which fits nicely into link powersaving, right?  So, 
I think full-fledged leveled dynamic PM would be an overkill for this 
particular problem, but then again, maybe the correct way to implement 
link powersaving is via leveled dynamic PM.  I'll give it more thoughts.

Thanks.

-- 
tejun
