Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265729AbRFXEro>; Sun, 24 Jun 2001 00:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265725AbRFXEqx>; Sun, 24 Jun 2001 00:46:53 -0400
Received: from [203.143.19.4] ([203.143.19.4]:15365 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S265726AbRFXEqq>;
	Sun, 24 Jun 2001 00:46:46 -0400
Date: Sun, 24 Jun 2001 09:20:38 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Mike Galbraith <mikeg@wen-online.de>,
        Rik van Riel <riel@conectiva.com.br>, Pavel Machek <pavel@suse.cz>,
        John Stoffel <stoffel@casc.com>,
        Roger Larsson <roger.larsson@norran.net>, thunder7@xs4all.nl,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Early flush (was: spindown)
Message-ID: <20010624092038.A242@bee.lk>
In-Reply-To: <Pine.LNX.4.33.0106171156410.318-100000@mikeg.weiden.de> <01061816220503.11745@starship> <01062003503300.00439@starship> <993070731.3b310e8b4e51e@eargle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <993070731.3b310e8b4e51e@eargle.com>; from ttsig@tuxyturvy.com on Wed, Jun 20, 2001 at 04:58:51PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Jun 20, 2001 at 04:58:51PM -0400, Tom Sightler wrote:
> 
> 1.  When running a compile, or anything else that produces lots of small disk
> writes, you tend to get lots of little pauses for all the little writes to disk.
>  These seem to be unnoticable without the patch.
> 
> 2.  Loading programs when writing activity is occuring (even light activity like
> during the compile) is noticable slower, actually any reading from disk is.
> 
> I also ran my simple ftp test that produced the symptom I reported earlier.  I
> transferred a 750MB file via FTP, and with your patch sure enough disk writing
> started almost immediately, but it still didn't seem to write enough data to
> disk to keep up with the transfer so at approximately the 200MB mark the old
> behavior still kicked in as it went into full flush mode, during the time
> network activity halted, just like before.

It is not uncommon to have a large number of tmp files on the disk(s) (Rik also
pointed this out somewhere early in the original thread) and it is sensible to
keep all of them in buffers if RAM is sufficient. Transfering _very_ large
files is not _that_ common so why shouldn't that case be handled from the user
space by calling sync(2)?

Anuradha

-- 

Debian GNU/Linux (kernel 2.4.6-pre5)

Keep cool, but don't freeze.
		-- Hellman's Mayonnaise

