Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161114AbVLOFPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbVLOFPO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 00:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161100AbVLOFPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 00:15:13 -0500
Received: from ozlabs.org ([203.10.76.45]:41114 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161114AbVLOFPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 00:15:12 -0500
Subject: Re: [RFC][PATCH] Prevent overriding of Symbols in the Kernel,
	avoiding Undefined behaviour
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashutosh Naik <ashutosh.naik@gmail.com>, jesper.juhl@gmail.com,
       anandhkrishnan@yahoo.co.in, linux-kernel@vger.kernel.org,
       rth@redhat.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       kaos@ocs.com.au
In-Reply-To: <20051214204032.57c4c6ae.akpm@osdl.org>
References: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
	 <1134424878.22036.13.camel@localhost.localdomain>
	 <81083a450512130626x417d86c9w31f300555c99fdb2@mail.gmail.com>
	 <9a8748490512130849o73c14313l166e6dd360f32d70@mail.gmail.com>
	 <1134525816.30383.13.camel@localhost.localdomain>
	 <81083a450512132010t2596046bsf7a36f85df19b89c@mail.gmail.com>
	 <81083a450512132102g77f4a92kc894fcda9e9dc2a6@mail.gmail.com>
	 <20051214204032.57c4c6ae.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 16:15:04 +1100
Message-Id: <1134623704.7773.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 20:40 -0800, Andrew Morton wrote:
> Ashutosh Naik <ashutosh.naik@gmail.com> wrote:
> >
> > This patch ensures that an exported symbol  does not already exist in
> >  the kernel or in some other module's exported symbol table. This is
> >  done by checking the symbol tables for the exported symbol at the time
> >  of loading the module. Currently this is done after the relocation of
> >  the symbol.
> 
> This patch causes weird things to happen on ppc64.

And probably in general:

+       for (i = 0; i < mod->num_syms; i++)
+               if (!__find_symbol(mod->syms[i].name, &owner, &crc, 1)) {
+                       name = mod->syms[i].name;
+                       ret = -ENOEXEC;
+                       goto dup;

__find_symbol returns the value, or 0 on failure.  This test is
backwards, as is the one below it.

Rusty.
-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol

