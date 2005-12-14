Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbVLNXCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbVLNXCL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbVLNXCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:02:11 -0500
Received: from ozlabs.org ([203.10.76.45]:60807 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965047AbVLNXCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:02:09 -0500
Subject: Re: [RFC][PATCH] Prevent overriding of Symbols in the Kernel,
	avoiding Undefined behaviour
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ashutosh Naik <ashutosh.naik@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, anandhkrishnan@yahoo.co.in,
       linux-kernel@vger.kernel.org, rth@redhat.com, akpm@osdl.org,
       Greg KH <greg@kroah.com>, alan@lxorguk.ukuu.org.uk
In-Reply-To: <81083a450512132146g1177b457q5fd6cc5685a3d3b3@mail.gmail.com>
References: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
	 <1134424878.22036.13.camel@localhost.localdomain>
	 <81083a450512130626x417d86c9w31f300555c99fdb2@mail.gmail.com>
	 <9a8748490512130849o73c14313l166e6dd360f32d70@mail.gmail.com>
	 <1134525816.30383.13.camel@localhost.localdomain>
	 <81083a450512132146g1177b457q5fd6cc5685a3d3b3@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 10:02:07 +1100
Message-Id: <1134601327.7773.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 11:16 +0530, Ashutosh Naik wrote:
> On 12/14/05, Rusty Russell <rusty@rustcorp.com.au> wrote:
> > We already do this to resolve (more) symbols, so I don't see it as a
> > problem.  However, I believe that lock is redundant here: we need both
> > locks to write the list, but either is sufficient for reading, and we
> > already hold the sem.
> 
> Was just wondering, in that case, if we really need the spinlock in
> resolve_symbol() function, where there exists a spinlock around the
> __find_symbol() function

Yes, I think that's redundant as well.  We're not altering the module
list itself, so either of the two locks is sufficient, and we have the
semaphore.

Patch welcome!
Rusty.
-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol

