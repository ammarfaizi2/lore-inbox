Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161101AbWI2QGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbWI2QGR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 12:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbWI2QGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 12:06:17 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:47512 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161101AbWI2QGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 12:06:15 -0400
Date: Fri, 29 Sep 2006 09:05:57 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Dong Feng <middle.fengdong@gmail.com>
cc: Andi Kleen <ak@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Paul Mackerras <paulus@samba.org>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How is Code in do_sys_settimeofday() safe in case of SMP and
 Nest Kernel Path?
In-Reply-To: <a2ebde260609290733m207780f0t8601e04fcf64f0a6@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0609290903550.23840@schroedinger.engr.sgi.com>
References: <a2ebde260609290733m207780f0t8601e04fcf64f0a6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006, Dong Feng wrote:

> For my understanding, an assignment between structs should be a
> bit-wise copy. Such operation is not atomic, so it can not be supposed

Byte or Machine word yes.

> SMP-safe. And the subsequent test-and-assign operation on firsttime is
> not atomic, either.

No its not atomic on its own. Correct.
 
> If the comments mean the subsequent code is SMP-safe and can prevent
> nest-kernel-path, how does it achieves that?

It relies on locking outside of do_sys_settimeofday(). Seems that this 
indicates locking is to be performed by the arch before calling 
do_sys_settimeofday. Looks suspicious to me. Check that this function is 
always called with the same lock.
