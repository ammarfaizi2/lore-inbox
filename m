Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbSLPAeB>; Sun, 15 Dec 2002 19:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbSLPAeB>; Sun, 15 Dec 2002 19:34:01 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62844 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S263544AbSLPAeA>; Sun, 15 Dec 2002 19:34:00 -0500
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] kexec for 2.5.51....
References: <200212141215.49449.tomlins@cam.org>
	<200212141859.07191.tomlins@cam.org>
	<m11y4jatbe.fsf@frodo.biederman.org>
	<200212151641.49062.tomlins@cam.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Dec 2002 17:41:35 -0700
In-Reply-To: <200212151641.49062.tomlins@cam.org>
Message-ID: <m1wumaaj7k.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <tomlins@cam.org> writes:

> On December 15, 2002 04:03 pm, Eric W. Biederman wrote:
> > Ed Tomlinson <tomlins@cam.org> writes:
> > > Why not include this info in kexec -h ?  Bet it would prevent a few
> > > failure reports...
> >
> > I will look, at that.
> >  
> > > Two more possible additions to the kexec command.  
> > >
> > > 1. kexec -q which returns rc=1 and types the pending selection and
> > >    its command/append string if one exists and returns rc=0 if nothing
> > >    is pending.  
> >
> > This would require effort to little purpose.  If you just call kexec
> > it loads the kernel and then calls shutdown -r now.  So the loaded kernel
> > should be a transient entity anyway.
> 
> Consider, you are not sure what kexec has been setup to do (maybe 
> some other admin has something setup to take a crash dump etc).  You 
> do not want to destroy this setup, so you do kexec -q  
> 
> Think being able to query the pending kexec is very usefull.  Also
> using an rc means that scripts can use it too.

I think setting up something like /etc/lilo.conf say /etc/kexec.conf
is probably practical.  You have already seen how difficult it is to
bring up the hardware into a sane state from an arbitrary point.  So
we can cross the crash dump bridge when we come to it.

If this was simply a case of supporting linux the problem would be
some easier.  But I also intend to support booting other operating
systems.

Now I think there is some advantage in setting up a new set of page
tables and just switching to those at kexec time, it slightly reduces
the amount of work I need to do at kexec time, enhancing the
reliability of something like kexec on panic.   And that could
probably be exported in /proc/<pid>/mem.  So if and when I go this
route I will keep your request in mind.  

> > > 2. kexec -c which clears any pending kernels.
> >
> > This I can and should do.  The kernel side is already implemented.

Oh, and of course I accept patches so you don't have to wait for me to
implement something.

Eric
