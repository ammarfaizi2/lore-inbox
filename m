Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVGLP3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVGLP3q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 11:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVGLP2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 11:28:00 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:27275 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261508AbVGLP0p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 11:26:45 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17107.57641.217499.429075@tut.ibm.com>
Date: Tue, 12 Jul 2005 10:26:33 -0500
To: Jason Baron <jbaron@redhat.com>
Cc: Tom Zanussi <zanussi@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, karim@opersys.com, varap@us.ibm.com,
       richardj_moore@uk.ibm.com
Subject: Re: Merging relayfs?
In-Reply-To: <Pine.LNX.4.61.0507121050390.25408@dhcp83-105.boston.redhat.com>
References: <17107.6290.734560.231978@tut.ibm.com>
	<Pine.LNX.4.61.0507121050390.25408@dhcp83-105.boston.redhat.com>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Baron writes:
 > 
 > On Mon, 11 Jul 2005, Tom Zanussi wrote:
 > 
 > > 
 > > Hi Andrew, can you please merge relayfs?  It provides a low-overhead
 > > logging and buffering capability, which does not currently exist in
 > > the kernel.
 > > 
 > 
 > One concern I had regarding relayfs, which was raised previously, was 
 > regarding its use of vmap, 
 > http://marc.theaimsgroup.com/?l=linux-kernel&m=110755199913216&w=2 On x86, 
 > the vmap space is at a premium, and this space is reserved over the entire 
 > lifetime of a 'channel'. Is the use of vmap really critical for 
 > performance?

Yes, the vmap'ed area is reserved over the lifetime of the channel,
but the typical usage of a channel is transient - allocate it at the
start of say a tracing run, and then vunmap it and free the memory
when done.  Unless you're using huge buffers, you wouldn't run into a
problem running out of vmalloc space, and typical applications should
be able to use relatively small buffers.

I don't really know how we would get around using vmap - it seems like
the alternatives, such as managing an array of pages or something like
that, would slow down the logging path too much to make it useful as a
low overhead logging mechanism.  I you have any ideas though, please
let me know.

Tom


