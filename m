Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270291AbTHGPZD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 11:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269981AbTHGPZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:25:03 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:57343 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S270489AbTHGPY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:24:26 -0400
Date: Thu, 7 Aug 2003 11:26:54 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp64-178.boston.redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pivot_root solved by patch to 2.4.22-pre7
In-Reply-To: <1060257509.3168.26.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0308071120210.894-100000@dhcp64-178.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 7 Aug 2003, Alan Cox wrote:

> On Mer, 2003-08-06 at 07:27, Rene Mayrhofer wrote:
> > Hi all,
> > 
> > The problem with pivot_root that appeared in 2.4.21-ac4 and the 
> > 2.4.22-pre kernels is now solved (at least for my case) by applying the 
> > trvial patch sent by Jason Baron.
> 
> The patch shouldnt be needed or make any difference. I have to
> understand why its fixing the problem and fix it properly yet (or
> someone does)
> 
> 
 
it clearly makes a difference.

the unshare_files change causes init to no longer share the same fd table
with the other kernel threads. thus, when init closes or opens fds it does
not affect the other kernel threads. this patch allows init to continue to
share the same fd table with the other kernel threads as before the
unshare_files change. it does not compromise the intention of the
unshare_files change afaik. 

-Jason

