Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317591AbSFIKDn>; Sun, 9 Jun 2002 06:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317592AbSFIKDm>; Sun, 9 Jun 2002 06:03:42 -0400
Received: from dialin-145-254-152-251.arcor-ip.net ([145.254.152.251]:20016
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S317591AbSFIKDm> convert rfc822-to-8bit; Sun, 9 Jun 2002 06:03:42 -0400
Message-ID: <3D0328D2.8CD47269@loewe-komp.de>
Date: Sun, 09 Jun 2002 12:07:14 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.79 [de] (X11; U; Linux 2.4.18-4GB-SMP i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        frankeh@watson.ibm.com, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Futex Asynchronous Interface
In-Reply-To: <Pine.LNX.4.44.0206081523410.11630-100000@home.transmeta.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds schrieb:
> 
> On Fri, 7 Jun 2002, Peter Wächtler wrote:
> >
> > What about /proc/futex then?
> 
> Why?
> 
> Tell me _one_ advantage from having the thing exposed as a filename?
> 

There is no enforcing advantage for this.

newbie question: how to provide file operations like poll
without an entry in the filesystem? (in the meantime I will try
to answer this myself :)

> The whole point with "everything is a file" is not that you have some
> random filename (indeed, sockets and pipes show that "file" and "filename"
> have nothing to do with each other), but the fact that you can use common
> tools to operate on different things.
> 
> But there's absolutely no point in opening /dev/futex from a shell script
> or similar, because you don't get anything from it. You still have to bind
> the fd to it's real object.
> 
> In short, the name "/dev/futex" (or "/proc/futex") is _meaningless_.
> There's no point to it. It has no life outside the FUTEX system call, and
> the only thing that you can do by exposing it as a name is to cause
> problems for people who don't want to mount /proc, or who do not happen to
> have that device node in their /dev.
> 
> > Give it an entry in the namespace, why not with sockets (unix and ip) also?
> 
> Perhaps because you cannot enumerate sockets and pipes? They don't _have_
> names before they are created. Same as futexes, btw.
> 

Still you can open a file in the namespace and write some commands to it.
Then it turns out to be a socket on port 25:

fd=open("/dev/socket",O_RDWR);
write(fd,"connect stream 25\n",sizeof(..));
write(fd,"helo mail.my.com\n",..);
...


Just one more question: would it be possible to specify a poll operation
for /proc/blah?
