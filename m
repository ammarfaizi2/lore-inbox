Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTESR3t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 13:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTESR3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 13:29:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13322 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262601AbTESR3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 13:29:46 -0400
Date: Mon, 19 May 2003 10:41:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Christoph Hellwig <hch@infradead.org>,
       Martin Schlemmer <azarah@gentoo.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       KML <linux-kernel@vger.kernel.org>, <davem@redhat.com>
Subject: Re: Recent changes to sysctl.h breaks glibc
In-Reply-To: <20030519165623.GA983@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 May 2003, Sam Ravnborg wrote:
> 
> Within include/linux grep told me that "#ifdef __KERNEL__" was present
> in 219 places. So a lot of header files are kept in a shape that allows
> them to be included from user-land.

No. They're definitely _not_ "kept in shape".

A number of headers have historical baggage, mainly to support the 
old libc5 habits, and because removing the ifdef's is something that 
nobody has felt was worth the pain.

I think the only header file that should be considered truly exported is 
something like "asm/posix_types.h". For the others, we'll add __KERNEL__ 
protection on demand if the glibc guys can give good arguments that it 
helps them do the "copy-and-cleanup" phase.

		Linus

