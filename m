Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965259AbWADS1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965259AbWADS1S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 13:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965261AbWADS1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 13:27:18 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:44433 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965259AbWADS1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 13:27:17 -0500
Subject: Re: 2.6.14.5 to 2.6.15 patch
From: Steven Rostedt <rostedt@goodmis.org>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <200601041756.52484.nick@linicks.net>
References: <200601041710.37648.nick@linicks.net>
	 <9a8748490601040950q2b2691f5l7577b52417b4c50b@mail.gmail.com>
	 <Pine.LNX.4.58.0601040950530.19134@shark.he.net>
	 <200601041756.52484.nick@linicks.net>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 13:27:10 -0500
Message-Id: <1136399230.12468.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 17:56 +0000, Nick Warne wrote:
> On Wednesday 04 January 2006 17:51, Randy.Dunlap wrote:
> 
> >
> > but the incremental patches do appear to be in
> >   http://www.kernel.org/pub/linux/kernel/v2.6/incr/
> >
> > who generates these?  are they automated?
> 
> OMG - am I the only person in the world to be H4><0R3D from kernel.org...

I still find ketchup the easiest solution:

Here's a cut and paste of what I did.  The commands that I did was as
follows:

1) mkdir tmp
2) cd tmp
3) ketchup -r -G -f 2.6.14

# comment
#   -r is rename the directory
#   -G is to not verify against PGP keys
#   -f is to force downloading a tar ball instead of using linux-2.6.13.tar.bz2
#      and patch against it.

4) cd .
5) head Makefile
6) ketchup -r -G 2.6.14.1

# comment
#   here I removed the -f since I now want to patch

7) cd .
8) head Makefile
9) ketchup -r -G 2.6.14.5
10) cd .
11) head Makefile
12) ketchup -r -G 2.6.15
13) cd .
14) head Makefile

It's as easy as that.  The above commands put me through 4 different
versions of Linux.  And the "cd ." and "head Makefile" was only done to
show that ketchup worked.


---
rostedt@gandalf:~$ mkdir tmp
rostedt@gandalf:~$ cd tmp
rostedt@gandalf:~/tmp$ ketchup -r -G -f 2.6.14
None -> 2.6.14
Downloading linux-2.6.14.tar.bz2
--13:12:54--  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.14.tar.bz2
           => `/home/rostedt/.ketchup/linux-2.6.14.tar.bz2.partial'
Resolving www.kernel.org... 204.152.191.5, 204.152.191.37
Connecting to www.kernel.org|204.152.191.5|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 39,172,170 (37M) [application/x-bzip2]

100%[====================================>] 39,172,170   523.51K/s    ETA 00:00

13:14:09 (511.71 KB/s) - `/home/rostedt/.ketchup/linux-2.6.14.tar.bz2.partial' saved [39172170/39172170]

Unpacking linux-2.6.14.tar.bz2
Current directory renamed to /home/rostedt/linux-2.6.14
rostedt@gandalf:~/tmp$ cd .
rostedt@gandalf:~/linux-2.6.14$ head Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 14
EXTRAVERSION =
NAME=Affluent Albatross

# *DOCUMENTATION*
# To see a list of typical targets execute "make help"
# More info can be located in ./README
# Comments in this file are targeted only to the developer, do not
rostedt@gandalf:~/linux-2.6.14$ ketchup -r -G 2.6.14.1
2.6.14 -> 2.6.14.1
Downloading patch-2.6.14.1.bz2
--13:16:38--  http://www.kernel.org/pub/linux/kernel/v2.6/patch-2.6.14.1.bz2
           => `/home/rostedt/.ketchup/patch-2.6.14.1.bz2.partial'
Resolving www.kernel.org... 204.152.191.5, 204.152.191.37
Connecting to www.kernel.org|204.152.191.5|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 2,808 (2.7K) [application/x-bzip2]

100%[====================================>] 2,808         --.--K/s

13:16:39 (29.14 KB/s) - `/home/rostedt/.ketchup/patch-2.6.14.1.bz2.partial' saved [2808/2808]

Applying patch-2.6.14.1.bz2
Current directory renamed to /home/rostedt/linux-2.6.14.1
rostedt@gandalf:~/linux-2.6.14$ cd .
rostedt@gandalf:~/linux-2.6.14.1$ head Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 14
EXTRAVERSION = .1
NAME=Affluent Albatross

# *DOCUMENTATION*
# To see a list of typical targets execute "make help"
# More info can be located in ./README
# Comments in this file are targeted only to the developer, do not
rostedt@gandalf:~/linux-2.6.14.1$ ketchup -r -G 2.6.14.5
2.6.14.1 -> 2.6.14.5
Applying patch-2.6.14.1.bz2 -R
Downloading patch-2.6.14.5.bz2
--13:16:50--  http://www.kernel.org/pub/linux/kernel/v2.6/patch-2.6.14.5.bz2
           => `/home/rostedt/.ketchup/patch-2.6.14.5.bz2.partial'
Resolving www.kernel.org... 204.152.191.37, 204.152.191.5
Connecting to www.kernel.org|204.152.191.37|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 24,110 (24K) [application/x-bzip2]

100%[====================================>] 24,110        73.62K/s

13:16:51 (73.44 KB/s) - `/home/rostedt/.ketchup/patch-2.6.14.5.bz2.partial' saved [24110/24110]

Applying patch-2.6.14.5.bz2
Current directory renamed to /home/rostedt/linux-2.6.14.5
rostedt@gandalf:~/linux-2.6.14.1$ cd .
rostedt@gandalf:~/linux-2.6.14.5$ head Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 14
EXTRAVERSION = .5
NAME=Affluent Albatross

# *DOCUMENTATION*
# To see a list of typical targets execute "make help"
# More info can be located in ./README
# Comments in this file are targeted only to the developer, do not
rostedt@gandalf:~/linux-2.6.14.5$ ketchup -r -G 2.6.15
2.6.14.5 -> 2.6.15
Applying patch-2.6.14.5.bz2 -R
Downloading patch-2.6.15.bz2
--13:17:03--  http://www.kernel.org/pub/linux/kernel/v2.6/patch-2.6.15.bz2
           => `/home/rostedt/.ketchup/patch-2.6.15.bz2.partial'
Resolving www.kernel.org... 204.152.191.5, 204.152.191.37
Connecting to www.kernel.org|204.152.191.5|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 6,254,721 (6.0M) [application/x-bzip2]

100%[====================================>] 6,254,721    377.90K/s    ETA 00:00

13:17:18 (436.92 KB/s) - `/home/rostedt/.ketchup/patch-2.6.15.bz2.partial' saved [6254721/6254721]

Applying patch-2.6.15.bz2
Current directory renamed to /home/rostedt/linux-2.6.15
rostedt@gandalf:~/linux-2.6.14.5$ cd .
rostedt@gandalf:~/linux-2.6.15$ head Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 15
EXTRAVERSION =
NAME=Sliding Snow Leopard

# *DOCUMENTATION*
# To see a list of typical targets execute "make help"
# More info can be located in ./README
# Comments in this file are targeted only to the developer, do not
rostedt@gandalf:~/linux-2.6.15$
---

-- Steve


