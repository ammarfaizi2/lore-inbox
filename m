Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289064AbSAIX3p>; Wed, 9 Jan 2002 18:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289075AbSAIX3g>; Wed, 9 Jan 2002 18:29:36 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:56333 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S289064AbSAIX3b>; Wed, 9 Jan 2002 18:29:31 -0500
Date: Wed, 9 Jan 2002 23:29:29 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: initramfs programs (was [RFC] klibc requirements)
In-Reply-To: <20020109174637.A1742@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201092325280.31502-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Eric S. Raymond wrote:

> > > The underlying problem is that dmidecode needs access to kmem, and I
> > > can't assume that the person running my configurator will be root.
> >
> > But you can "su -c" (also sudo, I suppose).  If that person
> > doesn't have root, then building a kernel isn't going to do
> > them much good.
>
> We've been over this already.  No, the configurator user should *not*
> have to su at any point before actual kernel installation.  Bad
> practice, no doughnut.

Why bad practice?  Anyway, you can:

	if [ /proc/ -nt /var/run/dmidecode ]; then
		echo We need to run some code as root.
		echo -n Enter root\'s\
		su -c 'dmidecode > /var/run/dmidecode'
	fi

Which provides at least a way to have your config tool
work without having to bloat the initramfs.

Matthew.

