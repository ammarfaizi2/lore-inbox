Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbVEXWqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVEXWqg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 18:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVEXWqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 18:46:35 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13480 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261421AbVEXWqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 18:46:31 -0400
Date: Wed, 25 May 2005 00:41:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Reiner Sailer <sailer@us.ibm.com>
Cc: Emilyr@us.ibm.com, James Morris <jmorris@redhat.com>, Kylene@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       Toml@us.ibm.com, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH 2 of 4] ima: related Makefile compile order change and Readme
Message-ID: <20050524224144.GA8109@elf.ucw.cz>
References: <Pine.WNT.4.63.0505241524170.828@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.63.0505241524170.828@laptop>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > * remove all the buffer overflows. I.e. if grub contains buffer
> > > >    overflow in parsing menu.conf... that is not a security hole
> > > >    (as of now) because only administrator can modify menu.conf.
> > > >    With IMA enabled, it would make your certification useless...
> > > 
> > > Taking your example: Even if you run a buffer-overflow grub, IMA will 
> > > enable remote parties to differentiate between systems that run
> > > the vulnerable grub and systems that don't. IMA in this case actually
> > > can put value to running better software.
> > 
> > Yes, but see above: that buffer overflow in grub was *not* a
> > vulnerability... not until you introduce IMA.
> > 
> > That is my biggest concern. You are completely changing rules for
> > userland code. Buffer overflow that only root could exploit used to be
> > okay. It used to be okay to read config files without communicating
> > with TPM.
> 
> I don't follow your argumentation.

Maybe I'm just wrong... I definitely chosen bad example (grub) because
it is also bootloader...

> (iv) From then on, the IMA in the kernel is responsible for measuring 
> executables/modules before loading them and for maintaining the 
> measurement list and its TPM aggregate. 

Kernel does not know what is exacutable and what is data. Thanks to
buffer overflows, the line between executable and data is extremely
blury.

Now, to my argumentation. Imagine bootscripts containing
"show_etc_issue" command. (That shows /etc/issue). If there's buffer
overflow in "show_etc_issue" command, it is *not* security issue as of
now, because it only works on data provided by root. But it becomes
issue when IMA system is in use, because now /etc/issue can be used to
inject code into system; something that was not possible before.

OTOH buffer overrun in show_etc_issue is certainly bad thing, because
it is unexpected behaviour; and if IMA means such stuff is fixed...

It just seems like a lot of work. You are basically adding check at
every place where user can
shoot_himself_in_the_foot^W^W^W^W^Wdo_something_stupid_to_system_security
. I suspect many config files can be used to compromise system
security...

								Pavel

