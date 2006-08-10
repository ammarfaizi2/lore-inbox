Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422657AbWHJRqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422657AbWHJRqz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422661AbWHJRqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:46:54 -0400
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:36757 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1422657AbWHJRqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:46:54 -0400
Date: Thu, 10 Aug 2006 13:39:17 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: annotate the rest of entry.s::nmi
To: "Jan Beulich" <jbeulich@novell.com>
Cc: linux-kernel@vger.kernel.org, "Andi Kleen" <ak@suse.de>
Message-ID: <200608101343_MC3-1-C7B1-9E81@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44DB532F.76E4.0078.0@novell.com>

On Thu, 10 Aug 2006 15:39:27 +0200, Jan Beulich wrote:
>
> >> The point is that the push-es in FIX_STACK() aren't annotated, so
> >> things won't be correct at those points anyway.
> >
> >I have a patch here that adds that, but it won't compile
> >because that part of the NMI handler is un-annotated:
> 
> But you didn't clarify why you need this piece of code annotated...

Uh, which one didn't I clarify?

FIX_STACK() is already invoked from debug(), which is annotated, but
FIX_STACK() isn't.  And that messes with the stack, so for a few
instructions the annotations are all wrong.

When I annotated FIX_STACK(), I found entry.S wouldn't compile because
nmi() included FIX_STACK() but was completely missing annotations
in that piece. So I added them so FIX_STACK()'s annotations would
compile...

Should I send a combined patch, leave the two patches separate, or just
drop it?

-- 
Chuck

