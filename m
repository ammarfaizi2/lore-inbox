Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272221AbTGYQmF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 12:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272222AbTGYQmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 12:42:04 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:22024 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S272221AbTGYQmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 12:42:03 -0400
Date: Fri, 25 Jul 2003 18:57:09 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: John Belmonte <jvb@prairienet.org>, Ben Collins <bcollins@debian.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net,
       Michael Wawrzyniak <gan@planetlaz.com>
Subject: Re: [PATCH] bad strlcpy conversion breaks toshiba_acpi
Message-ID: <20030725165709.GA670@win.tue.nl>
References: <3F2142CE.4090608@prairienet.org> <20030725161510.GA31565@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725161510.GA31565@vana.vc.cvut.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 06:15:10PM +0200, Petr Vandrovec wrote:

> Nope. Kernel strlcpy implementation is crap and I do not believe that there
> is single place in the kernel which can live with current implementation. 
> 
> Take a look at ftp://ftp.openbsd.org/pub/OpenBSD/src/lib/libc/string/strlcpy.c 
> or at http://www.courtesan.com/todd/papers/strlcpy.html - it copies
> at most size-1 characters. Nothing about characters beyond specified size 
> in the article.
> 
> Kernel should use strnlen() to get string length, if coding loop like
> OpenBSD does is unacceptable.

strlcpy is for strings, not for character arrays.
The *BSD version accesses the source past the size-1 characters that are copied:
	while (*s++)
		;
Thus, replacing strncpy (used to copy character arrays, possibly not 0-terminated)
by strlcpy is wrong.

