Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135834AbRDYH6x>; Wed, 25 Apr 2001 03:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135835AbRDYH6k>; Wed, 25 Apr 2001 03:58:40 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:44296 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S135834AbRDYH6V>; Wed, 25 Apr 2001 03:58:21 -0400
Message-ID: <3AE68367.FF945378@idb.hist.no>
Date: Wed, 25 Apr 2001 09:57:27 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: imel96@trustix.co.id
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
In-Reply-To: <Pine.LNX.4.33.0104242029140.16230-100000@tessy.trustix.co.id>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

imel96@trustix.co.id wrote:

> thank you very much fyi.
> if just you tried to understand it a little further:
> i didn't change all uid/gid to 0!
> 
> why? so with that radical patch, users will still have
> uid/gid so programs know the user's profile.
> 
> if everyone had 0/0 uid/gid, pine will open /var/spool/mail/root,
> etc.

So you want multi-user to distinguish users, but no login sequence 
with typing of passwords & username.  

You can have all that without changing the kernel!
Linux distributions runs things like login and getty by default,
but you don't have to do that.  

If you run linux on a device not perceived as a computer,
consider this:

1. Run whatever daemons you need as root or under daemon usernames,
depending on what privileges they need.

2. Run the user interface program (X or whatever) as a user,
not root.  No, they don't need a password for that.  Just
start it from inittab, with a wrapper program that su's to the
appropriate user without asking for passwords.

3. If the user really need root for anything, such as changing
device configuration, use a suid configuration program.  No
password needed with that approach.  You probably want
a configuration program anyway as your "dumb" users probably 
don't know how to edit files in /etc anyway.  Making 
it suid is no extra work.

Now you have both the security of linux and the ease of use of a
password-less system.  Part of linux stability comes from the
fact that ordinary users cannot do anything.  Crashing the
machine is easy as root, but an appliance user don't need
to be root for normal use.  And the special cases which need
it can be handled by suid programs that cannot do "anything",
just the purpose they are written for.

Linux is very configurable even without patching the kernel.
A general rule is that no kernel patches is accepted for
problems that are easily solvable with simple programs.

Helge Hafting
