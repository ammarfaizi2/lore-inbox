Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291569AbSBAGob>; Fri, 1 Feb 2002 01:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291570AbSBAGoV>; Fri, 1 Feb 2002 01:44:21 -0500
Received: from zok.sgi.com ([204.94.215.101]:58244 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S291569AbSBAGoH>;
	Fri, 1 Feb 2002 01:44:07 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: garzik@havoc.gtf.org, alan@lxorguk.ukuu.org.uk, vandrove@vc.cvut.cz,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org, paulus@samba.org,
        davidm@hpl.hp.com, ralf@gnu.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
In-Reply-To: Your message of "Thu, 31 Jan 2002 22:26:43 -0800."
             <20020131.222643.85689058.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Feb 2002 17:43:57 +1100
Message-ID: <7507.1012545837@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002 22:26:43 -0800 (PST), 
"David S. Miller" <davem@redhat.com> wrote:
>If you have a dependency concern, you put yourself in the
>right initcall group.  You don't depend ever on the order within the
>group, thats the whole idea.  You can't depend on that, so you must
>group things correctly.

Again this is exactly what I argued back in 2000.  I have long held
that the kernel link order is over defined where it should be fuzzy.
Defining an order between groups but not within groups is exactly what
I wanted but I was told that the initialization order must be
explicitly and fully specified for the entire kernel.  Nice to see that
I have been proved right, pity it took this long.  C'est la vie.

The Makefiles still control order within the .text.init section
(__init, module_init).  Many drivers depend on the Makefile getting
that order correct, otherwise probes stuff up.  But which entries are
order sensitive and which ones are from a developer picking a random
place to insert obj-$(CONFIG) is anyone's guess.

