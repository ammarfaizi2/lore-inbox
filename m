Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbULOK6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbULOK6q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 05:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbULOK6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 05:58:04 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:5059 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262320AbULOKzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 05:55:18 -0500
Date: Wed, 15 Dec 2004 11:55:10 +0100
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 32-bit syscalls from 64-bit process on x86-64?
Message-ID: <20041215105510.GF27225@wotan.suse.de>
References: <380350F3EC1@vcnet.vc.cvut.cz> <20041215042704.GE27225@wotan.suse.de> <1103107807.24540.23.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103107807.24540.23.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 02:50:07AM -0800, Jeremy Fitzhardinge wrote:
> On Wed, 2004-12-15 at 05:27 +0100, Andi Kleen wrote:
> > From 64bit-from-32bit the lcall is needed agreed. However as a 
> > warning it will not work for all calls since a few check a bit
> > in task_struct that says if the process is 32bit or 64bit
> > (rather rare though, most prominent is signal handling) 
> 
> When delivering a signal to a 64-bit process (ie, without TIF_IA32 set),
> do you think it should always set cs to be USER_CS?  At the moment, if
> cs is something else (ie, USER32_CS), it tries to deliver the signal
> with that current...

Hmm, in theory you could handle a 64bit signal frame from 32bit code
(just may need an assembly stub if you want the arguments). But it 
would be quite ugly agreed.

Perhaps it should force __USER_CS yes in this case, agreed.

There is a small risk of breaking someone, but it's very small.

I can do that change if you want.

BTW the long term plan is to get rid of the special cases to make
it easierto use the 32bit kernel ABI from a 64bit program.
This means signal handling will likely just check the code segment
at some  point to decide if it should set up 32bit or 64bit frames
and we'll probably do similar things with the other cases 
(except exec which needs to stay this way) 

If you're interested in this I guess that could be done sooner
with some patch submissions (hint hint ;)

-Andi
