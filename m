Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbUKHRRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbUKHRRM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbUKHRQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:16:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:26331 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261934AbUKHRLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 12:11:55 -0500
Date: Mon, 8 Nov 2004 09:11:45 -0800
From: Chris Wright <chrisw@osdl.org>
To: John Levon <levon@movementarian.org>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, cliffw@osdl.org
Subject: Re: [PATCH][OPROFILE] disable preempt when calling smp_processor_id()
Message-ID: <20041108091145.D2357@build.pdx.osdl.net>
References: <20041105163221.J14339@build.pdx.osdl.net> <20041107165623.GA36328@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041107165623.GA36328@compsoc.man.ac.uk>; from levon@movementarian.org on Sun, Nov 07, 2004 at 04:56:23PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* John Levon (levon@movementarian.org) wrote:
> On Fri, Nov 05, 2004 at 04:32:21PM -0800, Chris Wright wrote:
> > smp_processor_id() is called w/out preempt disabled.  Use
> > get_cpu()/put_cpu() instead.  Should this be put_cpu_no_resched()?
> 
> No, the patch below looks fine

I realized over the weekend that it's still broken.  And Cliff hit it
in some tests he ran here.  The sync_buffer() function can sleep, and
while the unprotected call to smp_processor_id() is no longer a problem,
scheduling with preempt disabled is.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
