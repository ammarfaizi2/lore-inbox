Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264593AbTFYPqX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264601AbTFYPqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:46:23 -0400
Received: from air-2.osdl.org ([65.172.181.6]:16553 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264593AbTFYPqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:46:21 -0400
Date: Wed, 25 Jun 2003 08:57:14 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, macro@ds2.pg.gda.pl, akpm@digeo.com
Subject: Re: [PATCH] unexpected IO-APIC update
Message-Id: <20030625085714.3cd7759e.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0306241825280.1041-100000@home.transmeta.com>
References: <20030624161003.20fbbbd4.rddunlap@osdl.org>
	<Pine.LNX.4.44.0306241825280.1041-100000@home.transmeta.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jun 2003 18:31:12 -0700 (PDT) Linus Torvalds <torvalds@transmeta.com> wrote:

| 
| On Tue, 24 Jun 2003, Randy.Dunlap wrote:
| >
| > +	if (reg_01.version >= 0x20)
| > +		*(int *)&reg_03 = io_apic_read(apic, 3);
| 
| There's a lot of these 
| 
| 	*(int *)&reg_03
| 
| kinds of things there, and the fact is, gcc's alias analysis doesn't like 
| them, _and_ they are ugly.
| 
[snippage]
| 
| But the ugliness part I care about, and I wonder if it wouldn't be better 
| in this case to just make the register definition a "union", and have 
| something like
| 
| 	union reg_03 {
| 		u32 value;
| 		struct {
| 			u32 boot_DT:1,
| 			    reserved:31;
| 		} bits;
| 	};
| 
| and then you can avoid the ugly dereference/cast/address-of thing, and 
| just say
| 
| 	reg_03.value
| 
| or
| 
| 	reg_03.bits.boot_DT
| 
| which looks a lot cleaner.
| 
| This is what unions are _designed_ for.

Sure, I'll do that.

--
~Randy
~ http://developer.osdl.org/rddunlap/ ~ http://www.xenotime.net/linux/ ~
