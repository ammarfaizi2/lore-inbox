Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbUJYVRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbUJYVRO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbUJYVJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 17:09:20 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:58634 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262022AbUJYVA4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 17:00:56 -0400
Date: Mon, 25 Oct 2004 22:00:48 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andi Kleen <ak@suse.de>
Cc: Corey Minyard <minyard@acm.org>, linux-kernel@vger.kernel.org
Subject: Re: Race betwen the NMI handler and the RTC clock in practially all
 kernels II
In-Reply-To: <20041025204144.GA27518@wotan.suse.de>
Message-ID: <Pine.LNX.4.58L.0410252157440.10974@blysk.ds.pg.gda.pl>
References: <417D2305.3020209@acm.org.suse.lists.linux.kernel>
 <p73u0sik2fa.fsf@verdi.suse.de> <Pine.LNX.4.58L.0410252054370.24374@blysk.ds.pg.gda.pl>
 <20041025201758.GG9142@wotan.suse.de> <20041025204144.GA27518@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004, Andi Kleen wrote:

> So it's impossible to check the old value. The original code is the only
> way to do this (if it's even needed, Intel also doesn't say anything
> about this bit being a flip-flop). Only possible change would be to 
> write an alternative index.

 You can't read the old value, but you can have a shadow variable written
every time the real index is written.  Since NMIs are not preemptible and
this is a simple producer-consumer access, no mutex around accesses to the
variable is needed.

  Maciej
