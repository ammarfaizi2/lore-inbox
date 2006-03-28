Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWC1X2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWC1X2L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWC1X2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 18:28:11 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:59277 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S964831AbWC1X2K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 18:28:10 -0500
Subject: Re: [Devel] Re: [RFC] Virtualization steps
From: Sam Vilain <sam@vilain.net>
To: Kir Kolyshkin <kir@sacred.ru>
Cc: devel@openvz.org, linux-kernel@vger.kernel.org
In-Reply-To: <4429B789.4030209@sacred.ru>
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au>
	 <1143228339.19152.91.camel@localhost.localdomain>
	 <4428BB5C.3060803@tmr.com>  <4428DB76.9040102@openvz.org>
	 <1143583179.6325.10.camel@localhost.localdomain>
	 <4429B789.4030209@sacred.ru>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 11:28:21 +1200
Message-Id: <1143588501.6325.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-29 at 02:24 +0400, Kir Kolyshkin wrote:
> >Huh?  You managed to measure it!?  Or do you just mean "negligible" by
> >"1-2 per cent" ?  :-)
> We run different tests to measure OpenVZ/Virtuozzo overhead, as we do 
> care much for that stuff. I do not remember all the gory details at the 
> moment, but I gave the correct numbers: "1-2 per cent or so".
> 
> There are things such as networking (OpenVZ's venet device) overhead, a 
> fair cpu scheduler overhead, something else.
> 
> Why do you think it can not be measured? It either can be, or it is too 
> low to be measured reliably (a fraction of a per cent or so).

Well, for instance the fair CPU scheduling overhead is so tiny it may as
well not be there in the VServer patch.  It's just a per-vserver TBF
that feeds back into the priority (and hence timeslice length) of the
process.  ie, you get "CPU tokens" which deplete as processes in your
vserver run and you either get a boost or a penalty depending on the
level of the tokens in the bucket.  This doesn't provide guarantees, but
works well for many typical workloads.  And once Herbert fixed the SMP
cacheline problems in my code ;) it was pretty much full speed.  That
is, until you want it to sacrifice overall performance for enforcing
limits.

How does your fair scheduler work?  Do you just keep a runqueue for each
vps?

To be honest, I've never needed to determine whether its overhead is 1%
or 0.01%, it would just be a meaningless benchmark anyway :-).  I know
it's "good enough for me".

Sam.

