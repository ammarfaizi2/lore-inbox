Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVKODLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVKODLc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 22:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVKODLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 22:11:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20940 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932316AbVKODLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 22:11:31 -0500
Date: Mon, 14 Nov 2005 22:10:53 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org,
       hugh@veritas.com, Dave Airlie <airlied@linux.ie>
Subject: Re: 2.6.14 X spinning in the kernel
Message-ID: <20051115031053.GA32155@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org,
	hugh@veritas.com, Dave Airlie <airlied@linux.ie>
References: <1132012281.24066.36.camel@localhost.localdomain> <20051114161704.5b918e67.akpm@osdl.org> <1132015952.24066.45.camel@localhost.localdomain> <20051114173037.286db0d4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114173037.286db0d4.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 05:30:37PM -0800, Andrew Morton wrote:

 > > CPU0:
 > > ffffffff8053c750 0000000000000000 00000000000018ff ffff81011c9a4230
 > >        ffff81011c9a4000 ffffffff8053c788 ffffffff8026de8f
 > > ffffffff8053c7a8
 > >        ffffffff80119591 ffffffff8053c7a8
 > > Call Trace: <IRQ> <ffffffff8026de8f>{showacpu+47}
 > > <ffffffff80119591>{smp_call_function_interrupt+81}
 > >        <ffffffff8010e968>{call_function_interrupt+132}  <EOI>
 > > <ffffffff880fa225>{:radeon:radeon_do_wait_for_idle+117}
 > >        <ffffffff880fa236>{:radeon:radeon_do_wait_for_idle+134}
 > >        <ffffffff880fa590>{:radeon:radeon_do_cp_idle+336}
 > > <ffffffff880fc215>{:radeon:radeon_do_release+85}
 > >        <ffffffff88104369>{:radeon:radeon_driver_pretakedown+9}
 > >        <ffffffff802783aa>{drm_takedown+74}
 > 
 > ah-hah.  We've had machines stuck in radeon_do_wait_for_idle() before.  In
 > fact, my workstation was doing it a year or two back.
 > 
 > Are you able to identify the most recent kernel which didn't do this?
 > 
 > David, is there a common cause for this?  ISTR that it's a semi-FAQ.

We've seen a few reports of this in the Fedora bugzilla over the
last year or so too. It seems to come and go.  The best explanation
I've heard so far is "The GPU got really confused".

		Dave

