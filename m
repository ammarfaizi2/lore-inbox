Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWC2Xs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWC2Xs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWC2Xs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:48:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:62231 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751286AbWC2Xs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:48:27 -0500
X-IronPort-AV: i="4.03,145,1141632000"; 
   d="scan'208"; a="16842704:sNHT43509704"
Message-Id: <200603292348.k2TNmNg12952@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Christoph Lameter'" <clameter@sgi.com>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Zoltan Menyhart" <Zoltan.Menyhart@free.fr>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
Subject: RE: Fix unlock_buffer() to work the same way as bit_unlock()
Date: Wed, 29 Mar 2006 15:49:08 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZTiSx5Na2enzwfRLenbGLB5PZsVAAAH2BQ
In-Reply-To: <Pine.LNX.4.64.0603291529160.26011@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote on Wednesday, March 29, 2006 3:33 PM
> Hmmm... Maybe we therefore need to add a mode to each bit operation in 
> the kernel?
> 
> With that we can also get rid of the __* version of bitops.
> 
> Possible modes are
> 
> NON_ATOMIC 	Do not perform any atomic ops at all.
> 
> ATOMIC		Atomic but unordered
> 
> ACQUIRE		Atomic with acquire semantics (or lock semantics)
> 
> RELEASE 	Atomic with release semantics (or unlock semantics)
> 
> FENCE		Atomic with full fence.
> 
> This would require another bitops overhaul.
> 
> Maybe we can preserve the existing code with bitops like __* mapped to 
> *(..., NON_ATOMIC) and * mapped to *(..., FENCE) and the gradually fix the 
> rest of the kernel.


Is gcc smart enough to turn constant argument and collapse inline of
inline function?  I hope it does.

Lots of other comments on actual code, but I will defer that until
some consensus is made on the API.  This would be nice to have.

- Ken
