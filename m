Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266622AbTBPM77>; Sun, 16 Feb 2003 07:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266640AbTBPM77>; Sun, 16 Feb 2003 07:59:59 -0500
Received: from dp.samba.org ([66.70.73.150]:21909 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266622AbTBPM77>;
	Sun, 16 Feb 2003 07:59:59 -0500
Date: Mon, 17 Feb 2003 00:05:58 +1100
From: Anton Blanchard <anton@samba.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.5.61 oops running SDET
Message-ID: <20030216130558.GL9833@krispykreme>
References: <Pine.LNX.4.44.0302151820200.25000-100000@home.transmeta.com> <11830000.1045368054@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11830000.1045368054@[10.10.2.4]>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> OK, I did the following, which is what I think you wanted, plus Zwane's
> observation that task_state acquires the task_struct lock (we're the only 
> caller, so I just removed it), but I still get the same panic and this time
> the box hung. No doubt I've just done something stupid in the patch ...
> (task_state takes the tasklist_lock ... is that safe to do inside task_lock?)

It looks like you now try and take the tasklist_lock inside a task_lock()
region, but task_lock says no-can-do:

/* Protects ->fs, ->files, ->mm, and synchronises with wait4().  Nests
 * inside tasklist_lock */
static inline void task_lock(struct task_struct *p)
{
...

Anton
