Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311203AbSCSNj6>; Tue, 19 Mar 2002 08:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311212AbSCSNjs>; Tue, 19 Mar 2002 08:39:48 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:54181 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S311203AbSCSNjh>; Tue, 19 Mar 2002 08:39:37 -0500
Date: Tue, 19 Mar 2002 14:38:55 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: mingo@elte.hu, Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        oliend@us.ibm.com
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <89210000.1016215711@flay>
Message-ID: <Pine.GSO.3.96.1020319141335.12399G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2002, Martin J. Bligh wrote:

> Dave could explain this to you better than I could, but if I remember
> all this correctly what he was doing was really trying to was program
> the APR, not the TPR, but the APR is a read only register ... it's
> affected by the way you program the TPR. The docs are particularly
> opaque about how this really works. I've had pretty much exactly this
> argument with Dave before, and we thrashed out how it all worked in the
> process. 
> 
> What I normally look at is Section 7.5 (APIC) of Vol 3 of the PIII Intel
> docs.  These are very confusing in this area, and Dave had some better
> docs that I'll see if I can dig out. But if you look carefully at them
> (and you know how it's meant to work before you start) it makes sense in
> a twisted sort of way. 

 I've found i82489DX docs to be most comprehensive in this as well as
other areas.  The integrated APIC doesn't seem to differ much from the
i82489DX wrt the arbitration -- the only difference is the focus processor
checking feature that can't be disabled for the latter. 

> Dynamic distribution assigns incoming interrupts to the lowest priority
> processor, which is generally the least busy processor ... <snip> ...
> from all processors listed in the destination, the processor selected is
> the one whose current arbitration priority is the lowest. The latter is
> specified in the arbitration priority register (APR) ... <snip> ... If
> more than one processor shares the lowest priority, the processor with
> the highest arbitration priority (the unique value in the Arb ID
> register) is selected. 
> 
> The last sentence is how round robin happens on an SMP P3 system. I presume
> this is what fell off for the P4.

 Basically there is no way to arbitrate with the FSB delivery.

> Now look at the two paragraphs defining the TPR. The first para
> describes pretty much what you describe. Note that this operation would
> only require 4 bits.  Now look at the second para, where they define the
> 4 msbs as corresponding to the interrupt priorities, and mumble
> something about the 4 lsbs, giving very little real information. 
> 
> Now look at the section defining the APR, and look at the wierd
> algorithm, which does somewhat opaque things to derive the value of the
> APR from the TPR (and some other registers). It's easy to figure out
> that they're coupled, it's harder to figure out exactly how, and I can't
> remember exactly how this works right now. 

 Hmm, i82489DX docs explain it best, IIRC. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

