Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWHFAy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWHFAy6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 20:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbWHFAy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 20:54:58 -0400
Received: from hummeroutlaws.com ([12.161.0.3]:39185 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S932190AbWHFAy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 20:54:57 -0400
Date: Sat, 5 Aug 2006 20:54:33 -0400
From: Jim Crilly <jim@why.dont.jablowme.net>
To: RazorBlu <razorblu@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACLs
Message-ID: <20060806005432.GA2281@voodoo.jdc.home>
Mail-Followup-To: RazorBlu <razorblu@gmail.com>,
	linux-kernel@vger.kernel.org
References: <44D3BF62.10202@gmail.com> <1154729992.3573.35.camel@brianb> <44D3CFB9.9020208@gmail.com> <F493D385-0915-442A-853A-00B3ED75B8B2@mac.com> <44D3DE48.8060103@gmail.com> <20060805014722.GA19509@mail> <44D4EB88.6050406@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D4EB88.6050406@gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/06 09:03:36PM +0200, RazorBlu wrote:
> That is part of my point. The ACL system included with Linux (whether it 
> be the POSIX ACLs or SELinux) are too complex for use by most system 
> administrators, and so are overlooked. Actually, that last statement is 
> untrue - POSIX ACLs seem to be lacking slightly in functionality, and 
> SELinux is overly complicated (see a previous reply in which someone 
> else said that). AppArmor seems to be heading along the right tracks, 
> because it can automatically create its own profiles which you can then 
> tune as necessary, so it does not require as much work to create a 
> policy for a service. However, it probably won't be included in the 
> kernel, especially in the near future (SELinux, which is associated with 
> the NSA, is already there - why add another one, even if it is more 
> advanced?)

AppArmor isn't more advanced and it's not been merged with main yet because
a lot of people feel it's the wrong way to attack the problem. AppArmor
uses path names to decide what's good and bad and paths aren't absolute,
they can change under you without warning, multiple paths can point to the
same file, etc.

> And people still don't know how to apply it properly. How many system 
> administrators do you see using SELinux? In contrast, how many do you 
> now see using AppArmor, which has not been around anywhere near as long 
> SELinux?
> 
> You can't blame advertising - AppArmor may be backed by Novell, but 
> SELinux has the recognition of having ties with the NSA. Then what is 
> it? Ease of use? The fact that a system like that does not have to have 
> overly complicated usermode tools to configure the ACLs?

I don't know that AppArmor is being used by more people, infact I had never
even heard of it until the thread on lkml a little while back. And SELinux 
is enabled by default in FC5 now so only those people who explicitly turned
it off aren't using it.

> Assuming that sshd hasn't been locked down.. What if a vulnerability is 
> found, and an exploit comes out before a patch, and sshd is compromised? 
> Or your root password is brute-forced? What happens then? The attacker 
> has root access, and thus access to EVERYTHING on your server (Windows 
> has the reference monitor, which can't be tampered with or turned off... 
> But we'll leave that aside for now). And unless you have bound sshd to a 
> non-default port above 1023, you have to run it as root - but are you 
> willing to sacrifice usability for security which can be bypassed anyway 
> (privilege escalation)?
> 

But part of the point of having a good RBAC setup is that root doesn't have
any real rights and each daemon runs in their own domain. So if you break
sshd you still don't have any real access.

> If the services are not locked down to just the files and folders they 
> need access to (and with respective permissions), then the attacker 
> gains full control over your server.
> 

That's true no matter what.

> And one last thing - if I locked sshd down (I'm not sure whether your 
> example is a locked down sshd or a standard one), I wouldn't let it 
> access everyone's files ;)
> >Precisely what? What's defined in POSIX ACLs wouldn't apply well to
> >processes anyway since they were designed for file access. SELinux was
> >created to deal with what you're talking about, why not use it?
> Because SELinux is too complicated to be used effectively by most system 
> administrators - that's why.
> 

So don't be like most administrators, take the next step and learn to use
SELinux.

> Alan Cox wrote:
> 
> 
> >That was a while ago, oh way back in 2002. Update to a modern
> >distribution and a file system that supports ACLs and you'll get ACLs
> >and depending on the distro also SELinux.
> 
> But the POSIX ACLs aren't really flexible enough - hence the reason that 
> they have not received the popularity and widespread usage they supposedly 
> deserve.
> 

No, it's that most people don't really need POSIX ACLs since most cases can be
taken care of with normal unix permissions.

Jim.
