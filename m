Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVEYLnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVEYLnc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 07:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVEYLmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 07:42:14 -0400
Received: from hermes.domdv.de ([193.102.202.1]:38413 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S262191AbVEYLlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 07:41:16 -0400
Message-ID: <42946451.9070301@domdv.de>
Date: Wed, 25 May 2005 13:41:05 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc4, -mm: bad ide-cs problems
References: <20050525112745.GA1936@elf.ucw.cz> <20050525112824.GA2892@elf.ucw.cz>
In-Reply-To: <20050525112824.GA2892@elf.ucw.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On St 25-05-05 13:27:45, Pavel Machek wrote:
> 
>>Hi!
>>
>>I see some problems in pcmcia subsystem in 2.6.12-rc4:
>>
>>On compaq nx5000, inserting CF ide card is recognized as anonymous
>>memory. On compaq evo, it is recognized okay and
>>mounts/works. Unfortunately when I unplug the card, I get an oops:
>>
>>Message from syslogd@Elf at Wed May 25 13:25:25 2005 ...
>>Elf kernel: Unable to handle kernel NULL pointer dereference at
>>virtual address 00000010
>>
>>Message from syslogd@Elf at Wed May 25 13:25:25 2005 ...
>>Elf kernel:  printing eip:
>>
>>Message from syslogd@Elf at Wed May 25 13:25:25 2005 ...
>>Elf kernel: *pde = 00000000
>>
>>Message from syslogd@Elf at Wed May 25 13:25:25 2005 ...
>>Elf kernel: Oops: 0000 [#1]
>>
>>. -mm kernel actually works better on nx5000; it behaves similary to
>>-rc4 on evo; unfortunately it produces similar oops on card unplug.
> 
> 
> This is full oops from -rc4 on compaq evo:
> 
> hde: cache flushes not supported
>  hde: hde1
> ide-cs: hde: Vcc = 3.3, Vpp = 0.0
>  hde: hde1
>  hde: hde1
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000010
>  printing eip:
> c033d618
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c033d618>]    Not tainted VLI
> EFLAGS: 00010292   (2.6.12-rc4)
> EIP is at ide_drive_remove+0x8/0x10
> eax: c07825f8   ebx: c0782704   ecx: c07826f0   edx: 00000000
> esi: c07826e0   edi: c065fed8   ebp: 00000001   esp: dfce5e84
> ds: 007b   es: 007b   ss: 0068
> Process pccardd (pid: 932, threadinfo=dfce4000 task=dfc84a40)
> Stack: c02dc4b4 c07826e0 c065fa00 c0782568 c02dc724 c07826e0 c0782a80
> c02db5e2
>        c07826e0 df373a80 c02db628 c07825f8 c033bcfb c0782568 00000002
> df373b80
>        df373b80 c0670680 c0670728 c034f63b df758200 00000000 c034f67a
> c0386108
> Call Trace:
>  [<c02dc4b4>] device_release_driver+0x74/0x80

Pavel,
I had a similar problem which I fixed amd posted to lkml a while ago
though I seems to got ignored by the ide maintainer. Please see if this
helps in your case:

http://marc.theaimsgroup.com/?l=linux-kernel&m=111409743421578&w=2
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
