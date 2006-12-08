Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164237AbWLHAgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164237AbWLHAgh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 19:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164235AbWLHAgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 19:36:37 -0500
Received: from mx2.cs.washington.edu ([128.208.2.105]:47834 "EHLO
	mx2.cs.washington.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1164234AbWLHAgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 19:36:36 -0500
Date: Thu, 7 Dec 2006 16:36:31 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
cc: Amit Choudhary <amit2030@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.19] drivers/media/video/cpia2/cpia2_usb.c: Free
 previously allocated memory (in array elements) if kmalloc() returns NULL.
In-Reply-To: <200612080109.27018.m.kozlowski@tuxland.pl>
Message-ID: <Pine.LNX.4.64N.0612071619260.12627@attu4.cs.washington.edu>
References: <20061206211317.b996bc34.amit2030@gmail.com>
 <200612080050.53895.m.kozlowski@tuxland.pl> <Pine.LNX.4.64N.0612071602540.3592@attu4.cs.washington.edu>
 <200612080109.27018.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006, Mariusz Kozlowski wrote:

> > > Just for future. Shorter and more readable version of your for(...) thing:
> > > 
> > > 	while (i--) {
> > > 		...
> > > 	}
> > > 
> > 
> > No, that is not equivalent.
> > 
> > You want
> > 	while (i-- >= 0) {
> > 		...
> > 	}
> > 
> 
> Not really. That will stop at -1 not 0.
> 

It depends on your intent.  Generally speaking,

	while (i--) {
		...
	}

is never what you want.  Adding the check for being greater than 0 stops 
potential bugs from signed int i being negative.  The only drawback on x86 
is that it sets a byte based on the greater condition with setg and tests 
it later with testb for every iteration.  This use of testb will _always_ 
use the same addressable byte registers for both its operands.

Based on this particular patch, I agree that

	while (i-- > 0) {
		...
	}

will do the job.  This is equivalent to the original for loop and ensures 
that a negative value of i is never iterated on (even though it admittedly 
would never be negative in this instance to begin with).

		David
