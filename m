Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTFYMKV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 08:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbTFYMKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 08:10:21 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:44727 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263632AbTFYMKS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 08:10:18 -0400
Date: Wed, 25 Jun 2003 18:16:33 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, richard <richardj_moore@uk.ibm.com>,
       suparna <suparna@in.ibm.com>
Subject: Re: [patch] kprobes for 2.5.73 with single-stepping out-of-line
Message-ID: <20030625181633.A20678@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <20030624140926.A17908@in.ibm.com.suse.lists.linux.kernel> <p73n0g74g8q.fsf@oldwotan.suse.de> <20030625161113.A20435@in.ibm.com> <20030625115202.GB9645@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030625115202.GB9645@wotan.suse.de>; from ak@suse.de on Wed, Jun 25, 2003 at 01:52:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 01:52:02PM +0200, Andi Kleen wrote:
> On Wed, Jun 25, 2003 at 04:11:13PM +0530, Vamsi Krishna S . wrote:
> > On Tue, Jun 24, 2003 at 06:01:09PM +0200, Andi Kleen wrote:
> > > "Vamsi Krishna S ." <vamsi@in.ibm.com> writes:
> > > 
> > > 
> > > > +static struct kprobe *current_kprobe;
> > > 
> > > This global variable is quite unclean. It looks like it is for passing
> > > function arguments around. Why is it needed? 
> > > 
> > This is used for keeping track of the probe that is currently being
> > handled. This information is needed to be kept across a 
> > trap 3 - singlestep - trap 1. So, we set store the current probe in
> > this variable while handling trap 3, for use while handling the
> > subsequent trap 1.
> 
> But how can this be SMP safe? Do you hold a lock during all this?
> 
Yes.. in the interests of keeping the locking to a minimum, only one
probe can be handled at a time, even on SMP.

> -Andi
Thanks,
Vamsi.
-- 
Vamsi Krishna S.
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
