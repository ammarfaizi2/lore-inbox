Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbULBOFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbULBOFj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 09:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbULBOFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 09:05:39 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:51369 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261626AbULBOFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 09:05:32 -0500
Subject: Re: Block layer question - indicating EOF on block devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041202081828.GC10454@suse.de>
References: <1101829852.25628.47.camel@localhost.localdomain>
	 <20041130184345.47e80323.akpm@osdl.org>
	 <1101912876.30770.14.camel@localhost.localdomain>
	 <20041202081828.GC10454@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101992502.5624.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Dec 2004 13:01:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-02 at 08:18, Jens Axboe wrote:
> The upper buffer layer could do something intelligent if EOF is set on
> the bio, it really should. The problem is that there's no -EXXX to flag
> EOF from the driver, it would be nicest if one could just do:
> 
> 	end_that_request_chunk(req, 1, good_bytes);
> 	end_that_request_chunk(req, -EOF, residual);
> 

We have a set of internal error codes around -512 for things like
"please use
the default ioctl behaviour". The error codes don't seem to get
propogated up through the page cache however when I tried using this (I
just "borrowed"
-ENOMEDIUM for testing) with the idea of catching it at the top.


