Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263075AbUCSShW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 13:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263097AbUCSShW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 13:37:22 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45240 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S263075AbUCSShU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 13:37:20 -0500
Message-Id: <200403191836.i2JIajT6023096@eeyore.valparaiso.cl>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Margit Schubert-While <margitsw@t-online.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.xx - linux/firmware.h - missing include 
In-Reply-To: Your message of "Fri, 19 Mar 2004 15:30:08 GMT."
             <20040319153008.D14431@flint.arm.linux.org.uk> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Fri, 19 Mar 2004 14:36:45 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk>
> On Fri, Mar 19, 2004 at 04:17:45PM +0100, Margit Schubert-While wrote:
> > The prototype for request_firmware uses a struct device parameter.
> > This is only defined if linux/device.h is included.
> > Fix is simple : include linux/device.h in linux/firmware.h
> 
> That way leads to madness in the includes.  firmware.h does not need
> the definition of struct device, it only needs to know that struct
> device exists.
> 
> You can do this via:
> 
> struct device;
> 
> before its use - this works much the same way as a function declaration
> vs. function prototype.

Iff it is a _pointer_. If it needs a full struct, this won't work. And if
it is a pointer, a simple:

  int foo(struct bar *);

will do for prototype, even if struct bar hasn't been mentioned earlier.

In case the struct is really needed, it is better just to ensure the
respective .h are included in the right order, not nest them.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
