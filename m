Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTHFOgo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 10:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTHFOgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 10:36:44 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:33765 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S263407AbTHFOgn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 10:36:43 -0400
Date: Wed, 6 Aug 2003 16:33:14 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Pavel Machek <pavel@ucw.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Adrian Bunk <bunk@fs.tum.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
In-Reply-To: <20030806110855.GA583@elf.ucw.cz>
Message-ID: <Pine.GSO.3.96.1030806162050.26399A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003, Pavel Machek wrote:

> > >   Note that this can also allow Step-A 486's to correctly run multi-thread
> > >   applications since cmpxchg has a wrong opcode on this early CPU.
> > > 
> > >   Don't use this to enable multi-threading on an SMP machine, the lock
> > >   atomicity can't be guaranted!
> > 
> > That is of course the other problem with this approach - you can't
> > really get the intended results without some extremely heavyweight code
> > (using an IPI to halt all CPU's, doing the access and then resuming
> > them)
> 
> Hopefully there are not too many SMP-486 machines out there ;-).

 Step-A i486 processors are supposedly very rare and they were the
earliest ones (predating the DX suffix), so they were probably never used
for SMP systems.  And I think the i82489DX APIC was introduced a bit later
anyway -- we don't support non-APIC SMP implementations. 

 BTW, the step-A i486 reused opcodes of the famous i386's ibts and xbts
instructions.  Once the chips were out, Intel discovered there is actually
some software out there expecting ibts/xbts semantics with these opcodes,
so the encoding of cmpxchg was quickly changed. ;-)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

