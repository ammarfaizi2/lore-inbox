Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbUC1UMg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 15:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUC1UMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 15:12:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51935 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262429AbUC1UMc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 15:12:32 -0500
Message-ID: <406731A2.90205@pobox.com>
Date: Sun, 28 Mar 2004 15:12:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Jamie Lokier <jamie@shareable.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <4066191E.4040702@yahoo.com.au> <40662108.40705@pobox.com> <20040328135124.GA32597@mail.shareable.org> <40670A36.3000005@pobox.com> <20040328174013.GJ24370@suse.de> <4067101F.9030606@pobox.com> <20040328175559.GM24370@suse.de> <406713A8.6040206@pobox.com> <20040328180914.GN24370@suse.de>
In-Reply-To: <20040328180914.GN24370@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sun, Mar 28 2004, Jeff Garzik wrote:
>>I bet if we can come up with a decent proposal, with technical rationale 
>>for the change... that could be presented to the right ATA people :) 
>>It's worth a shot.

> Count me in for that. The ATA people seem to have a preference for

Cool.


> adding a new set of commands for this type of there, where as I
> (originally, I did actually send in a proposal like this on the ml)
> wanted to just use one of the reserved bits in the tag field.

Well, I would like to present the problem, in the proposal, in a 
completely separate area of the document than the suggested solution.

Over and above the barrier issue, the general problem of "OS doesn't 
know precisely what's on the platter" leads to a nasty edge case:

If an error occurs where the typical resolution is a bus or device 
reset, cached writes that have been acknowledged to the OS but not yet 
hit the media will likely be lost.  This seems to be worse in SATA, 
where you have a new class of errors (SATA link up/down, etc.) that is 
also typically dealt with via reset.

	Jeff



