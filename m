Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267976AbUJSFPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267976AbUJSFPy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 01:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267985AbUJSFPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 01:15:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:65468 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267976AbUJSFOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 01:14:15 -0400
Date: Mon, 18 Oct 2004 22:14:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 BK build broken
In-Reply-To: <41748ADE.70403@pobox.com>
Message-ID: <Pine.LNX.4.58.0410182208020.2287@ppc970.osdl.org>
References: <20041019021719.GA22924@merlin.emma.line.org> <41747CA6.7030400@pobox.com>
 <41748ADE.70403@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Oct 2004, Jeff Garzik wrote:
> > 
> > I get an ICE here in -BK-latest, which the attached patch fixes (backs 
> > out Linus's change).

Heh. Clearly there's a gcc bug.. What compiler version?

I've got gcc-3.2 and gcc-3.3, and neither seems to have any trouble, but 
hey, I'm cursed by having fairly up-to-date systems.

That said, I know what's up, but it would be good to know what compilers 
have this problem..

> Another data point, I have no problems with 2.6-BK-latest on x86-64, 
> with gcc 3.3.3 (FC2)...

Too much C syntax, too little CPP braindamage. 

I bet the thing is fixed by changing the

	#define __builtin_warning(x, ...) (1)

into

	#define __builtin_warning(x, y...) (1)

(ie add the name for the varargs macro argument). Never mind that we don't 
use it, and newer gcc's are happy - older gcc's clearly aren't ;)

		Linus
