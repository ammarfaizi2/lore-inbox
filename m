Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbUJYUtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbUJYUtN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 16:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUJYUsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 16:48:55 -0400
Received: from cantor.suse.de ([195.135.220.2]:648 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262013AbUJYUsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:48:07 -0400
Date: Mon, 25 Oct 2004 22:41:44 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
       Corey Minyard <minyard@acm.org>, linux-kernel@vger.kernel.org
Subject: Re: Race betwen the NMI handler and the RTC clock in practially all kernels II
Message-ID: <20041025204144.GA27518@wotan.suse.de>
References: <417D2305.3020209@acm.org.suse.lists.linux.kernel> <p73u0sik2fa.fsf@verdi.suse.de> <Pine.LNX.4.58L.0410252054370.24374@blysk.ds.pg.gda.pl> <20041025201758.GG9142@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025201758.GG9142@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  It's not the dummy read that causes the problem.  It's the index write
> > that does.  It can be solved pretty easily by not changing the index.  It
> 
> True. It has to be cached once.

I checked the Intel datasheets now. Problem is that they define this
register as read-only, and the only way to access it works using
a very chipset specific way (alternative LPC interface) 

So it's impossible to check the old value. The original code is the only
way to do this (if it's even needed, Intel also doesn't say anything
about this bit being a flip-flop). Only possible change would be to 
write an alternative index.

-Andi
