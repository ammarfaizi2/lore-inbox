Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVAZXUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVAZXUb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbVAZXTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:19:52 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:21431 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262458AbVAZSB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 13:01:58 -0500
Subject: Re: [RFC][PATCH 0/5] consolidate i386 NUMA init code
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <15640000.1106750236@flay>
References: <1106698985.6093.39.camel@localhost>  <15640000.1106750236@flay>
Content-Type: text/plain
Date: Wed, 26 Jan 2005 10:01:49 -0800
Message-Id: <1106762509.6093.67.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-26 at 06:37 -0800, Martin J. Bligh wrote:
> > The following five patches reorganize and consolidate some of the i386
> > NUMA/discontigmem code.  They grew out of some observations as we
> > produced the memory hotplug patches.
> > 
> > Only the first one is really necessary, as it makes the implementation
> > of one of the hotplug components much simpler and smaller.  2 and 3 came
> > from just looking at the effects on the code after 1.
> > 
> > 4 and 5 aren't absolutely required for hotplug either, but do allow
> > sharing a bunch of code between the normal boot-time init and hotplug
> > cases.  
> > 
> > These are all on top of 2.6.11-rc2-mm1.
> 
> Looks reasonable. How much testing have they had, on what platforms?

Built on all the i386 configs here:
http://sr71.net/patches/2.6.11/2.6.11-rc1-mm1-mhp1/configs/

Booted on x440 (summit and generic), numaq, 4-way PIII.  I would imagine
that any problem would manifest as the system simply not booting.  The
most likely to fail would be systems with DISCONTIG enabled, because
that's where the greatest amount of churn happened.  The normal !
DISCONTIG case still uses most of the same code.

Anyway, I think they're probably ready for a run in -mm, with the "if
the machines don't boot check these first" flag set.  Although, I'd
appreciate any other testing that anyone wants to throw at them.

-- Dave

