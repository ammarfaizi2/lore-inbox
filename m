Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265650AbUFCQiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265650AbUFCQiU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 12:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265651AbUFCQiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 12:38:20 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:7261 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265650AbUFCQiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 12:38:16 -0400
Date: Thu, 3 Jun 2004 09:38:07 -0700
From: Paul Jackson <pj@sgi.com>
To: Greg KH <greg@kroah.com>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ak@suse.de
Subject: Re: [PATCH] fix sys cpumap for > 352 NR_CPUS
Message-Id: <20040603093807.33bc670d.pj@sgi.com>
In-Reply-To: <20040603162712.GA3291@kroah.com>
References: <20040602161115.1340f698.pj@sgi.com>
	<1086222156.29391.337.camel@bach>
	<20040603162712.GA3291@kroah.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We do check for an error in that function, so returning any negative
> error value for a show() sysfs callback will be handled properly.

If a show() function returns an error, you handle it - good.  As it
should be.

But if a show() function overwrites the page buffer provided to it,
before returning, then there is nothing you can do beyond sending
condolences to the next of kin.

This PATCH and email thread came about because the buffer size is not
passed into the show() function, nor, so far as I can tell, is it
documented anywhere other than implicitly in the fill_read_buffer()
code:

    buffer->page = (char *) get_zeroed_page(GFP_KERNEL);

So we were getting confused as to what size buffer we had, when
coding defensively to avoid buffer overrun.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
