Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281624AbRKUGzi>; Wed, 21 Nov 2001 01:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281631AbRKUGz3>; Wed, 21 Nov 2001 01:55:29 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:15488 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281624AbRKUGzM>; Wed, 21 Nov 2001 01:55:12 -0500
Message-ID: <000601c17259$59316630$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: <jmerkey@vger.timpanogas.org>, "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20011121001639.A813@vger.timpanogas.org><20011120.222203.58448986.davem@redhat.com><20011121003304.A683@vger.timpanogas.org> <20011120.224723.35806752.davem@redhat.com>
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
Date: Tue, 20 Nov 2001 23:54:21 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "David S. Miller" <davem@redhat.com>
To: <jmerkey@vger.timpanogas.org>
Cc: <linux-kernel@vger.kernel.org>; <jmerkey@timpanogas.org>
Sent: Tuesday, November 20, 2001 11:47 PM
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid
opcode


>    From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
>    Date: Wed, 21 Nov 2001 00:33:04 -0700
>
>    No. I think the build in linux is broken.  The Linux tree should
>    not generate garbase opcodes from the includes is make dep
>    has not been run and someone is simply building a module against
>    the include files.
>
> It executes a bogus opcode because that is how we signal
> an assertion failure, see the BUG() macro define in
> include/asm-i386/page.h
>
> If it only fails as a module, then most likely (as I stated in my
> original mail, which you decided not to read) you are trying to create
> a SLAB cache of the same name twice and it is giving you an OOPS to
> let you know about it.
>

No dave, I read it, and I am not trying to create a slab cache twice.  I
only
create it once.  I did go look at the code and I got the part of using an
invalid
opcode to generate an exception.  Sort of like an int3 embedded in the
code (the old NetWare/NT way).  :-)

> On module unload you have to kmem_cache_destroy or else you'll
> hit this assertion failure the next time you load the module.
>
> If you aren't going to look at the things I've asked you to look at to
> try and determine the problem, and will merely complain about the
> "garbage opcodes" without looking at what put those opcodes there in
> the kernel image, then your problem is one that I cannot solve.
>
> I said: "A BUG() assertion is being triggered in slab.c"
> You retort: "Nothing should make garbage opcodes execute."
>
> I am now saying: "Go look at the BUG() definition, it is a garbage
> opcode and it is on purpose".
>
> Are you now going to say: "Linux is still broken, nothing should make
> garbage opcodes, the build in Linux is broken"
>
> ???
>
> You are really a fucking pain in the ass to help Jeff.

Dave,  I went and looked at this stuff.  I have been running this code for
over a year on 2.4 and I AM NOT CREATING A SLAB CACHE TWICE!!!!
I am building an NWFS module external of the kernel tree, and unless make
dep
has been run, the default behavior of the includes causes me to drop into
the
BUG() trap.

Jeff


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

