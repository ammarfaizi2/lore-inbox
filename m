Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269887AbUJGWvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269887AbUJGWvc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269847AbUJGWQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:16:29 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:55566 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S269697AbUJGWM7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:12:59 -0400
Date: Thu, 7 Oct 2004 23:12:55 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] APIC physical broadcast for i82489DX
In-Reply-To: <20041007183203.GW9106@holomorphy.com>
Message-ID: <Pine.LNX.4.58L.0410072244570.27899@blysk.ds.pg.gda.pl>
References: <200410071609.i97G9reQ003072@hera.kernel.org>
 <20041007183203.GW9106@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, William Lee Irwin III wrote:

> > @@ -91,7 +91,7 @@
> >  	unsigned int lvr, version;
> >  	lvr = apic_read(APIC_LVR);
> >  	version = GET_APIC_VERSION(lvr);
> > -	if (version >= 0x14)
> > +	if (!APIC_INTEGRATED(version) || version >= 0x14)
> >  		return 0xff;
> >  	else
> >  		return 0xf;
> 
> This is the same as version <= 0xf || version >= 0x14; I'm rather

 I suppose defining a macro called something like APIC_XAPIC(x) to (x >= 
0x14) might actually have some sense, although unlike with the i82489DX, 
there is no promise for this to be always true.

> suspicious, as the docs have long since been purged, making this

 AFAIK i82489DX documents were never available online and I suppose they
might have never existed in a PDF form.  You could have ordered hardcopies
in mid 90's.

> hopeless for anyone without archives (or a good memory) dating back to
> that time to check. All that's really needed is citing the version that
> comes out of the version register and checking other APIC
> implementations to verify they don't have versions tripping this check,

 The APIC_INTEGRATED() macro reflects the range reserved for the i82489DX.  
Both "Multiprocessor Specification" and "IA-32 Intel Architecture Software
Developer's Manual, Vol.3" which are available online specify it clearly
and explicitly.  AFAIK, there is no integrated APIC implementation that
would violate it (unlike with I/O APICs), so what's the problem?  If a 
buggy chip appears, we can revisit this assumption.

> the latter of which is feasible for those relying on still-extant
> documentation. Better yet would be dredging up the docs... So, what is
> the range of the version numbers reported by i82489DX's?

 The i82489DX datasheet documents 0x01 for the chip and the
implementations I've encountered so far agree.

  Maciej
