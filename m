Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262193AbSJARuK>; Tue, 1 Oct 2002 13:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262195AbSJARuK>; Tue, 1 Oct 2002 13:50:10 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:22411 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262193AbSJARuJ>; Tue, 1 Oct 2002 13:50:09 -0400
Date: Tue, 1 Oct 2002 12:55:25 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
In-Reply-To: <Pine.LNX.4.44.0210011653370.28821-102000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210011251050.10307-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, Ingo Molnar wrote:

> 2) driver fixes.
> 
> i have converted almost every affected driver to the new framework. This
> cleaned up tons of code. I also fixed a number of drivers that were still
> using BHs (these drivers did not compile in 2.5.40).

I'm possibly messing things up here, but doesn't it generally make more 
sense to convert tq_immediate users to tasklets instead of work queues?

tq_immediate users do not need process context, and one use I'm familiar 
with is basically doing bottom half interrupt processing, e.g. in lots of 
places in the ISDN code. Introducing a context switch for no obvious gain 
there seems rather pointless to me?

The same may be true for the tq_timer users as well?

--Kai


