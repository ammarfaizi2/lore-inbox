Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289355AbSAJJPG>; Thu, 10 Jan 2002 04:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289357AbSAJJO6>; Thu, 10 Jan 2002 04:14:58 -0500
Received: from mail1-gui.server.ntli.net ([194.168.222.13]:9961 "EHLO
	mail1-gui.server.ntli.net") by vger.kernel.org with ESMTP
	id <S289355AbSAJJOs>; Thu, 10 Jan 2002 04:14:48 -0500
Date: Thu, 10 Jan 2002 09:14:42 +0000
From: Nick Craig-Wood <ncw@axis.demon.co.uk>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Ivan Passos <ivan@cyclades.com>, Andrew Morton <akpm@zip.com.au>,
        "Michael H. Warfield" <mhw@wittsend.com>,
        David Weinehall <tao@acc.umu.se>, linux-kernel@vger.kernel.org
Subject: Re: Serial Driver Name Question (kernels 2.4.x)
Message-ID: <20020110091442.B9541@axis.demon.co.uk>
In-Reply-To: <200201062012.g06KCIu16158@vindaloo.ras.ucalgary.ca> <3C38BC19.72ECE86@zip.com.au> <200201070636.g076asR25565@vindaloo.ras.ucalgary.ca> <3C3A7DA7.381D033D@zip.com.au> <20020108071548.J5235@khan.acc.umu.se> <3C3A9048.CB80061A@zip.com.au> <20020108165851.B26294@alcove.wittsend.com> <3C3B6E96.8FB0341A@zip.com.au> <3C3B81D7.F1F43495@cyclades.com> <200201091636.g09GaU705860@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201091636.g09GaU705860@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Wed, Jan 09, 2002 at 09:36:30AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 09:36:30AM -0700, Richard Gooch wrote:
> Since you have to change all the drivers anyway, I'd prefer if
> _tty_make_name() was left unchanged, and instead you put the "%d" in
> each driver.name, thusly:
> #ifdef CONFIG_DEVFS_FS
> 	wod_driver.name = "tts/N%d";
> #else
> 	wod_driver.name = "ttyN%d";
> #endif
> 
> The reason: maximum flexibility in the kinds of names we can
> support. If for some reason we want a name like "tts/N%d_A" and
> "tts/N%d_B" (say a driver with linked ttys, like the pty driver), we
> don't need to make a global change.

I think that is a good idea.

However these names appear in /proc/devices too which looks rather
ugly running with devfs at the moment...

# cat /proc/devices 
Character devices:
  1 mem
  2 pty/m%d
  3 pty/s%d
  4 ttys/%d
  5 serial/%d
 10 misc
108 ppp
128 ptm
136 pts/%d
162 raw

-- 
Nick Craig-Wood
ncw@axis.demon.co.uk
