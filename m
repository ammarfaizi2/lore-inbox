Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261709AbTCQCEY>; Sun, 16 Mar 2003 21:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261707AbTCQCEY>; Sun, 16 Mar 2003 21:04:24 -0500
Received: from sdfw-ext.castandcrew.com ([63.113.17.130]:25331 "EHLO
	sddev.castandcrew.com") by vger.kernel.org with ESMTP
	id <S261709AbTCQCEV>; Sun, 16 Mar 2003 21:04:21 -0500
From: "Gregory K. Ruiz-Ade" <gregory@castandcrew.com>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20 instability on bigmem systems?
Date: Sun, 16 Mar 2003 18:15:11 -0800
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200303131627.22572.gregory@castandcrew.com> <200303140931.15541.gregory@castandcrew.com> <20030314200857.GL20188@holomorphy.com>
In-Reply-To: <20030314200857.GL20188@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303161815.11973.gregory@castandcrew.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 March 2003 12:08, William Lee Irwin III wrote:
> On Fri, Mar 14, 2003 at 09:31:15AM -0800, Gregory K. Ruiz-Ade wrote:
> > Ahh.  I was a bit out of it yesterday, and didn't think to actually
> > stress the machine. :\
> > I'll be able to give it a good beating this weekend sometime.
>
> cc: me when you post those results.

Okay, I tried to load the system a bit and stress out the disk I/O, running 
a couple finds across the whole system (find | xargs stat, find | xargs cat 
> /dev/null, a couple other things) after sucking up free memory by catting 
our database disk files to /dev/null.  I also had a 'make -j5 clean 
oldconfig dep bzImage modules' running to try to drive the load up a bit, 
too.

I've got snapshots of meminfo, slabinfo, and output from 'ps auxfww' at:

http://castandcrew.com/~gregory/lkmlstuff/burpr/2.4.20/loadtest/

It only really starts getting interesting after 20030316.1725, when I 
started the kernel build.  I have a very simple shell script that basically 
does nothing other than "make clean oldconfig dep && make -j5 bzImage && 
make -j5 modules".  I ran that a couple times in the sources for Red Hat's 
2.4.9-e.12 kernel sources.

Surprisingly I wasn't able to grind down the system like I expected.  Not 
sure why it's behaving so wonderfully today.

It crashed again on Friday night, running 2.4.19.  The only information I 
was able to get was a kernel BUG message on the serial console (I 
ksymoops'ed it after rebooting).  From what I could tell after the fact, 
nothing was really running.  Several scripts got fired off by cron, which 
check various things (mainly to make sure certain services are still 
running), and around then is when the system locked up.  The info I have 
for that crash is at:

http://castandcrew.com/~gregory/lkmlstuff/burpr/2.4.19

As it is, I'm going to try running on Red Hat's 2.4.9-e.12 sources this 
week.  I'm compiling the kernel right now, and will be rebooting into it 
shortly.

This has been quite the week of headaches for me.

-- 
Gregory K. Ruiz-Ade <gregory@castandcrew.com>
Sr. Systems Administrator
Cast & Crew Entertainment Services, Inc.

