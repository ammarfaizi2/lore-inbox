Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbVHYXn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbVHYXn3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 19:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbVHYXn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 19:43:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:59569 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965027AbVHYXn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 19:43:28 -0400
Subject: Re: [patch 8/8] PCI Error Recovery: PPC64 core recovery routines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Linas Vepstas <linas@austin.ibm.com>, John Rose <johnrose@austin.ibm.com>,
       akpm@osdl.org, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <17166.20904.543484.435446@cargo.ozlabs.ibm.com>
References: <20050823231817.829359000@bilge>
	 <20050823232143.003048000@bilge> <20050823234747.GI18113@austin.ibm.com>
	 <1124898331.24668.33.camel@sinatra.austin.ibm.com>
	 <20050824162959.GC25174@austin.ibm.com>
	 <17165.3205.505386.187453@cargo.ozlabs.ibm.com>
	 <1124930943.5159.168.camel@gaston> <20050825162118.GH25174@austin.ibm.com>
	 <1125006237.12539.23.camel@gaston>
	 <17166.20904.543484.435446@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 09:37:36 +1000
Message-Id: <1125013056.14185.0.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 09:18 +1000, Paul Mackerras wrote:
> Benjamin Herrenschmidt writes:
> 
> > Ok, so what is the problem then ? Why do we have to wait at all ? Why
> > not just unplug/replug right away ?
> 
> We'd have to be absolutely certain that the driver could not possibly
> take another interrupt or try to access the device on behalf of the
> old instance of the device by the time it returned from the remove
> function.  I'm not sure I'd trust most drivers that far...

Hrm... If a driver gets that wrong, then it will also blow up when
unloaded as a module. All drivers should be fully shut down by the time
they return from remove(). free_irq() is synchronous as is iounmap() and
both of those are usually called as part of remove(). I wouldn't be too
worried here.

Ben.


