Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318278AbSIBLNh>; Mon, 2 Sep 2002 07:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318282AbSIBLNh>; Mon, 2 Sep 2002 07:13:37 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:17927 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S318278AbSIBLNf>; Mon, 2 Sep 2002 07:13:35 -0400
Date: Mon, 2 Sep 2002 09:39:10 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Benchmarks for performance patches (-ck) for 2.4.19
Message-ID: <20020902093910.G781@nightmaster.csn.tu-chemnitz.de>
References: <Pine.LNX.4.44L.0209012327360.1857-100000@imladris.surriel.com> <3D72E267.6090502@wmich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3D72E267.6090502@wmich.edu>; from ed.sweetman@wmich.edu on Mon, Sep 02, 2002 at 12:00:39AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ed,
Hi Rik,
Hi lkml,

On Mon, Sep 02, 2002 at 12:00:39AM -0400, Ed Sweetman wrote:
> I dont experience audio cutouts with anything i do, even the really 
> abusive things to the computer.  I've only had it cut out when using 
> bonnie or dbench and that's something you should expect. So what i see 
> as responsiveness is switching windows on the same desktop and switching 
> between virtual desktops.  I see responsiveness as the time between i do 
> something and the time it takes to redraw it. Using a G450, I expect a 
> certain level of hardware performance and half a second or so to redraw 
> a screen is not what i call responsive for a Tbird system. This is of 
> course all X related because i dont see much or any problem with the 
> console and with the kernel. At least nothing compared to X latencies.
 
This is not only X. The problem is the software layering bloat.
Thats a design mistake we copied from W*ndows in our Linux
applications.

Take your favorite - and I mean your favorite, not the easiest -
application, find the handler for the problem event, try to do a
really complete call graph trough all software layers involved
(say from read(inputdevice_fd) to get the event up to
write(outputdevice_fd) to write to the framebuffer) and count
cycles. Don't forget the cache misses due to following pointers,
which lead to random, non-local memory access patterns 
(read: a VM and cache nightmare).

Once you really finish this boring task completely you know our
real performance problem.

Felix von Leitner did a nice presentation on our 
Chemnitzer Linux Tag (but in German) and many experienced
programmers and software enginieers were really stunned.

So the problem is not really the kernel or the X layer. The
NUMBER of abstraction layers is the issue to attack.

People tend to import big bloated libraries or even completely
overkill operating systems just because it has ONE SIMPLE
property the actually need[1]. This must change.


Regards

Ingo Oeser

[1] Buying/Reselling Windows NT licenses + some Windows FTP
   server license just because we need FTP. Buying WinCE
   licenses, just because the embedded device must be able to be
   accessible via TCP/IP. More examples available per private
   mail. Stupidity has no limit here.
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
