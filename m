Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVCKEh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVCKEh1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 23:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVCKEh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 23:37:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:18393 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261171AbVCKEgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 23:36:51 -0500
Subject: Re: AGP bogosities
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Paul Mackerras <paulus@samba.org>, werner@sgi.com,
       Linus Torvalds <torvalds@osdl.org>, davej@redhat.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200503102002.47645.jbarnes@engr.sgi.com>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	 <200503101818.25033.jbarnes@engr.sgi.com>
	 <1110508715.32524.317.camel@gaston>
	 <200503102002.47645.jbarnes@engr.sgi.com>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 15:30:59 +1100
Message-Id: <1110515459.32556.346.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 20:02 -0800, Jesse Barnes wrote:
> On Thursday, March 10, 2005 6:38 pm, Benjamin Herrenschmidt wrote:
> > That one is even worse... from what I see in your lspci output, you have
> > no bridge with AGP capability at all, and the various AGP devices are
> > all siblings...
> 
> Both of the video cards are sitting on agp busses in agp slots hooked up to 
> host to agp bridges.
> 
> > Are you sure there is any real AGP slot in there ?
> 
> Yes :)

Well, according to your lspci, none of the bridges exposes a device with
AGP capabilities... It looks like you aren't exposing the host "self"
device on the bus. Do you have an AGP driver ? If yes, it certainly
can't use any of the generic code anyway ...

I still think that the matching between a bridge and a card should be a
bridge callback (with eventually a generic one that works for whatever
x86 are around) so that the bridge driver can deal with funky layouts. I
have no time to toy with this at the moment though ;)

Ben.


