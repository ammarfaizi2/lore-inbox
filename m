Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131832AbRDWUvK>; Mon, 23 Apr 2001 16:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131887AbRDWUvB>; Mon, 23 Apr 2001 16:51:01 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:14096 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131830AbRDWUur>; Mon, 23 Apr 2001 16:50:47 -0400
Date: Mon, 23 Apr 2001 14:44:21 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: filp_open() in 2.2.19 causes memory corruption
Message-ID: <20010423144421.A32742@vger.timpanogas.org>
In-Reply-To: <001d01c0cc33$7e62daa0$5517fea9@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <001d01c0cc33$7e62daa0$5517fea9@local>; from manfred@colorfullife.com on Mon, Apr 23, 2001 at 10:24:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 10:24:55PM +0200, Manfred Spraul wrote:
> Are you sure the trace is decoded correctly?
> 
> > CPU:    0 
> > EIP:    0010:[sys_mremap+31/884] 
> > EFLAGS: 00010206
> 
> > Code: ac ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 75 d9
> ac ae is
> lodsb
> scasb
> 
> Could you run
> #objdump --disassemble-all --reloc linux/mm/mremap.o | less
> 
> and check that the code is really at offset 31 of sys_mremap?
> 
> And is it correct that only 64 MB memory is installed/enabled?
> 
> --
>     Manfred


Manfred,

This is what's being reported when I produce the oops.  I think we have 
memory corruption somewhere, which explains the funky code offsets.  It's
easy to reproduce.  Call filp_open with the handle table I gave you 
on a single IDE system with **NO** tape drive in the system, and it 
crashes quite after the module is loaded the fisrt time, then unloaded,
and reloaded a second time.  The oops happens on the second insmod 
of the module.  I can provide you the actual module itself built with
all the code if you want to reproduce it. 

It's 100% reproduceable.

Jeff

> 
