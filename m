Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263674AbUDUUOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263674AbUDUUOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 16:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263676AbUDUUOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 16:14:40 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:18443 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263674AbUDUUOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 16:14:39 -0400
Date: Wed, 21 Apr 2004 21:14:38 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Jason Cox <steel300@gentoo.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Change number of tty devices
In-Reply-To: <E1BFhPh-00027s-IL@smtp.gentoo.org>
Message-ID: <Pine.LNX.4.44.0404212109580.10680-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Often, I have wondered what the need for 64 tty devices in /dev is. I began 
> tinkering with the code and am wondering why it's not user configurable. 
> I came up with a quick patch to add it as an option under 
> drivers/char/Kconfig. I also made a lower bound of 12. If this is an 
> idea worth pursuing, please let me know. If this idea has been rejected 
> before, I apologize. What do you think of this idea?

The reason for 64 is that the major number is shared between the serial 
tty and VT tty drivers. The first 64 to Vts and the rest to serial 
devices. What is even more is that athere exist ioctls that return shorts 
which means only 16 VCs can be accounted for on a VT. When the kernel 
supports multi-desktop systems we will have to deal with the serial and VT 
issue. Most likely the serial tty drivers will be given a different major 
number. I personally believe that because of the 16 bit limit that there
should be 16 VCs per VT terminal. 


