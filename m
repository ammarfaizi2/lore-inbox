Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129800AbQLRPxH>; Mon, 18 Dec 2000 10:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130770AbQLRPw5>; Mon, 18 Dec 2000 10:52:57 -0500
Received: from [62.172.234.2] ([62.172.234.2]:27758 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S129800AbQLRPwv>;
	Mon, 18 Dec 2000 10:52:51 -0500
Date: Mon, 18 Dec 2000 15:21:14 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Peter Samuelson <peter@cadcamlab.org>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.0-test13-pre3] rootfs boot param. support
In-Reply-To: <14910.10581.542721.76419@wire.cadcamlab.org>
Message-ID: <Pine.LNX.4.21.0012181519060.830-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2000, Peter Samuelson wrote:

> 
> [Tigran Aivazian]
> > no, because it would cause a "spurious" call to get_fs_type("") which
> > we don't want to happen (by default i.e. -- if user _really_ wants it
> > that is ok). The default of "ext2" is fine.
> 
> I still disagree -- super.c is no place to dictate the default root
> filesystem.  And I agree with Andries that 'rootfs=' is confusing.

I have already covered both of these issues in the email I sent ages
ago...  Here it is below (instead of re-sending) (the original got lost
because of the mail-abuse vs btconnect's randomness)

>From tigran@veritas.com Mon Dec 18 15:20:08 2000
Date: Mon, 18 Dec 2000 14:44:32 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.0-test13-pre3] rootfs boot param. support

On Mon, 18 Dec 2000 Andries.Brouwer@cwi.nl wrote:
> (i) I prefer "rootfstype". Indeed, "rootfs" is ambiguous.
> It gives some property of the root filesystem, but which?

No, it is not ambiguous. Because, look at this sequence:

"ffs", "ufs", "bfs", "reiserfs", "vxfs", "sockfs", "pipefs", "nfs", ...

they are familiar to everyone and everyone immediately recognizes the
attribute they describe by the ending "fs". So, the attribute is
immediately obvious and should be recognized by programmer without need to
explicitly comment about it (it just is like it is _obvious_ that static
int x; is initialized to 0 and there is no need to start asking oneself
"what is this attribute of x that is being set to 0 here... ah.. it's the
_value_ thereof!" )

>     +static char rootfs[128] __initdata = "ext2";
> 
> (ii) It is a bad idea to arbitrarily select "ext2".

No, how could you say it is a bad idea without saying also _what_ is a
good idea? If there is no replacement for a bad idea then it is, by
definition, a good (or best) idea. So, having not found a better initial
value for rootfs[] I set it to "ext2". Setting it to "" is no good as I
explained to Peter. Setting it to NULL is also no good because needs an
extra line of code in mount_root() to check for it. So, what then? I say
"ext2" as it is the most popular Linux filesystem at the moment.

> (iii) I probably give the rootfstype explicitly because bad things
> (like disk corruption) happen when the kernel misrecognizes some
> filesystem, and perhaps starts updating access times or so.
> Thus, if the boot option rootfstype is given, I prefer a boot failure
> over a kernel attempt to try all filesystems it knows about, just like
> mount(8) only will start guessing when no explicit type was given.

that gives it a different semantics, i.e. you are changing the rules. I am
not sure which rules are better but there are advantages to it being as
is, e.g. one could hardcode "rootfs=vxfs" in their lilo.conf and rely on
fallback to ext2 for some of the partitions but not others.

This one is a matter of taste and if Linus says your way is better I will
redo the patch immediately. Both ways are fine with me.

Regards,
Tigran

>From tigran@veritas.com Mon Dec 18 15:20:13 2000
Date: Mon, 18 Dec 2000 14:54:40 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.0-test13-pre3] rootfs boot param. support

On Mon, 18 Dec 2000, Tigran Aivazian wrote:
> Setting it to NULL is also no good because needs an
> extra line of code in mount_root() to check for it.

before N people misunderstand the above -- I meant having just a
pointer and doing kmalloc/kfree manually.

Regards,
Tigran




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
