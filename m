Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132430AbRANMNn>; Sun, 14 Jan 2001 07:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132477AbRANMNd>; Sun, 14 Jan 2001 07:13:33 -0500
Received: from jdi.jdimedia.nl ([212.204.192.51]:25873 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S132430AbRANMNY>;
	Sun, 14 Jan 2001 07:13:24 -0500
Date: Sun, 14 Jan 2001 13:13:16 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
To: Andi Kleen <ak@suse.de>
cc: "David S. Miller" <davem@redhat.com>,
        Igmar Palsenberg <i.palsenberg@jdimedia.nl>,
        Harald Welte <laforge@gnumonks.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0 + iproute2
In-Reply-To: <20010114124659.A23188@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.30.0101141309160.16758-100000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jan 2001, Andi Kleen wrote:

> On Sun, Jan 14, 2001 at 03:36:55AM -0800, David S. Miller wrote:
> >
> > Andi Kleen writes:
> >  > How would you pass the extended errors? As strings or as to be
> >  > defined new numbers? I would prefer strings, because the number
> >  > namespace could turn out to be as nasty to maintain as the current
> >  > sysctl one.
> >
> > Textual error messages for system calls never belong in the kernel.
> > Put it in glibc or wherever.
>
> This just means that a table needs to be kept in sync between glibc and
> netlink, and if someone e.g. gets a new CBQ module he would need to update
> glibc. It's also bad for maintainers, because patches for tables of number
> tend to always reject ;)

Agree, but textual strings are bad. I want to say :

if (error) {
	perror("RTNETLINK");
	return -1;
	}

Using textual strings means you can't use standard functions. An option
would be to extend the call so that if the userspace app wants to know
what really went wrong he can ask the kernel.

In that case you can keep the -EINVAL, the namespace won't be polluted,
and you can see what goes wrong. Agains this is that you need another
interface, which isn't portable.

>
> Textual error messages are e.g. used by plan9 and would be somewhat similar
> to /proc. It would probably waste a few bytes in the kernel, but that's not
> too bad, given the work it saves. e.g. rusty's code usually has a debug option
> that you can set and where each EINVAL outputs a error message; i always found
> that very useful and sometimes hacked that into other subsystems in my
> private tree.

Still means that all standard functions won't work.

> -Andi


	Igmar

-- 

--
Igmar Palsenberg
JDI Media Solutions

Jansplaats 11
6811 GB Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
