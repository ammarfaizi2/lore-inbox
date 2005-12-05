Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbVLEQDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVLEQDY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 11:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVLEQDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 11:03:24 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:37275
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932450AbVLEQDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 11:03:23 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Sun, 4 Dec 2005 21:23:02 -0600
User-Agent: KMail/1.8
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <1133620598.22170.14.camel@laptopd505.fenrus.org> <20051203152339.GK31395@stusta.de>
In-Reply-To: <20051203152339.GK31395@stusta.de>
MIME-Version: 1.0
Message-Id: <200512042123.03012.rob@landley.net>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XK7kD3ANl5X+xKT"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_XK7kD3ANl5X+xKT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 03 December 2005 09:23, Adrian Bunk wrote:
> IOW, we should e.g. ensure that today's udev will still work flawlessly
> with kernel 2.6.30 (sic)?

A) udev changing its interface every three months isn't the kernel's fault, 
it's udev's.  Heck,  udev doesn't even accept a dependency on an external 
libsys but instead bundles its own copy in there because obviously the proper 
way to use a shared library is to block copy it into the source tree of every 
potential user.  Its config file format keeps changing.  What commands you 
run to invoke it keeps changing.  What does that have to do with the kernel?

Attached is a shell script that does the basics of what udev does.  (No, it 
doesn't handle permissions or persistent naming.  But it also doesn't show a 
lot of version dependencies, does it?)

B) When I install new packages I have to update dependencies like SDL or zlib 
all the time, yet you believe the kernel isn't allowed to have dependencies?  
Not even on things like modprobe or glibc that interface to the kernel not 
just graphically but "with tongue", as it were?  (Despite that, they're 
pretty darn good at staying compatible anyway.)

> This could work, but it should be officially announced that e.g. a
> userspace running kernel 2.6.15 must work flawlessly with _any_ future
> 2.6 kernel.

Oh don't start throwing around "must" and "officially announced" as if those 
terms actually mean something.

If you can come up with a compelling proposal and implement it and attract 
followers, fine.  You don't need to grab a flag and get blessed by somebody 
else to do anything.  (Whose flag and blessing did Linus get way back when?  
And where the heck did Ubuntu or Gentoo come from?)

The _right_ way to do this would have been to announce that you are 
maintaining a new tree, a -stable fork of whatever release, and give a URL to 
where it can be downloaded.  Announce code, not intentions.  (Announcing 
intentions never works.  Code attracts code and talk attracts talk.)  And that 
way the difficulty and sustainability of your task becomes self-apparent.

By the way, I'll guarantee you I can configure a 2.6.15 kernel that your 
userspace won't work with, with no code changes.  (To start with, I'd yank 
elf and force you to use a.out executable format...)

> For how many years do you think we will be able to ensure that this will
> stay true?

Who is "we", kemosabe?

> cu
> Adrian

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.

--Boundary-00=_XK7kD3ANl5X+xKT
Content-Type: application/x-shellscript;
  name="setupdev.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="setupdev.sh"

#!/bin/sh

mount -t tmpfs /tmp /tmp
mount -t tmpfs /dev /dev

function makedev
{
  dev=`echo "$1" | sed 's .*/\(.*\)/dev \1 '`
  minor=`cat "$1" | sed 's .*:  '`
  major=`cat "$1" | sed 's :.*  '`
  mknod -m 600 /dev/"$dev" $2 $major $minor
}

for i in `find /sys/block -name "dev"`
do
  makedev "$i" b &&
  echo -n b
done &&
for i in `find /sys/class -name "dev"`
do
  makedev "$i" c &&
  echo -n c
done &&
echo

--Boundary-00=_XK7kD3ANl5X+xKT--
