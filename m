Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266884AbUIATBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266884AbUIATBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 15:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUIATBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 15:01:16 -0400
Received: from mail.tmr.com ([216.238.38.203]:58377 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S266884AbUIATBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 15:01:15 -0400
Date: Wed, 1 Sep 2004 14:54:28 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Driver retries disk errors.
In-Reply-To: <1094049961.2777.3.camel@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1040901144804.17509B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sep 2004, Alan Cox wrote:

> On Mer, 2004-09-01 at 16:18, Bill Davidsen wrote:
> > If would probably be good to retry "read what you were asked, nothing 
> > more" on error, to avoid passing back errors caused by readahead. I 
> > suspect this would avoid some issues reading data off CD as well, where 
> > one software can read clean and another ends with a short image and error.
> 
> Sure but as I understand the block layer currently (and I may be missing
> something in the 2.6 code) I can't do that from a driver.
> 
Sorry, that was unclear. I was speaking of a general approach rather than
what would be done in the driver. Clearly that's best done at a higher
level. Drivers should not be making policy decisions of that type, but I
don't think it's good to return a read error caused by data the program
didn't request (ie. readahead).

Unless S.M.A.R.T is lying, that happens so seldom on disk that the
overhead of a retry doesn't matter. And on CD it makes things work where
currently they fail.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

