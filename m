Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281017AbRKGWJh>; Wed, 7 Nov 2001 17:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281018AbRKGWJ3>; Wed, 7 Nov 2001 17:09:29 -0500
Received: from vega.ipal.net ([206.97.148.120]:38856 "HELO vega.ipal.net")
	by vger.kernel.org with SMTP id <S280997AbRKGWJN>;
	Wed, 7 Nov 2001 17:09:13 -0500
Subject: Re: "ps ax" shows init [
To: linux-kernel@vger.kernel.org
Date: Wed, 7 Nov 2001 16:09:12 -0600 (CST)
In-Reply-To: <9sbmcs$t4t$1@ncc1701.cistron.net> from "Miquel van Smoorenburg" at Nov 07, 2001 04:10:04 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011107220912.48029240@vega.ipal.net>
From: phil-linux-kernel@ipal.net (Phil Howard)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:

> In article <Pine.LNX.4.10.10111071747430.31120-100000@ares.sot.com>,
> Yaroslav Popovitch  <yp@sot.com> wrote:
> >doing "ps ax" get such msg for kernel-2.4.9:
> >That is the same for kernel-2.4.12.Sometimes it is shown as it should be.
> >Is this a bug of kernel? It seems to be..
> >
> >  PID TTY      STAT   TIME COMMAND
> >    1 ?        S      0:06 init [    
> 
> It's because init doesn't have enough space in argv[] to change it's
> process title. There are a number of causes for this, one indirect
> one is pressing 'enter' at the 'LILO boot: ' prompt.

Perhaps a way around this frequent problem is to make execve() always
reserve a certain minimum amount of space in argv[] even if it is not
filled in with anything.  Then instead a "brick wall" being set at
the end of the space originally used, it can be set at max(space used,
minimum reserved).  This is still userland space, right?  What would
be a reasonable figure for minimum reserved?  Or does ld-linux go
grabbing space right after the end of argv[]?

-- 
-----------------------------------------------------------------
| Phil Howard - KA9WGN |   Dallas   | http://linuxhomepage.com/ |
| phil-nospam@ipal.net | Texas, USA | http://phil.ipal.org/     |
-----------------------------------------------------------------
