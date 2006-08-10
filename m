Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWHJIWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWHJIWq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 04:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWHJIWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 04:22:46 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:20949 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1751468AbWHJIWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 04:22:45 -0400
Message-Id: <44DB0927.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Thu, 10 Aug 2006 10:23:35 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Cc: <stsp@aknet.ru>, "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: annotate the rest of entry.s::nmi
References: <200608100101_MC3-1-C796-F8CA@compuserve.com>
In-Reply-To: <200608100101_MC3-1-C796-F8CA@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Chuck Ebbert <76306.1226@compuserve.com> 10.08.06 06:59 >>>
>Part of the NMI handler is missing annotations.  Just moving
>the RING0_INT_FRAME macro fixes it.  And additional comments
>should warn anyone changing this to recheck the annotations.

I have to admit that I can't see the value of this movement; the
code sequence in question was left un-annotated intentionally.
The point is that the push-es in FIX_STACK() aren't annotated, so
things won't be correct at those points anyway. Furthermore,
getting interrupted in any way while in this code path is going to
kill the system (and is just impossible AFAICT), so annotations
there also seem worthless. (I am actually surprised that I
annotated the code after nmi_16bit_stack, as that's similarly
constrained; even more, as I'm now looking at it, this code seems
outright wrong in using iret since that unmasks NMIs - Stas, is
your pending adjustment to the 16-bit stack handling going to
overcome this?)

The added comments certainly might be helpful, though there are
more places where frame state gets "inherited" across labels.

Jan
