Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbTHYV7p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 17:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTHYV7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 17:59:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58837 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262284AbTHYV7o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 17:59:44 -0400
Message-ID: <3F4A86B8.9080404@pobox.com>
Date: Mon, 25 Aug 2003 17:59:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: insecure@mail.od.ua
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] raceless request_region() fix (was Re: Linux 2.6.0-test4)
References: <Pine.LNX.4.44.0308221732170.4677-100000@home.osdl.org> <200308260020.21817.insecure@mail.od.ua> <200308260026.47994.insecure@mail.od.ua>
In-Reply-To: <200308260026.47994.insecure@mail.od.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it a race if noone cares?  :)

The code does

	if (!request_region(...))
		fail
	touch hardware
	release_region
	if (!request_region(...))
		fail

If the HIGHLY UNLIKELY event of another ISA driver claiming this region 
occurs, the system continues working just fine.

At the time, I was thinking that any further touching of the code should 
be converting it to a more pnp-like structure.

	Jeff



