Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWDSQYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWDSQYr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWDSQYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:24:47 -0400
Received: from stinky.trash.net ([213.144.137.162]:56753 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1750929AbWDSQYq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:24:46 -0400
Message-ID: <444663A9.9020502@trash.net>
Date: Wed, 19 Apr 2006 18:22:01 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James.Smart@Emulex.Com
CC: linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Netlink and user-space buffer pointers
References: <1145306661.4151.0.camel@localhost.localdomain> <20060418160121.GA2707@us.ibm.com> <444633B5.5030208@emulex.com>
In-Reply-To: <444633B5.5030208@emulex.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Smart wrote:
> To take netlink to where we want to use it within the SCSI subsystem (as
> the mechanism of choice to replace ioctls), we're going to need to pass
> user-space buffer pointers.
> 
> What is the best, portable manner to pass a pointer between user and kernel
> space within a netlink message ?  The example I've seen is in the iscsi
> target code - and it's passed between user-kernel space as a u64, then
> typecast to a void *, and later within the bio_map_xxx functions, as an
> unsigned long. I assume we are going to continue with this method ?

This might be problematic, since there is a shared receive-queue in
the kernel netlink message might get processed in the context of
a different process. I didn't find any spots where ISCSI passes
pointers over netlink, can you point me to it?

Besides that, netlink protocols should use fixed size architecture
independant types, so u64 would be the best choice for pointers.
