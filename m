Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277823AbRJORRJ>; Mon, 15 Oct 2001 13:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277885AbRJORRA>; Mon, 15 Oct 2001 13:17:00 -0400
Received: from [209.195.52.30] ([209.195.52.30]:60950 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S277823AbRJORQu>;
	Mon, 15 Oct 2001 13:16:50 -0400
Date: Mon, 15 Oct 2001 08:55:51 -0700 (PDT)
From: David Lang <dlang@diginsite.com>
To: Jacques Gelinas <jack@solucorp.qc.ca>
cc: Linux kernel list <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@suse.cz>
Subject: re: Re: Announce: many virtual servers on a single box
In-Reply-To: <20011015092905.bc1c569516e5@remtk.solucorp.qc.ca>
Message-ID: <Pine.LNX.4.40.0110150854500.4883-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

you mention problems with interaction if the main sandbox has a service
listening on 0.0.0.0, what happens if a vserver does this (does it only
see it's own IP addresses or does it interfere with other servers?)

David Lang

 On
Mon, 15 Oct 2001, Jacques Gelinas wrote:

> Date: Mon, 15 Oct 2001 09:29:05 -0500
> From: Jacques Gelinas <jack@solucorp.qc.ca>
> To: Linux kernel list <linux-kernel@vger.kernel.org>
> Cc: Pavel Machek <pavel@suse.cz>
> Subject: re: Re: Announce: many virtual servers on a single box
>
> On Fri, 12 Oct 2001 23:01:04 -0500, Pavel Machek wrote
> > Hi!
> >
> > > -I have also modified the capability system a little, so those virtual server
> > >  administrators can't take over the machine. I have introduced a per-process
> > >  capability ceiling, inherited by sub-process. Even setuid program can't grab
> > >  more capabilities..
> >
> > Really? What hardware do they see in /dev/? Do their servers have for
> > example mouse? What about ethernet cards?
>
> In /dev they see very little: full  log  null  ptmx  pts  random  tty  urandom  zero
>
> The do not have CAP_SYS_MKNOD, so they can't create more than you give.
>
> In fact, the vserver sees whatever you want to give it. So if you intend to run
> X in the vserver, give it the mouse device.
>
> > Does /proc/kmem work in virtual servers?
>
> You probably mean /dev/kcore. No they can't read it.
>
> > [Why I'm asking? I'm trying to find ways to take over the machine. Do
> > you want to give me root on your machine stating that I can't
> > interfere?]
>
> Indeed, I could give you a root password on a vserver and you would not be
> able to interfere. Sure enough you would be able to grab resource and slow
> down the machine (and potentially work out a DOS attack). We are working
> on the schedular right now to solve those issues.
>
> But there is no need to open a crackme vserver. Install it on your machine,
> build a vserver. Install the vserver package, reboot a kernel with the patch
> with the new new_s_context and set_ipv4root syscall and do
>
> 	/usr/sbin/vserver test build
>
> enter it and configure a few service
>
> 	/usr/sbin/vserver test enter
>
> 	chkconfig crond on
> 	chkconfig sshd on
>
> Then start the server
>
> 	/usr/sbin/vserver test start
>
> and ssh to it. For now, the build process inherit the user accounts of the
> main server, so the root password is the same.
>
> Note that if sshd is already running on the box, you won't be able start
> sshd in the test server because sshd on the main server is bound to
> 0.0.0.0. Just do
>
> 	/etc/rc.d/init.d/v_sshd restart
>
> or
>
> 	chkconfig sshd off
> 	chkconfig v_sshd on
>
> > You might want to announce this on bugtraq. [And give solar designer
> > root account, he might be more creative ;)].
>
> You don't understand the issue. Anyone can create his own vserver. The
> system call controlling this are very simple. It is not a "try to crack my machine"
> contest. Anyone can create a vserver and test it.
>
> The security of the vserver is explain on
> http://www.solucorp.qc.ca/miscprj/s_context.hc. It relies on the capability
> system. So far, I have found one place in the kernel where the capability
> was not in place: /proc/sys was changeable if you were root. I added
> a capable(CAP_SYS_ADMIN) line to solve this.
>
> --
>
> One nice thing about vserver is the clean separation with the real server.
> For example, after having played with a vserver, if you decide you do not like
> this concept, then you ca do
>
> 	reboot the old kernel
> 	erase the new kernel
> 	rpm -e vserver
> 	rm -fr /vservers /etc/vservers
>
> and you are back where you were.
>
> ---------------------------------------------------------
> Jacques Gelinas <jack@solucorp.qc.ca>
> vserver: run general purpose virtual servers on one box, full speed!
> http://www.solucorp.qc.ca/miscprj/s_context.hc
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
