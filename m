Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030476AbWD1QJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030476AbWD1QJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 12:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbWD1QJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 12:09:19 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:37804 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030472AbWD1QJS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 12:09:18 -0400
Date: Fri, 28 Apr 2006 11:09:14 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Ulrich Drepper <drepper@gmail.com>
Cc: Axelle Apvrille <axelle_apvrille@yahoo.fr>, Nix <nix@esperi.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       disec-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-timeauthentication of binaries
Message-ID: <20060428160914.GA31473@sergelap.austin.ibm.com>
References: <87slo2nn0b.fsf@hades.wkstn.nix> <20060425161139.87285.qmail@web26109.mail.ukl.yahoo.com> <a36005b50604280833k5a811384r5f3a6f92dd707256@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36005b50604280833k5a811384r5f3a6f92dd707256@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ulrich Drepper (drepper@gmail.com):
> On 4/25/06, Axelle Apvrille <axelle_apvrille@yahoo.fr> wrote:
> >1- "does this also prevent people writing their own
> >elf loader in a bit of perl and just mmap the code"
> >
> >I'm not sure to exactly understand what you mean:
> >
> >- if you mean writing an application able to read &
> >'interpret' an ELF executable: again, I think DigSig
> >will prevent this, because when you mmap the code,
> >this calls (at kernel level) do_mmap which triggers an
> >LSM hook called file_mmap. And we implement checks in
> >that hook...
> >
> >- if you mean modifying the ELF loader so that do_mmap
> >/ file_mmap aren't called, well you'll need to hack
> >the kernel, won't you ?
> >
> >- finally, note you also have choice not to sign this
> >elf loader of yours. If it isn't signed, it won't ever
> >run ;-)
> 
> No, there no problem writing a loader.  All you need is to create
> anonymous mappings.  Via mmap, maybe on the stack, some heaps are
> still executable.  Then you load the code, fix it up for the address,
> and be done.  The kernel cannot and will not prevent a read(2) call on
> the binary.  That's all that's needed.  And without the SELinux
> support in place you cannot prevent non-exec memory creation and even

BS - you can stack another LSM to prevent that.

Or, stack it with SELinux.  I've tested that combination before with no
problems.

> then, some people need it (jvms, OpenGL libs, etc) to generate code on
> the fly.  So it's never completely ruled out.  Again, look at the code
> in http://people.redhat.com/drepper/selinux-mem.html.
> 
> Given you have executable anonymous memory it is a one-time small
> effort to write a loader and you're done.  Nothing your signature

A one time effort to write it *and sign it*.

You could just as well write it and give it it's own domain with {
execheap execmem execstack execmod } permissions.

> detection code can do about it.  This is snake oil.

-serge
