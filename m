Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263933AbTICRC2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbTICRC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:02:28 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:35597
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263933AbTICRCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:02:21 -0400
Subject: Re: pdflush question...
From: Robert Love <rml@tech9.net>
To: Daniel Blueman <daniel.blueman@gmx.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <14227.1062581053@www37.gmx.net>
References: <14227.1062581053@www37.gmx.net>
Content-Type: text/plain
Message-Id: <1062609171.7000.3.camel@boobies.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Wed, 03 Sep 2003 13:12:51 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-03 at 05:24, Daniel Blueman wrote:
> Is it worth having a kernel config option to vary the number of 'pdflush'
> kernel threads?

I suspect no.

> For embedded, systems with no swap and maybe uniproc (?), perhaps one
> pdflush kthread would do?

Yes.  Definitely.  In fact, I think that, for all systems, the initial
default should perhaps be one.

But note that the reason for n>1 pdflush threads is neither swap or
processor related.  The multiple threads can keep multiple block devices
busy, since one thread blocking on I/O will not affect another one.

I guess the real test would be to set MIN_PDFLUSH_THREADS to one and see
if one is enough for the average machines.  If the number quickly jumps
to 2 or more... then we know its a bad idea.

> Perhaps more generally, the number could be linked to the number of
> processors and/or swap devices or spindles- this would eliminate having to configure
> it, and improve downward and upward scaling, perhaps?

Number of spindles, yes.  But how do we know that?  And its just the
number of busy spindles, really.

I say we drop down to one.

	Robert Love


