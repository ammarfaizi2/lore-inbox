Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270682AbTHJUoX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 16:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270684AbTHJUoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 16:44:23 -0400
Received: from cmu-24-35-14-252.mivlmd.cablespeed.com ([24.35.14.252]:64643
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S270682AbTHJUoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 16:44:21 -0400
Date: Sun, 10 Aug 2003 16:43:27 -0500 (CDT)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Bug 973] Presario laptop panic on boot
Message-ID: <Pine.LNX.4.44.0308101238380.7972-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since test3-mm1 was released I did some further testing.

If CONFIG_DEBUG_PAGE_ALLOC is set to y I get a panic on boot whether I am 
using "standard" kernels or -mm kernels.  There appears to be something 
fishy going on in the store_stackinfo function.

In "standard" kernels I have occasionally seen an oops in the synaptics 
code as detailed in bugzilla.  I have yet to see that in -mm kernels.  
However, I am uncertain whether that is because the problem is solved 
(doubtful imho), or because it is harder to trigger.  I have yet to find a 
way to reliably trigger the oops in any case, so this is going to be 
difficult to nail down unless it can be understood why the panic happens 
in store_stackinfo.

The synaptics support does appear improved in the mm kernels.  It is 
picking up the extended capabilities bits available, whereas the standard 
kernels do not.

So the question in my mind is whether there is a problem in 
store_stackinfo (this code is only executed when CONFIG_DEBUG_PAGE_ALLOC 
is set) or whether the panic is showing a problem elsewhere which is hard 
to trigger.  This also begs the question why I am apparently the only one 
who has run into this.  I didn't think my configuration was that unusual; 
others have certainly reported using Presario laptops.

