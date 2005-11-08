Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030421AbVKHX6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbVKHX6P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 18:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030425AbVKHX6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 18:58:14 -0500
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:44736 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id S1030421AbVKHX6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 18:58:12 -0500
Date: Wed, 9 Nov 2005 10:57:59 +1100
From: David Gibson <dwg@au1.ibm.com>
To: linas <linas@austin.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net
Subject: Re: typedefs and structs
Message-ID: <20051108235759.GA28271@localhost.localdomain>
Mail-Followup-To: linas <linas@austin.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc64-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	bluesmoke-devel@lists.sourceforge.net
References: <17262.37107.857718.184055@cargo.ozlabs.ibm.com> <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com> <20051107185621.GD19593@austin.ibm.com> <20051107190245.GA19707@kroah.com> <20051107193600.GE19593@austin.ibm.com> <20051107200257.GA22524@kroah.com> <20051107204136.GG19593@austin.ibm.com> <1131412273.14381.142.camel@localhost.localdomain> <20051108232327.GA19593@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108232327.GA19593@austin.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 05:23:27PM -0600, Linas Vepstas wrote:
> On Mon, Nov 07, 2005 at 08:11:13PM -0500, Steven Rostedt was heard to remark:
> > On Mon, 2005-11-07 at 14:41 -0600, linas wrote:
> > 
> > don't use typedef to get rid of "struct".
> > 
> > This was for the simple reason, too many developers were passing
> > structures by value instead of by reference, just because they were
> > using a type that they didn't realize was a structure. 
> 
> That's a rather bizarre mistake to make, since, in order to 
> access a values in such a beast, you have to use a dot . instead 
> of an arrow -> and so it hits ou in the face that you passed a value
> instead of a reference.
> 
> ----
> Off-topic: There's actually a neat little trick in C++ that can 
> help avoid accidentally passing null pointers.  One can declare 
> function declarations as:
> 
>   int func (sturct blah &v) {
>     v.a ++; 
>     return v.b;
>   }
> 
> The ampersand says "pass argument by reference (so as to get arg passing
> efficiency) but force coder to write code as if they were passing by value"
> As a result, it gets difficult to pass null pointers (for reasons
> similar to the difficulty of passing null pointers in Java (and yes,
> I loathe Java, sorry to subject you to that))  Anyway, that's a C++ trick 
> only; I wish it was in C so I could experiment more and find out if I 
> like it or hate it.

I hate it: it obscures the fact that it's a pass-by-reference at the
callsite, which is useful information.  Although this is, admittedly,
the least confusing use of C++ reference types.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
