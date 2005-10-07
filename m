Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbVJGKBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVJGKBu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 06:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVJGKBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 06:01:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26921 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932117AbVJGKBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 06:01:50 -0400
Date: Fri, 7 Oct 2005 12:02:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Jon Escombe <lists@dresco.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [RFC] Hard disk protection revisited
Message-ID: <20051007100219.GU2889@suse.de>
References: <4345B24A.2080104@dresco.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4345B24A.2080104@dresco.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07 2005, Jon Escombe wrote:
> I would like to submit the latest disk protection (a.k.a. parking and 
> freezing) code from the hdaps-devel side for comment, along with a brief 
> overview of what's in the patch -
> 
> During initialisation, disk drivers with 'protect' helper functions 
> (currently ide and libata) fill in two new function pointers in the 
> queue structure. A sysfs 'protect' queue attribute is then created in 
> the block layer for devices who's lower level drivers have registered 
> these helpers.
> 
> When a value (in seconds) is written to the protect attribute, the block 
> layer code calls the driver 'protect' helper function. This helper 
> parks/suspends the disk, and then stops the queue. Control then returns 
> to the block layer which re-uses the plugging timer to set an automatic 
> timeout to restart the queue. When 0 is written to the protect 
> attribute, or the timer expires, the queue is restarted using the 
> 'unprotect' helper function, and the plugging timer is restored.
> 
> This interface is intended to be used by a daemon process, that monitors 
> the hdaps driver output for excessive changes in acceleration, and keeps 
> the device parked and the queue stopped until the values become normal.
> 
> Patch applies to 2.6.14-rc3 (also 2.6.13.x), and requires libata_passthru..

I have to nack this one for now, I still want the generic command types
patch to go in first. We have far too many queue hooks already, adding
two more for a relatively obscure use such as this one is not a good
idea.

My suggestion is to maintain this patch out of tree for now, it will be
a few kernel release iterations before the command type patch is in.

-- 
Jens Axboe

