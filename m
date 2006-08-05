Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161506AbWHEBrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161506AbWHEBrg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 21:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161508AbWHEBrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 21:47:36 -0400
Received: from hummeroutlaws.com ([12.161.0.3]:34830 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1161506AbWHEBrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 21:47:35 -0400
Date: Fri, 4 Aug 2006 21:47:22 -0400
From: Jim Crilly <jim@why.dont.jablowme.net>
To: RazorBlu <razorblu@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACLs
Message-ID: <20060805014722.GA19509@mail>
Mail-Followup-To: RazorBlu <razorblu@gmail.com>,
	linux-kernel@vger.kernel.org
References: <44D3BF62.10202@gmail.com> <1154729992.3573.35.camel@brianb> <44D3CFB9.9020208@gmail.com> <F493D385-0915-442A-853A-00B3ED75B8B2@mac.com> <44D3DE48.8060103@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D3DE48.8060103@gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/06 01:54:48AM +0200, RazorBlu wrote:
> Kyle Moffett wrote:
> >You're quite wrong about SELinux; it _is_ part of the kernel.  
> >Admittedly it requires a policy to be built and loaded from userspace, 
> >but your "ACLs" would require some ACL utilities to apply those from 
> >userspace.
> That is true, but is it included in every stable release of the kernel 
> (by default)? And why aren't more distributions using it (the popular 
> ones - for example, I know Mandriva uses grsecurity).

It's been in the stable release of every kernel for quite some time now.
And it's enabled by default in FC5 and maybe RHEL4, I can't remember 100%
about the latter. And I'm not 100% sure what all GRSecurity does, but from
what I remember it covers a different area than SELinux so they're not
comparable.

The main reason it's not enabled by default in most distributions is that
writing good policies is a huge amount of work and they haven't written
policies for all of their packages. Now that SELinux has been pushed into
FC it'll act as motivation for people to get working on those policies so I
would guess that we'll see SELinux be enabled in the rest of the major
distributions by default in their next releases or so.

> >In any case SELinux is an extremely powerful model; you can define 
> >your arbitrary RBAC+TE state machine and constraints, then the kernel 
> >applies it to your system; as simple (or horribly complicated, as the 
> >case may be) as that.
> And what are your feelings on SELinux still being "under research"? Can 
> such a system be used in a production environment, when it has not been 
> declared a completely mature system by its creators?

To varying extents everything is still under research. AFAIK the core of
SELinux hasn't changed in many years, it's just taken this long for people
to figure out how to apply it properly.

> >Here's a better security model:  SELinux lets you give root access to 
> >everybody and still have a 100% secure system (although it's not 
> >really recommended).  Google around for the public SSH-accessible 
> >SELinux testbeds with root's password set to "password" or "1234" or 
> >whatever and feel free to log in and have a look.  Besides, we do have 
> >POSIX ACLs on files; if that's what you're looking for, but that's not 
> >extensible enough to cover processes too.
> A 100% secure system except for the files that sshd has access to, 
> correct? If global access is allowed to root, but it is locked down to 
> sshd, then anyone who logs in as root can only modify those files that 
> sshd has access to... Or is there a part of the puzzle that I am 
> missing? I had not heard of those testbeds before, but I would like to 
> see how they are set up.
> 

Sure if you can break into sshd you might be able to mess with it's config
files and any other areas on the system that everyone has access too, but
that's it. But if you just login via ssh you'll only have access to the
files that your account has access to, not sshd.

> "Besides, we do have POSIX ACLs on files; if that's what you're looking 
> for, but that's not extensible enough to cover processes too." - Precisely.

Precisely what? What's defined in POSIX ACLs wouldn't apply well to
processes anyway since they were designed for file access. SELinux was
created to deal with what you're talking about, why not use it?

Jim.
