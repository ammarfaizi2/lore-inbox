Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTE2X7h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 19:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbTE2X7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 19:59:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30378 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263205AbTE2X7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 19:59:34 -0400
Date: Thu, 29 May 2003 17:11:14 -0700 (PDT)
Message-Id: <20030529.171114.34756018.davem@redhat.com>
To: akpm@digeo.com
Cc: bonganilinux@mweb.co.za, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-mm1 Strangeness
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030529135541.7c926896.akpm@digeo.com>
References: <20030529221622.542a6df5.bonganilinux@mweb.co.za>
	<20030529135541.7c926896.akpm@digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Thu, 29 May 2003 13:55:41 -0700

   The ip_dst_cache seems unreasonably large.  Unless your desktop is a
   backbone router or something.

Lots of DST entries can result on any machine actually.  We create one
per source address, not just per destination address.  So if you talk
to a lot of sites, or lots of sites talk to you, you'll get a lot of
DST entries.

Regardless, 80MB _IS_ excessive.  That's nearly 400,000 entries.
It definitely indicates there is a leak somewhere.

Although it say:

ip_dst_cache       19470  19470   4096    1    1

Which is 19470 active objects right?

There is a known aparent issue with IPV6, there is some DST
leak there, but that is irrelevant here since we're clearly
talking about the ipv4 dst cache.
