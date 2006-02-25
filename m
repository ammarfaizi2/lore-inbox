Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWBYWZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWBYWZU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 17:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWBYWZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 17:25:20 -0500
Received: from jade.aracnet.com ([216.99.193.136]:33960 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S932096AbWBYWZU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 17:25:20 -0500
Message-ID: <4400D946.4090200@BitWagon.com>
Date: Sat, 25 Feb 2006 14:25:10 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] inflate pt1: clean up input logic
References: <0.399206195@selenic.com> <4.399206195@selenic.com> <20060224221909.GD28855@flint.arm.linux.org.uk> <20060225065136.GH13116@waste.org> <20060225084955.GA27538@flint.arm.linux.org.uk> <20060225145412.GI13116@waste.org> <20060225180521.GB15276@flint.arm.linux.org.uk> <20060225210454.GL13116@waste.org> <20060225212247.GC15276@flint.arm.linux.org.uk> <20060225214704.GN13116@waste.org>
In-Reply-To: <20060225214704.GN13116@waste.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Sat, Feb 25, 2006 at 09:22:48PM +0000, Russell King wrote:
> 
>>init/do_mounts_rd.c:#include "../lib/inflate.c"
>>init/initramfs.c:#include "../lib/inflate.c"
>>
>>for these your arguments that halting is fine is _NOT_ correct nor is it
>>desirable.
> 
> 
> If you have an argument for why we shouldn't halt on failed
> init{rd,ramfs} decompression, I look forward to hearing it.

It depends on the nature of the error, and which parts were decompressed
successfully.  Gzip has optional "re-sync" capability, and ideally a
decompression failure might invoke some kind of bad-block tagging
for the output instead of halting the machine.  Some init{rd,ramfs}
have all the network drivers, all the SCSI drivers, all the sound
drivers, etc., but the user may care only about those for the current
machine.  Other init{rd,ramfs} contain only "essential" pieces.
Even then, the pieces that are deemed more important can be at the
beginning.  It might be possible to work without a sound driver,
but perhaps not without a SCSI driver.

> In my mind, being unable to decompress init* is every bit as fatal as
> being unable to mount root.

It may be possible to recover, at least partially, from one error
more than from another.  It would be nice if the decompressor itself
was a minor influence instead of a major one.

-- 
