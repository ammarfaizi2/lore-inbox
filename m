Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275393AbRIZSGL>; Wed, 26 Sep 2001 14:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275392AbRIZSGB>; Wed, 26 Sep 2001 14:06:01 -0400
Received: from [213.96.124.18] ([213.96.124.18]:7403 "HELO dardhal")
	by vger.kernel.org with SMTP id <S275393AbRIZSFz>;
	Wed, 26 Sep 2001 14:05:55 -0400
Date: Wed, 26 Sep 2001 20:08:33 +0000
From: =?iso-8859-1?Q?Jos=E9_Luis_Domingo_L=F3pez?= 
	<jdomingo@internautas.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Paul <set@pobox.com>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: 2.4.10 much better than previous 2.4.x :-)
Message-ID: <20010926200833.A1859@dardhal.mired.net>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>, Paul <set@pobox.com>,
	Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <1001377785.1430.7.camel@gromit.house> <Pine.LNX.4.33L.0109242234410.19147-100000@imladris.rielhome.conectiva> <20010925203515.A227@squish.home.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010925203515.A227@squish.home.loc>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 25 September 2001, at 20:35:15 -0400,
Paul wrote:

> Rik van Riel <riel@conectiva.com.br>, on Mon Sep 24, 2001 [10:35:53 PM] said:
> > 
> > If you have the time, could you also test 2.4.9-ac15 ?
> > [...]
> 	Im not complaining-- Im just curious why no OOM killing, 
> and the Mem stats report 337148k swap free (I have 337168k).
> Does this memmory report look  proper for a machine thrashing
> itself to death from endless mallocs?
> 
I've done several test with various versions of 2.4.x kernels, just to
make sure OOM worked right or not. I've used setups with both swap and no
swap, with swap double the RAM and equal to it, from a single user mode
and full multiuser with tons of applications running.

To reach OOM I try one of two methods: first, the well-know glob() DoS 
(ls ../*/../*/../*/ etc), second, starting as many applications as I can,
loading and creating huge images with gimp, etc.

In my test, OOM seems to work well most of the time, but not always. When
in works, it works fine, that is, it doesn't kill applications too early,
and (in recent kernel), multithreaded applications (like mozilla and
staroffice) and fully wiped from memory ("old" 2.4.x kernels didn't kill
all the threads, just the selected process ID).

When OOM doesn't work, the disk starts spinning like crazy, responsiveness
in null, mouse doesn't move, consoles don't update, unability to switch to
text consoles, etc. Giving time to the machine to recover itself is not
helpful: after more than 15 minutes the disk continue to spin and sound
like they were to inmediately crash :)

But in this situation, SysRq+K work fine most of the times: in a couple of
seconds the disk stops its crazyness, and the machine recovers. The text
console is unusable (can't display a thing), but issuing a "startx"
blindly works as expected, as if nothing had happened.

I've tried playing with "freepages" tunnable (where it exists), to raise
limits and (hopefully) keep more RAM free for the kernel for the hard
times where it tries to recover from OOM. OOM still fails sometimes, but
maybe I don't understand what freepages.[min|low|high] mean (having read
documentation under linux/Documentation :)

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

