Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUCMSTe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 13:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263157AbUCMSTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 13:19:34 -0500
Received: from mail.kroah.org ([65.200.24.183]:1978 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263154AbUCMSTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 13:19:31 -0500
Date: Sat, 13 Mar 2004 10:14:29 -0800
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] kref, a tiny, sane, reference count object
Message-ID: <20040313181429.GB29208@kroah.com>
References: <1zcH2-KO-11@gated-at.bofh.it> <m3y8q4dhfz.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3y8q4dhfz.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 02:06:56PM +0100, Andi Kleen wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > Comments are appreciated and welcomed.
> 
> I really don't see the advantage of this. Writing the same using
> atomic_inc/ atomic_dec_and_test() implicitely is basically as clean,
> and you will save the overhead of carrying a release() pointer
> around. And the "patterns" for that are easy enough that I doubt
> people will get it wrong.

But people do get it wrong (I've seen it happen).  Using this keeps you
from having to write your own get, and put functions.  Multiply that by
every usb driver that wants to (and needs to) use this kind of logic,
and you have a lot of duplicated code that is unnecessary.

So we write it once, get it correct, and let everyone use it.  Isn't
that what the code in /lib is for?  :)

thanks,

greg k-h
