Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWI1Eyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWI1Eyg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 00:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWI1Eyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 00:54:35 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:39895 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750802AbWI1Eye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 00:54:34 -0400
Message-ID: <451B5587.2050601@garzik.org>
Date: Thu, 28 Sep 2006 00:54:31 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-scsi@vger.kernel.org, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Illustration of warning explosion silliness
References: <20060928005830.GA25694@havoc.gtf.org>	<20060927183507.5ef244f3.akpm@osdl.org>	<451B29FA.7020502@garzik.org>	<20060927203417.f07674de.akpm@osdl.org>	<451B4D58.9070401@garzik.org>	<20060927213628.ef12b1ed.akpm@osdl.org> <20060927214428.9e5c0e79.akpm@osdl.org>
In-Reply-To: <20060927214428.9e5c0e79.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 27 Sep 2006 21:36:28 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
>> device_for_each_child() 
> 
> All that being said, device_for_each_child() is rather broken by design. 
> It walks a list of items applying a function to them and bales out on
> first-error.

Or, like scsi_sysfs.c, it stops when it meets the first match.  Which is 
a common thing to do.


> There's no way in which the caller can know which items have been operated
> on, nor which items have yet to be operated on, nor which item experienced
> the failure.  Any caller which is serious about error recovery presumably
> won't use it, unless the callback function happens to be something which
> makes no state changes.

A simple integer return error doesn't tell you all that information 
either.  The actor must obviously store that additional information 
somewhere, if it cares.

But whatever.  I give up.  I'm going back to working on the libata 
warnings each build spits out (iomap).

	Jeff


