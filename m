Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317454AbSGEOfE>; Fri, 5 Jul 2002 10:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317462AbSGEOfE>; Fri, 5 Jul 2002 10:35:04 -0400
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:31702 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S317454AbSGEOfD>;
	Fri, 5 Jul 2002 10:35:03 -0400
Subject: Re: prevent breaking a chroot() jail?
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <ag48ui$fb5$1@ncc1701.cistron.net>
References: <1025877004.11004.59.camel@zaphod> 
	<ag48ui$fb5$1@ncc1701.cistron.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 05 Jul 2002 10:37:26 -0400
Message-Id: <1025879850.11004.75.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-07-05 at 10:02, Miquel van Smoorenburg wrote:
> In article <1025877004.11004.59.camel@zaphod>,
> Shaya Potter  <spotter@cs.columbia.edu> wrote:
> >I'm trying to develop a way to ensure that one can't break out of a
> >chroot() jail, even as root.  I'm willing to change the way the syscalls
> >work (most likely only for a subset of processes, i.e. processes that
> >are run in the jail end up getting a marker which is passed down to all
> >their children that causes the syscalls to behave differently).
> >What should I be aware of?  I figure devices (no need to run mknod in
> >this jail) and chroot (as per man page), is there any other way of
> >breaking the chroot jail (at a syscall level or otherwise)?
> 
> int main()
> {
> 	chdir("/");
> 	mkdir("foo");
> 	chroot("foo");
> 	chdir("../../../../../../..");
> 	chroot(".");
> 	execl("/bin/sh", "sh", NULL);
> }
> 
> Run as root and you're out of the chroot jail. This is because
> chroot() doesn't chdir() to the new root, so after a chroot() in
> the chroot jail you're suddenly out of it.

yes, that's what the man page says.  Is that the only hole? i.e. if one
changed the semantics of chroot() to also do a chdir() to the new root,
would that be fixed? (not arguing on changing this for everything, just
for something specific)

thanks,

shaya

