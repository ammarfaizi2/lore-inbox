Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267548AbTACPVs>; Fri, 3 Jan 2003 10:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267547AbTACPVs>; Fri, 3 Jan 2003 10:21:48 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:18448 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S267546AbTACPVr>; Fri, 3 Jan 2003 10:21:47 -0500
Date: Fri, 03 Jan 2003 08:28:04 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: arjanv@redhat.com
cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] aic7xxx bouncing over 4G
Message-ID: <610650816.1041607684@aslan.scsiguy.com>
In-Reply-To: <1041166487.1338.1.camel@laptop.fenrus.com>
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com>	
 <176730000.1040430221@aslan.btc.adaptec.com>	
 <3E03BB0D.5070605@rackable.com>	
 <Pine.LNX.4.50L.0212280331110.30646-100000@freak.distro.conectiva>	
 <20021228091608.GA13814@louise.pinerecords.com>	
 <Pine.LNX.4.50L.0212281131580.26879-100000@imladris.surriel.com>	
 <705128112.1041102818@aslan.scsiguy.com>
 <1041166487.1338.1.camel@laptop.fenrus.com>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The main reason why the new driver "breaks" where the old one
>> doesn't is that the new driver does not perform an extra register
>> read to work-around chipsets that screw up memory mapped I/O.  There
>> are four solutions to this problem:
> 
> just to be sure...you're not talking about PCI posting right?
> can you explain in a bit more detail the exact behavior that is the
> problem ? (I'm sure a lot of other drivers will suffer the same so I
> consider it of general interest)

PCI posting is an expected (and desired) characteristic of PCI, so, no
I'm not complaining about that.  According to the PCI spec, prefetch
is only allowed for devices that explicitly indicate that they support
it (via a bit in their BAR registers).  Further, write combining and
byte merging are only allowed for prefetchable regions.  The Adaptec
parts do not set the prefetch bit and do not support either of these
options (most registers are 8bits anyway, so there was nothing to
gain by complicating the part with this support).  Some BIOSes ignore
this rule and attempt to prefetch and/or write combine transactions
to these chips.  Other BIOSes actually have an option so that the user
can say "ignore the rules".  The new tests are designed to weed out
this broken behavior and to fallback to PIO where prefetch and write
combining cannot come into play.

--
Justin

