Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315758AbSHIUgd>; Fri, 9 Aug 2002 16:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315760AbSHIUgd>; Fri, 9 Aug 2002 16:36:33 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:56312 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S315758AbSHIUgc>;
	Fri, 9 Aug 2002 16:36:32 -0400
Date: Fri, 9 Aug 2002 22:40:11 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Paul Larson <plars@austin.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Hubertus Franke <frankeh@us.ibm.com>,
       Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
       andrea@suse.de, Dave Jones <davej@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
Message-ID: <20020809204011.GA1241@win.tue.nl>
References: <Pine.LNX.4.44.0208081500550.9114-100000@home.transmeta.com> <1028921658.19434.365.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028921658.19434.365.camel@plars.austin.ibm.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 02:34:17PM -0500, Paul Larson wrote:

> I suspect that it would actually require more than just this.  I tried
> this with the same test I've been using and had several failed attepmts
> at low numbers by getting wierd unexpected signals (like 28), and then
> one that ran for a much longer time and produced an oops with random
> garbage to the console (trying to extract this now).

Not much more. Around 2.3.40 I have run with a large PID_MAX for a long time.
The patch that I submitted is still visible on the net various places
(I just tried  Andries pid_max  and found a few).

At that time the only other change (other than <linux/threads.h> and
kernel/fork.c) was in proc/base.c, namely

	-#define fake_ino(pid,ino) (((pid)<<16)|(ino)) 
	+#define fake_ino(pid,ino) (((1)<<16)|(ino)) 

and

	- if (!pid) 
	-         goto out; 
	- if (pid & 0xffff0000) 
	+ if (pid <= 0 || pid >= PID_MAX) 
                  goto out; 

(plucked from google output).

I have not checked precisely what change is appropriate in procfs today.


Andries
