Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261911AbSJAP5M>; Tue, 1 Oct 2002 11:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262084AbSJAP5M>; Tue, 1 Oct 2002 11:57:12 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:52413 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261911AbSJAP5L>; Tue, 1 Oct 2002 11:57:11 -0400
Date: Tue, 1 Oct 2002 18:03:03 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dave Jones <davej@codemonkey.org.uk>
cc: "David L. DeGeorge" <dld@degeorge.org>, linux-kernel@vger.kernel.org
Subject: Re: CPU/cache detection wrong
In-Reply-To: <20021001151525.GA32467@suse.de>
Message-ID: <Pine.GSO.3.96.1021001171405.13606L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, Dave Jones wrote:

>  > > Some of the tualatins have an errata which makes L2 cache sizing
>  > > impossible. They actually report they have 0K L2 cache. By checking
>  > > the CPU model, we can guess we have at least 256K (which is where Linux
>  > > got that number from in your case). But this however means the 512K
>  > > models will report as 256K too.
>  > > To work around it, boot with cachesize=512 and all will be good.
>  > 
>  >  Strange -- why not to default to 256K and override it with the value
>  > obtained from a cache descriptor if != 0, then?
> 
> Because the cache descriptor IS zero. So we default to 256K.

 You wrote "some of", so I suppose others are OK.  I meant those others. 
Anyway -- is it a new problem?  I can't see it documented in the current
P3 spec update.  That's weird -- Intel might hesitate documenting
weirdnesses of their chips, however they tend to include such simple and
obvious errata in the update.

 The spec actually states the L2 descriptor for the P3 may be as follows:

- 0x43 -- 512kB, unified,

- 0x82 -- 256kB, 8-way set associative,

- 0x83 -- 512kB, 8-way set associative.

The last descriptor is omitted from the list of known types in cache_table
in 2.4.20-pre8 -- could it be the culprit? 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

