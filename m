Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbVCBVaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbVCBVaZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 16:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVCBV3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 16:29:11 -0500
Received: from mailhub2.nextra.sk ([195.168.1.110]:23305 "EHLO toe.nextra.sk")
	by vger.kernel.org with ESMTP id S262463AbVCBV1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:27:19 -0500
Message-ID: <42263069.9000306@rainbow-software.org>
Date: Wed, 02 Mar 2005 22:30:17 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove dead cyrix/centaur mtrr init code
References: <20050228192001.GA14221@apps.cwi.nl> <1109721162.15795.47.camel@localhost.localdomain> <20050302075037.GH20190@apps.cwi.nl> <4225D4B4.6020002@rainbow-software.org> <20050302191802.GB1512@redhat.com>
In-Reply-To: <20050302191802.GB1512@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Wed, Mar 02, 2005 at 03:59:00PM +0100, Ondrej Zary wrote:
>  > >>The failure to invoke the ->init operator appears to be the bug.
>  > >>The centaur code definitely wants the mcr init function to be called.
>  > >
>  > >Yes, I expected that to be the answer. Therefore #if 0 instead of deleting.
>  > >But if calling ->init() is needed, and it has not been done the past
>  > >three years, the question arises whether there are any users.
>  > 
>  > I'm running 2.6.10 on Cyrix MII PR333 and it works. Maybe the code is 
>  > broken but I haven't noticed :-)
> 
> your /proc/mtrr is likely broken/suboptimal.

It looks fine to me:

rainbow@pentium:~$ cat /proc/mtrr
reg01: base=0x000c0000 (   0MB), size= 256KB: uncachable, count=1
reg02: base=0xe1000000 (3600MB), size=   4MB: write-combining, count=2
reg07: base=0x00000000 (   0MB), size= 128MB: write-back, count=1

The machine has 128MB memory, there's 4MB Matrox Mystique card:

00:14.0 VGA compatible controller: Matrox Graphics, Inc. MGA 1064SG 
[Mystique] (rev 02) (prog-if 00 [VGA])
         Subsystem: Matrox Graphics, Inc. MGA-1084SG Mystique
         Flags: bus master, stepping, medium devsel, latency 64, IRQ 6
         Memory at e0000000 (32-bit, non-prefetchable) [size=16K]
         Memory at e1000000 (32-bit, prefetchable) [size=8M]
         Memory at e2000000 (32-bit, non-prefetchable) [size=8M]
         Expansion ROM at <unassigned> [disabled] [size=64K]


-- 
Ondrej Zary
