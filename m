Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTJLTx7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 15:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbTJLTx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 15:53:59 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:45572 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263510AbTJLTx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 15:53:58 -0400
Date: Sun, 12 Oct 2003 21:53:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org, sam@ravnborg.org
Subject: Re: non-modular 2.6 ppc kernels miscompiled by gcc-3.3.1?
Message-ID: <20031012195355.GA6022@mars.ravnborg.org>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.linuxppc.org, sam@ravnborg.org
References: <200310121947.h9CJlmtK015045@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310121947.h9CJlmtK015045@harpo.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 12, 2003 at 09:47:48PM +0200, Mikael Pettersson wrote:
> Notice __start___ex_table[]'s address: it's not 4-byte aligned.
> With gcc-3.2.3 it got an 8-byte aligned address in my 2.6 kernel.
> 
> vmlinux.lds.S doesn't explicitly align __start___ex_table, so I
> simply put ". = ALIGN(4);" before it and Voila! now it works.

ld will aling the section according to alingment requirements
of the symbols inside the section.
So what happens in your case is that . (current address) is
un-even. But ld alings the section to a 4-byte boundary,
due to one of the symbols inside the section.

So the better fix is to define the lables inside the section,
(read: inside the two '{}').

Care to give my patch a check and report back.

	Sam
