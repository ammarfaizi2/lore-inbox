Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267387AbTAMPj3>; Mon, 13 Jan 2003 10:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267633AbTAMPj3>; Mon, 13 Jan 2003 10:39:29 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:53647 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267387AbTAMPjX>; Mon, 13 Jan 2003 10:39:23 -0500
Date: Mon, 13 Jan 2003 09:48:12 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <tridge@samba.org>
Subject: Re: [PATCH] Check compiler version, SMP and PREEMPT. 
In-Reply-To: <20030113065148.A685A2C07D@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0301130938500.24477-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, Rusty Russell wrote:

> I've only updated the x86 linker script, since the other archs'
> compile will break as soon as they set CONFIG_MODULES=y (there are 40
> linker scripts in the tree, and I don't want to patch them all again).
> 
> You now get:
> ext2: version magic 'non-SMP,preempt,gcc-2.95' != kernel 'SMP,preempt,gcc-2.95'

I mostly agree with this, in particular since I've been planning to 
reimplement module version checking (not modversions, though that's on the 
list, too) for some time now.

My plan was to first of all use the normal version string ("2.5.55-preX") 
and add letters for the critical config options, like "S" for SMP, "P" for 
preempt and so on. However, following this discussion, I suppose using 
entire words like "SMP", "preempt" etc is clearer and nobody cares about 
saving 10 bytes in vmlinux.

I think it may, as kaos pointed out, also be necessary to allow for
architecture specific config options, like the processor type.

The implementation I have in mind would not generate the special section 
with that string inside a header but rather add it during the "ld -o 
module.ko" step (one of the reasons why I introduced that), in order to 
avoid unnecessary recompiles when e.g. the version changes from "-preN" to 
"-preN+1", which was a major concern people had with the old module 
version string.

Do you agree on doing it that way?

--Kai



