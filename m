Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264241AbTKZQ5Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 11:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264253AbTKZQ5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 11:57:25 -0500
Received: from mail0.rawbw.com ([198.144.192.41]:40201 "EHLO mail0.rawbw.com")
	by vger.kernel.org with ESMTP id S264241AbTKZQ5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 11:57:22 -0500
Message-ID: <3FC4DB70.4090808@rawbw.com>
Date: Wed, 26 Nov 2003 08:57:20 -0800
From: John Newlin <jnewlin@rawbw.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Network device driver Question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a driver for a new device.  This NIC is on-chip, and 
memory mapped.
It can DMA to/from any memory location.

I am trying to optimize the driver such that it there is no need to copy 
to/from sk_buff
in the send_packet and on packet receive.

The problem I have is with a CPU that has a writeback cache.  When the 
send_packet
is called, the data in the sk_buff may be cached.  In the driver I can 
allocate a page as
uncached and copy to that page, however I am trying to avoid unneeded 
copies.

For receive there is a similar problem.  When I allocate the sk_buff I 
need to invalidate
the caches.  That way after a new packet arrives a read from that memory 
location will
not hit in the cache and return incorrect data.

Is there some sanctioned way that will work on any architecture to cause 
a writeback
of the dcached based on a range of virtual addresses, and similiarly 
cause an invalidate?

Thanks,

-John Newlin
 jnewlin@rawbw.com


