Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264748AbUFLMqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264748AbUFLMqz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 08:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264750AbUFLMqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 08:46:55 -0400
Received: from hellhawk.shadowen.org ([212.13.208.175]:7178 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S264748AbUFLMpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 08:45:52 -0400
Date: Sat, 12 Jun 2004 13:45:08 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>
cc: dhowells@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permit inode & dentry hash tables to be allocated > MAX_ORDER size
Message-ID: <4F2B7A16061839F525FD5279@[192.168.0.7]>
In-Reply-To: <20040611163051.6e7985bb.akpm@osdl.org>
References: <20040611034809.41dc9205.akpm@osdl.org>	<567.1086950642@redhat.com>	<1056.1086952350@redhat.com>	<20040611150419.11281555.akpm@osdl.org>	<3066250000.1086995005@flay>	<20040611161920.0a40e49d.akpm@osdl.org>	<3067490000.1086995928@flay> <20040611163051.6e7985bb.akpm@osdl.org>
X-Mailer: Mulberry/3.1.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On 11 June 2004 16:30 -0700 Andrew Morton <akpm@osdl.org> wrote:

> Doesn't look that way.  It uses
>
> 	(zone->zone_mem_map - page) >> (1 + order)

Hmmm, yes.  Does this not mean that we will violate the object size N will be aligned at size N.  Presumably that's why the error says 'it'll crash'.  If we are two pages offset we will allocate 4 page objects 2 page aligned.  I'll have a closer look and see if we can just 'round down' the zone_mem_map pointer here to give the correct alignment.  As long as we don't try and free them into the allocator originally we should be ok, as they are marked allocated in the bitmaps at the start.

-apw
