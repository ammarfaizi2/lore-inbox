Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264307AbUGAIbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264307AbUGAIbt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 04:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUGAIbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 04:31:48 -0400
Received: from hermes.domdv.de ([193.102.202.1]:15365 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S264307AbUGAIbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 04:31:39 -0400
Message-ID: <40E3CBE8.7060400@domdv.de>
Date: Thu, 01 Jul 2004 10:31:36 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040311
X-Accept-Language: en-us, en, de
MIME-Version: 1.0
To: Dan Hollis <goemon@anime.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.6 amd8111 apic bugs
References: <Pine.LNX.4.44.0406301533030.28684-100000@sasami.anime.net>
In-Reply-To: <Pine.LNX.4.44.0406301533030.28684-100000@sasami.anime.net>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Hollis wrote:
>>>>There seem to be regular dma timeouts:
>>>>hdc: dma_timer_expiry: dma status == 0x24
>>>>hdc: DMA interrupt recovery
>>>>hdc: lost interrupt
>>>>hda: dma_timer_expiry: dma status == 0x24
>>>>hda: DMA interrupt recovery
>>>>hda: lost interrupt
>>>>Hardware:
>>>>Opteron 140, Tyan Tomcat K8S (S2850)
>>>
>>>Try disabling ACPI (in .config or boot acpi=off iirc)
>>
>>I had that problem, but not with ACPI, only when I forced APIC on.  It 
>>was on the VIA controller which uses the same driver.
> 
> 
> Turns out it was apic and not acpi at all. Booting with ACPI but noapic 
> and I no longer get any dma errors.
> 
> Is the bug in the linux apic code or a hardware flaw in the opteron cpu? 
> Or something else?
> 

 From the X86-64 patch release notes of Andi Kleen:

Reports that dual Tyan S2885 and S2880 can lock up when multiple IDE 
channels are stressed in parallel. "noapic" or "ideX=serialize" seems to 
work around it. Andre Hedrick thinks it's a generic bug/race in the IDE 
code.

Looks like you have a similar problem on a UP board.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
