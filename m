Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUHNCm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUHNCm3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 22:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbUHNCm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 22:42:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22762 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265800AbUHNCm1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 22:42:27 -0400
Message-ID: <411D7C02.80402@pobox.com>
Date: Fri, 13 Aug 2004 22:42:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.8-rc4-bk] NFS oops on x86-64
References: <411D65B4.4030208@pobox.com>	 <1092447909.4078.18.camel@lade.trondhjem.org>	 <1092450076.4078.34.camel@lade.trondhjem.org> <1092450265.4078.37.camel@lade.trondhjem.org>
In-Reply-To: <1092450265.4078.37.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> På fr , 13/08/2004 klokka 22:21, skreiv Trond Myklebust:
> 
> 
>>--- linux-2.6.8-rc4/fs/nfs/file.c.orig	2004-08-13 14:21:25.000000000 -0400
>>+++ linux-2.6.8-rc4/fs/nfs/file.c	2004-08-13 21:50:28.000000000 -0400
>>@@ -72,7 +72,7 @@ struct inode_operations nfs_file_inode_o
>> 
>> static int nfs_check_flags(int flags)
>> {
>>-	if (flags & (O_APPEND | O_DIRECT))
>>+	if (flags & (O_APPEND | O_DIRECT) == (O_APPEND | O_DIRECT))
>> 		return -EINVAL;
> 
> Argh... I'm making mistakes too now...
> 
> Should be
> 
> 	if ((flags & (O_APPEND | O_DIRECT)) == (O_APPEND | O_DIRECT))


I'll check this out in a bit.

Update:  looks like NFS is dead on 32-bit x86 as well.  Same symptoms 
and same fix.

	Jeff


