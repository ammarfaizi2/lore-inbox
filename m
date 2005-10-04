Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbVJDOeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbVJDOeL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 10:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVJDOeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 10:34:10 -0400
Received: from mail23.sea5.speakeasy.net ([69.17.117.25]:57756 "EHLO
	mail23.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932506AbVJDOeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 10:34:09 -0400
Date: Tue, 4 Oct 2005 10:34:07 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: John Richard Moser <nigelenki@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: The price of SELinux (CPU)
In-Reply-To: <434204F8.2030209@comcast.net>
Message-ID: <Pine.LNX.4.63.0510041026180.18246@excalibur.intercode>
References: <434204F8.2030209@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Oct 2005, John Richard Moser wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I've heard that SELinux has produced benchmarks such as 7% increased CPU
> load.

The overall performance hit across several micro and macro benchmarks, 
when last measured last year sometime, was around 7%, depending on 
workload and what you were testing.  It's a very rough figure and any 
serious benchmarking needs to be done for the intended workload.

The AVC is now linearly scalable (measured up to 32 processors) thanks to 
RCU and work by NEC.

>  Is this true and current?  Is it dependent on policy?  What is
> the policy lookup complexity ( O(1), O(n), O(nlogn)...)?  Are there
> other places where a bottleneck may exist aside from gruffing with the
> policy?  Isn't the policy actually in xattrs so it's O(1)?  Where else
> would an overhead that big come from aside from a lookup in a table?

The overhead is generally independent of policy size, as policy is cached 
in the AVC and most workloads use a trivial number of policy rules in a 
steady state (often less than 20).

So, generally, you'll only have a very small number of AVC entries active, 
although you could have some longish hash chains if policy has not been 
reloaded since boot.

Look in /selinux/avc for stats.

Googling for "selinux performance" will guide you to:
http://www.livejournal.com/users/james_morris/2153.html


- James
-- 
James Morris
<jmorris@namei.org>
