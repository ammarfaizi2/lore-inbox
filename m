Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262368AbSJEPNu>; Sat, 5 Oct 2002 11:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262369AbSJEPNt>; Sat, 5 Oct 2002 11:13:49 -0400
Received: from zero.aec.at ([193.170.194.10]:21769 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262368AbSJEPNs>;
	Sat, 5 Oct 2002 11:13:48 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: TIOCGDEV
References: <Pine.NEB.4.44.0210041654570.11119-100000@mimas.fachschaften.tu-muenchen.de. suse.lists.linux.kernel>
	<p73adltqz9g.fsf@oldwotan.suse.de> <3D9E72C8.1070203@pobox.com>
	<20021005071003.A15345@wotan.suse.de>
	<1033824115.3425.2.camel@irongate.swansea.linux.org.uk>
From: Andi Kleen <ak@muc.de>
Date: 05 Oct 2002 17:19:20 +0200
In-Reply-To: <1033824115.3425.2.camel@irongate.swansea.linux.org.uk>
Message-ID: <m3elb4gbgn.fsf_-_@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

(changed flamebait subject)

> On Sat, 2002-10-05 at 06:10, Andi Kleen wrote:
> > > * viro might have a cow at the use of kdev_t_to_nr...  is that required 
> > > for compatibility with some existing apps?  It seems like you want to 
> > > _decompose_ a number into major/minor, to be an interface that 
> > > withstands the test of time
> > 
> > It withstands the test of time as well as stat(2) or the loop ioctls.
> 
> Is that old stat, stat, stat64 or the proposed new stat64 ?

stat64 uses 64bit dev_t, but I have never heard anybody propose that
for the kernel too. This ioctl supports 32bit dev_t, which is where
all the current proposals go as far as I'm aware.

old stat and stat provide 16bit dev_t.

I cannot comment on the "proposed" one, because I haven't seen it.

If someone had a good case for the kernel ever implementing 64bit dev_t
then it would be of course possible to change the ioctl to copy 64bit
to the user space. So far this doesn't seem likely though.

> I see no good reason for this ioctl at all, in any tree.

Can you propose a different way to do the same thing then ? 

(again parsing /proc/cmdline doesn't work here) 

As background this is used for the "bootlogd" program that comes with sysvinit.
It is used to log all output that reaches /dev/console to a file
("console tee" basically). bootlogd intercepts the real console
for this using TIOCCONS, but to still output something it has to copy
the output to the original underlying device. Thus the ioctl - to find
this device.

The current bootlogd actually has some fallback code for the case
when the ioctl isn't there, but it's so incredibly ugly that I won't
try to describe it on a family list.

Thank you for your useful feedback.

-Andi
