Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbUC1UyR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbUC1UyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:54:17 -0500
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:32177 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S262073AbUC1UyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:54:04 -0500
Date: Sun, 28 Mar 2004 13:54:39 -0700
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, Jamie Lokier <jamie@shareable.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040328205439.GE6405@bounceswoosh.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Jens Axboe <axboe@suse.de>, Jamie Lokier <jamie@shareable.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <4066191E.4040702@yahoo.com.au> <40662108.40705@pobox.com> <20040328135124.GA32597@mail.shareable.org> <40670A36.3000005@pobox.com> <20040328174013.GJ24370@suse.de> <4067101F.9030606@pobox.com> <20040328175559.GM24370@suse.de> <406713A8.6040206@pobox.com> <20040328180914.GN24370@suse.de> <406731A2.90205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <406731A2.90205@pobox.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28 at 15:12, Jeff Garzik wrote:
>Over and above the barrier issue, the general problem of "OS doesn't 
>know precisely what's on the platter" leads to a nasty edge case:
>
>If an error occurs where the typical resolution is a bus or device 
>reset, cached writes that have been acknowledged to the OS but not yet 
>hit the media will likely be lost.  This seems to be worse in SATA, 
>where you have a new class of errors (SATA link up/down, etc.) that is 
>also typically dealt with via reset.
>
>	Jeff

This shouldn't be the case.

We'll always complete writes we've given good status for prior to
saying "ok" on an incoming reset.  Hard or soft, all resets wait on a
clean internal cache before we process the reset itself.

--eric


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

