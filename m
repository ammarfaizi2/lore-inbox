Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132077AbRCVQo1>; Thu, 22 Mar 2001 11:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132079AbRCVQoR>; Thu, 22 Mar 2001 11:44:17 -0500
Received: from [166.70.28.69] ([166.70.28.69]:36407 "EHLO flinx.biederman.org")
	by vger.kernel.org with ESMTP id <S132077AbRCVQoI>;
	Thu, 22 Mar 2001 11:44:08 -0500
To: Guest section DW <dwguest@win.tue.nl>
Cc: Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <3AB9313C.1020909@missioncriticallinux.com> <Pine.LNX.4.21.0103212047590.19934-100000@imladris.rielhome.conectiva> <20010322124727.A5115@win.tue.nl>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Mar 2001 09:41:56 -0700
In-Reply-To: Guest section DW's message of "Thu, 22 Mar 2001 12:47:27 +0100"
Message-ID: <m14rwl3gdn.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guest section DW <dwguest@win.tue.nl> writes:

> On Wed, Mar 21, 2001 at 08:48:54PM -0300, Rik van Riel wrote:
> > On Wed, 21 Mar 2001, Patrick O'Rourke wrote:
> 
> > > Since the system will panic if the init process is chosen by
> > > the OOM killer, the following patch prevents select_bad_process()
> > > from picking init.
> 
> There is a dozen other processes that must not be killed.
> Init is just a random example.

Not killing init provides enough for recovery if you truly hit
an out of memory situation.  With 2.4.x at least it is a box
misconfiguration that causes it.   The 2.2.x VM doesn't always try
to swap, and free things up hard enough, before reporting out of
memory.  But even the 2.2.x problems are rare.

> 
> > One question ... has the OOM killer ever selected init on
> > anybody's system ?
> 
> Last week I installed SuSE 7.1 somewhere.
> During the install: "VM: killing process rpm",
> leaving the installer rather confused.
> (An empty machine, 256MB, 144MB swap, I think 2.2.18.)

swap < RAM. ouch!  This is a misconfiguration on a machine that
actually starts swapping, and where out of memory problems are a
reality.  The fact an installer would trigger swapping on a 256MB
machine is a second problem. 

> Last month I had a computer algebra process running for a week.
> Killed. But this computation was the only task this machine had.
> Its sole reason of existence.
> Too bad - zero information out of a week's computation.
> (I think 2.4.0.)

It looks like you didn't have enough resources on that machine
period.  I pretty much trust 2.4.x in this department.  Did that
machine also have it's swap misconfigured?

> 
> Clearly, Linux cannot be reliable if any process can be killed
> at any moment. I am not happy at all with my recent experiences.

Hmm.  It should definitely not be at any moment.  It should only be
when resources are exhausted.  So putting enough swap on a machine
should be enough, to stop this from ever happening.

Eric
