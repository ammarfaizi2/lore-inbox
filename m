Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030422AbVJEXDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbVJEXDV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 19:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030421AbVJEXDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 19:03:21 -0400
Received: from free.hands.com ([83.142.228.128]:53175 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S1030425AbVJEXDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 19:03:20 -0400
Date: Thu, 6 Oct 2005 00:03:09 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Nikita Danilov <nikita@clusterfs.com>, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005230309.GO10538@lkcl.net>
References: <20051005095653.GK10538@lkcl.net> <200510051847.j95IlRTS012444@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510051847.j95IlRTS012444@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 02:47:27PM -0400, Horst von Brand wrote:
> Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > On Wed, Oct 05, 2005 at 01:24:12PM +0400, Nikita Danilov wrote:
> > > Marc Perkel writes:
> 
> > > [...]
> > > 
> > >  > Right - that's Unix "inside the box" thinking. The idea is to make the 
> > >  > operating system smarter so that the user doesn't have to deal with 
> > >  > what's computer friendly - but reather what makes sense to the user. 
> > >  >  From a user's perspective if you have not rights to access a file then 
> > >  > why should you be allowed to delete it?
> 
> > > Because in Unix a name is not an attribute of a file.
> 
> >  there is no excuse.
> 
> It's not an excuse, it's part of a coherent view of how things work. Just
> as Netware used to have its, and DOS had its (sort of). As the world view
> underneath Unix, it is darn hard to "fix".
> 
> [This discussion sounds quite a lot like it is /you/ who needs "fixing",
>  i.e., first wrap your head around Unix' ways...]
 
 asking "ordinary" people to do that is unrealistic: surely you know
 that?
 
 i just spent two hours helping a friend who wasn't familiar
 with the concept of "give root password for maintenance or
 press ctrl-d" they'd been pressing ctrl-d because it said so
 and now i'm going to have a 5-hour round-trip journey and possibly
 an overnight stay to sort out the mess.

> >  selinux has already provided an alternative that is similar to NW
> >  file permissions.
> 
> Nope. SELinux provides MAC, 

 yes.

> i.e., mechanisms by which system-wide policy
> (not the random owner of an object) ultimately decides what operations to
> allow. 

 yes.  the concept is not incompatible with what i said: the only bit
 that is wrong with what you've said is the word "Nope".

> That is not "file permissions". 

 part of the coverage of the MAC is file and directory permissions, and
 as i mentioned earlier, it so happens that each selinux permission
 corresponds, i believe one-to-one, with a function in the dnode and
 inode vfs higher-order-function tables in the linux kernel.

 example permissions (from postfix.te, policy source version 18):

	allow postfix_$1_t { sbin_t bin_t }:dir r_dir_perms;
	allow postfix_$1_t { bin_t usr_t }:lnk_file { getattr read };
	allow postfix_$1_t shell_exec_t:file rx_file_perms;

 i am confident enough with selinux to say that those are file
 and directory permissions.

 (r_dir_perms is a macro that expands to directory read
 permissions { read getattr lock search ioctl }, and
 rx_file_perms is a macro that expands to { read getattr lock
 execute ioctl })

 what this is saying is that postfix_$whatever_t context is
 allowed to read the contents of /sbin and /bin; it's also
 allowed to know if symlinks in /bin and /usr actually exist,
 and also allowed to follow those symlinks; and it's also allowed to
 know if shell-scripts exist, and also to read and ultimately
 execute them.

> And yes, this is quite un-Unix-like.

 this is a good thing.

> [...]
> 
> >  in what way is it possible for linux to fully support the NTFS
> >  filesystem?
> 
> If you ask me, preferably not at all, just let that unholy mess quietly go
> the way of the dinosaurs. Sadly, interoperability is required at times,
> so...

 *sigh*, tell me about it.  well, when reactos gets its NTFS driver, i
 will be sure to let you know.  i promise :)

 l.

