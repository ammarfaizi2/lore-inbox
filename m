Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbUDPPzI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 11:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbUDPPzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 11:55:08 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:25607 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263340AbUDPPy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 11:54:59 -0400
Message-ID: <40800213.8010106@techsource.com>
Date: Fri, 16 Apr 2004 11:56:03 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb broken
References: <20040415202523.GA17316@codeblau.de>	<407EFB08.6050307@techsource.com> <20040415152507.3a0b014d.akpm@osdl.org>
In-Reply-To: <20040415152507.3a0b014d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton asked me to repost the patch for the Radeon FB off-by-one 
bug.  I'll see about making a proper patch when I get home, but if you 
want to fix it quicker, I'll just tell you what to change.


In the druvers/video/radeonfb.c, there is a function called 
fbcon_radeon_bmove.  In there, you'll see this code:

	if (srcy < dsty) {
                 srcy += height;
                 dsty += height;
         } else
                 dp_cntl |= DST_Y_TOP_TO_BOTTOM;

         if (srcx < dstx) {
                 srcx += width;
                 dstx += width;
         } else
                 dp_cntl |= DST_X_LEFT_TO_RIGHT;


Those adds need to be reduced by one.  The code should look like this:


	if (srcy < dsty) {
                 srcy += height - 1;
                 dsty += height - 1;
         } else
                 dp_cntl |= DST_Y_TOP_TO_BOTTOM;

         if (srcx < dstx) {
                 srcx += width - 1;
                 dstx += width - 1;
         } else
                 dp_cntl |= DST_X_LEFT_TO_RIGHT;



This bug is in the mainline kernel, and since I have direct experience 
programming for the Radeon, I knew how to fix it, but I also noticed 
that the Red Hat kernel "2.4.18-27.7.x" has the proper fix in it.


Whenever I download a new 2.4 kernel for gentoo, I have to manually make 
that fix.  I'm also disappointed that acceleration for Radeon has 
disappeared completely from 2.6.

