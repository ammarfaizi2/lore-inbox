Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272165AbTGYQAZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 12:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272168AbTGYQAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 12:00:25 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:63104 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S272165AbTGYQAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 12:00:15 -0400
Date: Fri, 25 Jul 2003 18:15:10 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: John Belmonte <jvb@prairienet.org>
Cc: Ben Collins <bcollins@debian.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       Michael Wawrzyniak <gan@planetlaz.com>
Subject: Re: [PATCH] bad strlcpy conversion breaks toshiba_acpi
Message-ID: <20030725161510.GA31565@vana.vc.cvut.cz>
References: <3F2142CE.4090608@prairienet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2142CE.4090608@prairienet.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 10:46:38AM -0400, John Belmonte wrote:
> Please revert the following item from Ben Collins' "drivers/* strlcpy 
> conversions" patch dated 2003-May-26.
> 
> The strlcpy function requires a zero-terminated string, which is not a 
> valid assumption for the code in question.  I suggest that Ben review 
> all such modifications he made to the kernel for similar errors.  It's 
> quite annoying to have someone add bugs to your driver while you're not 
> looking.  Either notify the maintainer of your patch or don't make mistakes.

Nope. Kernel strlcpy implementation is crap and I do not believe that there
is single place in the kernel which can live with current implementation. 

Take a look at ftp://ftp.openbsd.org/pub/OpenBSD/src/lib/libc/string/strlcpy.c 
or at http://www.courtesan.com/todd/papers/strlcpy.html - it copies
at most size-1 characters. Nothing about characters beyond specified size 
in the article.

Kernel should use strnlen() to get string length, if coding loop like
OpenBSD does is unacceptable.
						Best regards,
							Petr Vandrovec

