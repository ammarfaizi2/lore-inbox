Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129910AbRBPO3Z>; Fri, 16 Feb 2001 09:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130268AbRBPO3P>; Fri, 16 Feb 2001 09:29:15 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:11596 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129910AbRBPO3E>; Fri, 16 Feb 2001 09:29:04 -0500
Date: Fri, 16 Feb 2001 15:29:14 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Roman Zippel <zippel@fh-brandenburg.de>,
        Timur Tabi <ttabi@interactivesi.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
Message-ID: <20010216152914.K14430@inspiron.random>
In-Reply-To: <20010129182633.A2522@gruyere.muc.suse.de> <Pine.GSO.4.10.10101292036070.17869-100000@zeus.fh-brandenburg.de> <20010129213553.A6552@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010129213553.A6552@gruyere.muc.suse.de>; from ak@suse.de on Mon, Jan 29, 2001 at 09:35:53PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2001 at 09:35:53PM +0100, Andi Kleen wrote:
> On Mon, Jan 29, 2001 at 08:47:50PM +0100, Roman Zippel wrote:
> > You still miss wakeups. :)
> 
> And there was another race in it, I know.  The first __set_task_state
> has to be set_task_state to get the right memory write order on SMP. 

If the wakeup is serialized by the spinlock too (as your code looks like to
assume) you can legally use __set_task_state instead of set_task_state.  An
example of such an usage (where wakeup is serialized by the spinlock) is
lock_sock/unlock_sock.

Andrea
