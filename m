Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbSI2UzE>; Sun, 29 Sep 2002 16:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261804AbSI2UzE>; Sun, 29 Sep 2002 16:55:04 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:48814 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S261799AbSI2UzD>; Sun, 29 Sep 2002 16:55:03 -0400
Date: Sun, 29 Sep 2002 23:00:21 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: John Levon <levon@movementarian.org>
cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] break out task_struct from sched.h
In-Reply-To: <20020929201331.GA90617@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.33.0209292242470.7949-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2002, John Levon wrote:

> On Sun, Sep 29, 2002 at 09:50:48PM +0200, Tim Schmielau wrote:
> 
> > This patch separates struct task_struct from <linux/sched.h> to 
> > a new header <linux/task_struct.h>, so that dereferencing 'current'
> > doesn't require to #include <linux/sched.h> and all of the 138 files it 
> > drags in.
> 
> It seems a bit odd to me that you /only/ split out task_struct but none
> of the simple helpers (for_each_process(), task_lock,
> set_task_state etc.). I'd prefer a task.h personally, many of these can
> be placed without further burdening the include nest.

You're right.
I had the vague hope that by separating type definitions only
some future cleanup might help us to cut down on the number of
headers included by task_struct.h (currently 60).
Introducing a full-blown task.h looks like killing sched.h completely
after suficcient cleanup, which might be a route worth going.

> 
> It'd certainly be nice to see sched.h properly cleaned up at some point
> (request_irq() ??? d_path() ???)

Definitely. request_irq() and free_irq() look like candidates for
<linux/interrupt.h> or a new <linux/irq.h> (it was suggested to move the 
old <linux/irq.h> to <asm-generic/hw_irq.h>).

Killing ~600 #include <linux/sched.h> lines however seemed enough for a 
first round, so I left this for later iterations.

Tim

