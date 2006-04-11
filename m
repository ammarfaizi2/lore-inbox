Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWDKQPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWDKQPK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 12:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWDKQPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 12:15:10 -0400
Received: from odin2.bull.net ([129.184.85.11]:14819 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S1750858AbWDKQPI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 12:15:08 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: PREEMPT_RT : 2.6.16-rt12 and boot : BUG ?
Date: Tue, 11 Apr 2006 18:15:25 +0200
User-Agent: KMail/1.7.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200604061416.00741.Serge.Noiraud@bull.net> <200604061705.36303.Serge.Noiraud@bull.net> <200604101446.13610.Serge.Noiraud@bull.net>
In-Reply-To: <200604101446.13610.Serge.Noiraud@bull.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604111815.25494.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	It now works with all config parameters set to yes on 2.6.16-rt16.
however, PERCPU_ENOUGH_ROOM is set to 384KB.
I'm now trying to lower this value of PERCPU_ENOUGH_ROOM.
With 256K and 2.6.16-rt16 : doesn't work.
With 320K : OK
So I need to use 320K for PERCPU_ENOUGH_ROOM to boot correctly.

I have several questions :
Is there a problem in my config file ?
Will this memory freed at end of kernel loading ?
Why do we need such a size ?
What usage is this for ?

lundi 10 Avril 2006 14:46, Serge Noiraud wrote/a écrit :
> jeudi 6 Avril 2006 17:05, Serge Noiraud wrote/a écrit :
> > jeudi 6 Avril 2006 16:31, Ingo Molnar wrote/a écrit :
> > > 
> > > * Serge Noiraud <serge.noiraud@bull.net> wrote:
> > > 
> > > > input: ImPS/2 Generic Wheel Mouse as /class/input/input1
> > > > VFS: Mounted root (ext2 filesystem).
> > > > Fusion MPT base driver 3.03.07
> > > > Copyright (c) 1999-2005 LSI Logic Corporation
> > > > Could not allocate 8 bytes percpu data
> > > > mptscsih: Unknown symbol scsi_remove_host
> > > 
> > > could you increase (double) PERCPU_ENOUGH_ROOM in 
> > > include/linux/percpu.h, does that solve this problem? (and make sure you 
> > > use -rt13, -rt12 had a couple of bugs)
> > Tested with rt12 and 192K : same problem
> > Tested with rt12 and 256K : same problem.
> > Tested with rt13 and 256K : same problem.
> > I'm currently compiling with CONFIG_KALLSYMS_ALL not set.
> Same thing.
> 
> The boot succeed if I set CONFIG_CRITICAL_IRQSOFF_TIMING to no.
> If I set this parameter to yes, I get the scsi unresolved symbols.
> PERCPU_ENOUGH_ROOM  is actually set to 256K.
> I'll try to set the original value.
it didn't work with CONFIG_CRITICAL_IRQSOFF_TIMING  set to no and PERCPU_ENOUGH_ROOM  = 128K.
> 
> I don't see the relation between this parameter and the missing scsi symbols resolution.
> Timing problem ?
> 
> > > 
> > > 	Ingo
> 

-- 
Serge Noiraud
