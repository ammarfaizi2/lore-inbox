Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbUDJKIW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 06:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUDJKIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 06:08:21 -0400
Received: from gate.crashing.org ([63.228.1.57]:7369 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261979AbUDJKIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 06:08:20 -0400
Subject: Re: want to clarify powerpc assembly conventions in head.S and
	entry.S
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <4077A542.8030108@nortelnetworks.com>
References: <4077A542.8030108@nortelnetworks.com>
Content-Type: text/plain
Message-Id: <1081591559.25144.174.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 10 Apr 2004 20:05:59 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-10 at 17:41, Chris Friesen wrote:
> I'm doing some work in head.S and entry.S, and I just wanted to make
> sure that I had the conventions down.
> 
> According to the docs I read, r0 and r3-12 are caller-saves.  They seem
> to be saved in EXCEPTION_PROLOG_2 (head.S) and restored in
> ret_from_except() (entry.S).  Thus, if I add code in entry.S I should be
> able to use any of those registers, without having to worry about
> restoring them myself--correct?

Yes. For interrupts or faults that's right. Syscalls are a bit special
though.
 
> Also, I'm a bit confused about the three instances of the following line
> in entry.S:
> 
> 	stwcx.	r0,0,r1			/* to clear the reservation */
> 
> I don't see the corresponding lwarx instruction.  What reservation is it
> referring to?

This is to clear any possible pending reservation if any. The problem is
that the reservation mecanism only works accross multiple CPUs. A normal
store at an address covered by a reservation on the same CPU will not break
the reservation. Thus, to protect from that, any interrupt or exception
makes sure to return to the normal code flow with any pending reservation
cleared.

Ben.


