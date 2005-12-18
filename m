Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbVLRFlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbVLRFlw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 00:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbVLRFlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 00:41:52 -0500
Received: from ns2.suse.de ([195.135.220.15]:31959 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030186AbVLRFlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 00:41:51 -0500
Date: Sun, 18 Dec 2005 06:41:50 +0100
From: Andi Kleen <ak@suse.de>
To: Robert Walsh <rjwalsh@pathscale.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 03/13]  [RFC] ipath copy routines
Message-ID: <20051218054149.GE23384@wotan.suse.de>
References: <200512161548.HbgfRzF2TysjsR2G@cisco.com> <200512161548.lRw6KI369ooIXS9o@cisco.com> <20051217123833.1aa430ab.akpm@osdl.org> <1134859243.20575.84.camel@phosphene.durables.org> <p73k6e3dr05.fsf@verdi.suse.de> <1134884189.20575.129.camel@phosphene.durables.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134884189.20575.129.camel@phosphene.durables.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 09:36:29PM -0800, Robert Walsh wrote:
> On Sun, 2005-12-18 at 04:27 +0100, Andi Kleen wrote:
> > Robert Walsh <rjwalsh@pathscale.com> writes:
> > > 
> > > Any chance we could get these moved into the x86_64 arch directory,
> > > then?  We have to do double-word copies, or our chip gets unhappy.
> > 
> > Standard memcpy will do double word copies if everything is suitably
> > aligned. Just use that.
> 
> This is dealing with buffers that may be passed in from user space, so
> there's no guarantee of alignment for either the start address or the
> length.

So how can you do double word access when the length is not a multiple of four? 

The current x86-64 copy_from_user will use double work access even in that case,
except for the end of course.

But what you're doing is so deeply unportable it's not funny. I am not
sure such a unportable driver even belongs in the kernel.

If the code was really intended to run on user space addresses it 
was totally broken btw because it didn't handle exceptions.

-Andi

