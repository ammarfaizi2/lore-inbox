Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbULBOId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbULBOId (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 09:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbULBOIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 09:08:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14288 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261629AbULBOIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 09:08:10 -0500
Date: Thu, 2 Dec 2004 15:07:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Block layer question - indicating EOF on block devices
Message-ID: <20041202140730.GH10458@suse.de>
References: <1101829852.25628.47.camel@localhost.localdomain> <20041130184345.47e80323.akpm@osdl.org> <1101912876.30770.14.camel@localhost.localdomain> <20041202081828.GC10454@suse.de> <1101992502.5624.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101992502.5624.8.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02 2004, Alan Cox wrote:
> On Iau, 2004-12-02 at 08:18, Jens Axboe wrote:
> > The upper buffer layer could do something intelligent if EOF is set on
> > the bio, it really should. The problem is that there's no -EXXX to flag
> > EOF from the driver, it would be nicest if one could just do:
> > 
> > 	end_that_request_chunk(req, 1, good_bytes);
> > 	end_that_request_chunk(req, -EOF, residual);
> > 
> 
> We have a set of internal error codes around -512 for things like
> "please use
> the default ioctl behaviour". The error codes don't seem to get
> propogated up through the page cache however when I tried using this (I
> just "borrowed"
> -ENOMEDIUM for testing) with the idea of catching it at the top.

It gets passed to the bio->bi_end_io end io handler, but most likely
that doesn't do anything with it (most just treat it as a bool). That's
where the improvement room is, basically :)

-- 
Jens Axboe

