Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVJGMLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVJGMLN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 08:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVJGMLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 08:11:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34113 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932115AbVJGMLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 08:11:12 -0400
Date: Fri, 7 Oct 2005 14:11:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Jon Escombe <lists@dresco.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [RFC] Hard disk protection revisited
Message-ID: <20051007121142.GV2889@suse.de>
References: <4345B24A.2080104@dresco.co.uk> <20051007100219.GU2889@suse.de> <43466453.9070604@dresco.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43466453.9070604@dresco.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07 2005, Jon Escombe wrote:
> Jens Axboe wrote:
> 
> >I have to nack this one for now, I still want the generic command types
> >patch to go in first. We have far too many queue hooks already, adding
> >two more for a relatively obscure use such as this one is not a good
> >idea.
> >
> >My suggestion is to maintain this patch out of tree for now, it will be
> >a few kernel release iterations before the command type patch is in.
> > 
> >
> 
> That's a fair comment (and not entirely unexpected), I don't have a 
> problem with looking after this out of tree for now...
> 
> One issue with the generic command approach occured to me while making 
> this patch - although it's more likely an issue with my understanding ;)
> 
> I'm assuming that it would work like this -- the block layer still has 
> the sysfs attribute, and queues the new command for the lower driver to 
> pick up. The driver receives the command and does it's custom 
> park/freeze work, then calls a common block layer function to setup the 
> timer (all good so far). Where it gets hazy (for me) is how the block 
> layer starts the queue up again - as this ended up needing to be driver 
> specific & I can't see how the block layer would get another command 
> down if the queue is stopped?

It just sends an unfreeze request. It's similar to how we have to allow
suspend commands on an otherwise suspended queue. Since the block layer
has control of the frozen queue, it should not be a problem.

-- 
Jens Axboe

