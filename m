Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbUJYVDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbUJYVDk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbUJYU2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 16:28:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:24541 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261262AbUJYUO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 16:14:27 -0400
Date: Mon, 25 Oct 2004 22:14:23 +0200
From: Andi Kleen <ak@suse.de>
To: Corey Minyard <minyard@acm.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Race betwen the NMI handler and the RTC clock in practially all kernels
Message-ID: <20041025201423.GF9142@wotan.suse.de>
References: <417D2305.3020209@acm.org.suse.lists.linux.kernel> <p73u0sik2fa.fsf@verdi.suse.de> <417D5903.6090106@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417D5903.6090106@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 02:50:27PM -0500, Corey Minyard wrote:
> According to the comments in 2.4, this code causes the NMI to be 
> re-asserted if another NMI occurred while the NMI handler was running.  
> I have no idea how twiddling with these CMOS registers causes this to 
> happen, but that is supposed to be the intent.  I don't think it has 

I doubt it does anything useful on anything modern.

> anything to do with delays.

Old chipsets didn't like it when you did two accesses to related
registers in a row. Doing a dummy io inbetween causes an delay
that is long enough that fixes that. I think it was just an old fashioned 
way to write out_p(). You need some kind of dummy register for this
and the code used the wrong one.

> 
> I would like to know what this code really does before removing it.

It clears and sets the NMI enable bit of the chipset. IMHO it's useless
because no chipset should clear it. If anything you can just unconditionally
reenable it.

-Andi
