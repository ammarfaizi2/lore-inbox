Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268386AbUHLBVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268386AbUHLBVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 21:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268308AbUHLBV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 21:21:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45037 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268386AbUHLBUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 21:20:35 -0400
Date: Wed, 11 Aug 2004 21:20:22 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Kurt Garloff <garloff@suse.de>
cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
In-Reply-To: <20040811221903.GA14744@tpkurt.garloff.de>
Message-ID: <Xine.LNX.4.44.0408112110030.15343-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004, Kurt Garloff wrote:

> On Tue, Aug 10, 2004 at 10:16:29AM -0400, James Morris wrote:
> > Is this just an ia64 issue?  If so, then perhaps we should look at only
> > penalising ia64?  Otherwise, loading an LSM module is going to cause
> > expensive false unlikely() on _every_ LSM hook.
> 
> You should worry about the fast path.
> That's no LSM being loaded and just using the default capabilities.
> Which is what most users usse as of this time.

I'm not sure we can expect this to be true in the future.

> If you do call into any serious LSM, you'll spend much more CPU cycles
> anyway ...

Possibly, but keep in mind that your patch effectively adds 135 false
unlikely() calls throughout the kernel when an LSM is loaded.  Can you
provide figures for, say, the overhead of your patch (if any) with the BSD
securelevels LSM loaded?

Also, we still have the option of making COND_SECURITY ia64-specific.


- James
-- 
James Morris
<jmorris@redhat.com>


