Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWHBIeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWHBIeq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 04:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWHBIeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 04:34:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:37004 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751369AbWHBIep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 04:34:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=twUyoQ0y3elKggXrxE+9t23K8D9KhvHSUEpsOg9q2Lw08YQBqKBO0fLP2iKJ7B5F0rpJ4IZyLVqUt/vpxHeyHcCVbdLqXaRIQ+BcNiYn1CKmdVzUlFgKyrEHRh8aAL9T9HbEg2H4VFprWtzo7edtqQOWQYsYDOE8tHTEsDQTIYQ=
Message-ID: <aec7e5c30608020134h2d0f9955p34a0cd76d8836acd@mail.gmail.com>
Date: Wed, 2 Aug 2006 17:34:44 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, "Jan Kratochvil" <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, "Vivek Goyal" <vgoyal@in.ibm.com>,
       "Linda Wang" <lwang@redhat.com>
In-Reply-To: <m1lkq7txz0.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	 <aec7e5c30608012334y42e947e6ge935e5d866f78c84@mail.gmail.com>
	 <m1lkq7txz0.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Magnus Damm" <magnus.damm@gmail.com> writes:
> > Eric, could you please list the advantages of your run-time relocation
> > code over my incomplete relocate-in-userspace prototype posted to
> > fastboot a few weeks ago?
>
> If you watch an architecture evolve one thing you will notice is that
> the kinds of relocations keep growing.  An ever growing list of things
> to for the bootloader to do is a pain.  Especially when bootloaders
> generally need to be as simple and as fixed as possible because bootloaders
> are not something you generally want to update.

I agree that updating bootloaders is something you want to avoid. I'm
not however sure that I would call kexec-tools a bootloader...

> Beyond that if you look at head.S the code to process the relocations
> (after I have finished post processing them at build time) is 9 instructions.
> Which is absolutely trivial, at least for now.

Yeah, but the 33 patches are touching more than 9 instructions. =)

> By keeping the bzImage processing the relocations we have kept the
> bootloader/kernel interface simple.

Agreed. I think your patch makes sense.

> > One thing I know for sure is that your implementation supports bzImage
> > while my only supports relocation of vmlinux files. Are there any
> > other uses for relocatable bzImage except kdump?
>
> I can't think of any volume users.  A hypervisor that would actually report
> the real physical addresses would be a candidate.  It's a general purpose
> facility so if it is interesting users will show up.  Static
> relocation has already found another use on x86_64.
>
> There are definitely users of an ELF bzImage beyond the kdump case.
> Anything that doesn't have a traditional 16bit BIOS on it.  LinuxBIOS,
> and Xen, and some others.
>
> Not having to keep track of anything but your bzImage to boot is also
> a serious advantage.  It's the one binary to rule them all. :)

One binary to rule them all... If that is true, is there any simple
way then to extract vmlinux from the bzImage?

Thanks!

/ magnus
