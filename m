Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWIJNHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWIJNHF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 09:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWIJNHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 09:07:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15120 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751039AbWIJNHC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 09:07:02 -0400
Date: Sun, 10 Sep 2006 12:36:31 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Theodore Tso <tytso@mit.edu>, David Madore <david.madore@ens.fr>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060910123631.GA4206@ucw.cz>
References: <20060905212643.GA13613@clipper.ens.fr> <20060906002730.23586.qmail@web36609.mail.mud.yahoo.com> <20060906100610.GA16395@clipper.ens.fr> <20060906132623.GA15665@clipper.ens.fr> <20060909231805.GC24906@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060909231805.GC24906@thunk.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I emphasize that the filesystem support patch described above, alone,
> > will *not* solve the inheritability problem (as my patch does), since
> > unmarked executables continue to inherit no caps at all.  With my
> > patch, they behave as though they had a full inheritable set,
> > something which is required if we want to make something useful of
> > capabilities on non-caps-aware programs.
> 
> This is what scares me about your proposal.  I consider it a *feature*
> that unmarked executables inherit no capabilities, since many programs
> were written without consideration about whether or not they might be
> safe to run without privileges.  So the default of not allowing an
> executable to inherit capabilities is in line of the the classic
> security principle of "least privileges".   
> 
> I agree it may be less convenient for a system administrator who is
> used root, cd'ing to a colleagues source tree, su'ing to root, and who
> then types "make" to compile a program, expecting it to work since
> root privileges imply the ability to override filesystem discretionary
> access control --- and then to be rudely surprised when this doesn't
> work in a capabilities-enabled system.  However, I would claim this is
> the correct behaviour!

But this is not how it behaves today, right? I do not think you could
push 'break-make-as-root' as a bugfix to -stable ;-).

> absence of an explicit capability record.  Both of these should be
> overrideable by a mount option, but for convenience's sake it would be
> convenient to be able to set these values in the superblock.

Would per-system default capability masks be enough? ... .... okay,
probably not, because nosuid is per-mount, and this is similar.

> As far as negative capabilities, I feel rather strongly these should
> not be separated into separate capability masks.  They can use the
> same framework, sure, but I think the system will be much safer if
> they use a different set of masks.  Otherwise, there can be a whole
> class of mistakes caused by people and applications getting confused

Can we simply split them at kernel interface layer? Libc could do it,
preventing confusion...

> The solution is to _extend_ the capabilities system: for example, by
> adding default inheritance masks to cater for system administrators
> who value convenience more than security, and to add new bitmasks for
> negative privileges/capabilities.

Agreed.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
