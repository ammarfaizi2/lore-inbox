Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269583AbTG1NNe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 09:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269589AbTG1NNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 09:13:34 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:45800 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S269583AbTG1NNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 09:13:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16165.9478.694732.636734@gargle.gargle.HOWL>
Date: Mon, 28 Jul 2003 15:28:38 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: PATCH: allow 2.6 to build on old old setups
In-Reply-To: <1059391858.15438.14.camel@dhcp22.swansea.linux.org.uk>
References: <200307272026.h6RKQauS029828@hraefn.swansea.linux.org.uk>
	<20030727185241.3288a973.davem@redhat.com>
	<1059391858.15438.14.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 > On Llu, 2003-07-28 at 02:52, David S. Miller wrote:
 > > >  		    info->hdr->e_machine == EM_SPARCV9) {
 > > >  			/* Ignore register directives. */
 > > >  			if (ELF_ST_TYPE(sym->st_info) == STT_REGISTER)
 > > >  				break;
 > > >  		}
 > > > +#endif
 > > 
 > > This change is wrong.
 > > 
 > > If you're going to do this, it's much better to define it to the
 > > correct value in this case (which is decimal '13').
 > 
 > Its sparc specific stuff so presumably all sparc stuff had the register
 > ?. I can change and resubmit though - no problem

The error is that modpost.c is compiled against the C library elf headers
instead of the kernel's own elf headers. My #ifndef patch is just a workaround
for a missing -Iinclude and possibly -nostdinc when modpost.c is compiled.

David's response to that was that I should update my C library headers
instead. This is doable, but kind of defeats the purpose of having test
machines with old user-spaces around in the first place.

Linus once said that Linux did its own offsetof() just to avoid relying
on a fully working user-space...
