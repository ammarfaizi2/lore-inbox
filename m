Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbWEBRS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbWEBRS0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 13:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWEBRS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 13:18:26 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25725 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S964931AbWEBRSZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 13:18:25 -0400
Date: Tue, 02 May 2006 13:18:25 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: sched_clock() uses are broken
In-reply-to: <200605021901.13882.ak@suse.de>
X-X-Sender: nico@localhost.localdomain
To: Andi Kleen <ak@suse.de>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.64.0605021316380.28543@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20060502132953.GA30146@flint.arm.linux.org.uk>
 <p73slns5qda.fsf@bragg.suse.de> <20060502165009.GA4223@flint.arm.linux.org.uk>
 <200605021901.13882.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2006, Andi Kleen wrote:

> On Tuesday 02 May 2006 18:50, Russell King wrote:
> 
> > You're right assuming you have a 64-bit TSC, but ARM has at best a
> > 32-bit cycle counter which rolls over about every 179 seconds - with
> > gives a range of values from sched_clock from 0 to 178956970625 or
> > 0x29AAAAAA81.
> > 
> > That's rather more of a problem than having it happen every 208 days.
> 
> Ok but you know it's always 32bit right? You can fix it up then
> with your proposal of a sched_diff()
> 
> The problem would be fixing it up with a unknown number of bits.

Just shift it left so you know you always have the most significant bits 
valid.  The sched_diff() would take care of scaling it back to nanosecs.


Nicolas
