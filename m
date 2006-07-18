Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWGRJRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWGRJRw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWGRJRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:17:52 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:65256 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932097AbWGRJRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:17:51 -0400
Message-ID: <44BCA8CD.5070508@gentoo.org>
Date: Tue, 18 Jul 2006 10:24:29 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Thomas Dillig <tdillig@stanford.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Null dereference errors in the kernel
References: <44BC5A3F.2080005@stanford.edu>
In-Reply-To: <44BC5A3F.2080005@stanford.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Dillig wrote:
> Hello,
> 
> We are PhD students at Stanford University working on a static analysis 
> project called SATURN (http://glide.stanford.edu/saturn). We have 
> implemented a checker that finds potential null dereference errors and 
> ran our tool on the kernel version 2.6.17.1. We have identified around 
> 300 potential issues related to null errors, and we've included 20 
> sample reports below. If you would be interested, we can post all the 
> issues we found. Also, we apologize in advance if we aren't supposed to 
> post these error reports here, and we are happy to submit bug reports 
> elsewhere if you tell us where to post these.

Interesting idea. I just looked at one of them out of curiosity, but I'm 
not sure it is valid. Either that or I have misunderstood the problem it 
is identifying?

> [13]
> 1176, 1180 drivers/char/isicom.c
> Possible null dereference of variable "tty" checked for NULL at 
> (1183:drivers/char/isicom.c).

This function is part of the tty_operations API, that would be a pretty 
broken interface if it provided the possibility of a NULL tty to work 
on. Additionally, all of the callers seem to do this:

	tty->driver->put_char(tty, c);

If tty is NULL here, we have larger problems at hand :)

I'm also unsure how this null dereference is related to line 1183.

Daniel
