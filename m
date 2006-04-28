Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030436AbWD1Pde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbWD1Pde (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 11:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbWD1Pde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 11:33:34 -0400
Received: from wproxy.gmail.com ([64.233.184.229]:56539 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030436AbWD1Pdd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 11:33:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bawxGCMFBsIHYYBlUs2mZvklv0EaAY+iBNtSz7j9LkeM4VbRCIJKhGgIJ6CohU4AeCU7PIs8AtCO9gRQmNjBuAQFlmhVba8R/JhIz6K+oarLYEfYZFq4c+GxpeK9fqo8HCeba+2u9zoxfWedxHt/l8juL33OjUP9A3UYo5g0eEY=
Message-ID: <a36005b50604280833k5a811384r5f3a6f92dd707256@mail.gmail.com>
Date: Fri, 28 Apr 2006 08:33:32 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Axelle Apvrille" <axelle_apvrille@yahoo.fr>
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-timeauthentication of binaries
Cc: Nix <nix@esperi.org.uk>, "Arjan van de Ven" <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       disec-devel@lists.sourceforge.net
In-Reply-To: <20060425161139.87285.qmail@web26109.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <87slo2nn0b.fsf@hades.wkstn.nix>
	 <20060425161139.87285.qmail@web26109.mail.ukl.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/06, Axelle Apvrille <axelle_apvrille@yahoo.fr> wrote:
> 1- "does this also prevent people writing their own
> elf loader in a bit of perl and just mmap the code"
>
> I'm not sure to exactly understand what you mean:
>
> - if you mean writing an application able to read &
> 'interpret' an ELF executable: again, I think DigSig
> will prevent this, because when you mmap the code,
> this calls (at kernel level) do_mmap which triggers an
> LSM hook called file_mmap. And we implement checks in
> that hook...
>
> - if you mean modifying the ELF loader so that do_mmap
> / file_mmap aren't called, well you'll need to hack
> the kernel, won't you ?
>
> - finally, note you also have choice not to sign this
> elf loader of yours. If it isn't signed, it won't ever
> run ;-)

No, there no problem writing a loader.  All you need is to create
anonymous mappings.  Via mmap, maybe on the stack, some heaps are
still executable.  Then you load the code, fix it up for the address,
and be done.  The kernel cannot and will not prevent a read(2) call on
the binary.  That's all that's needed.  And without the SELinux
support in place you cannot prevent non-exec memory creation and even
then, some people need it (jvms, OpenGL libs, etc) to generate code on
the fly.  So it's never completely ruled out.  Again, look at the code
in http://people.redhat.com/drepper/selinux-mem.html.

Given you have executable anonymous memory it is a one-time small
effort to write a loader and you're done.  Nothing your signature
detection code can do about it.  This is snake oil.
