Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290708AbSBGRoF>; Thu, 7 Feb 2002 12:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290738AbSBGRnz>; Thu, 7 Feb 2002 12:43:55 -0500
Received: from air-2.osdl.org ([65.201.151.6]:22451 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S290708AbSBGRno>;
	Thu, 7 Feb 2002 12:43:44 -0500
Date: Thu, 7 Feb 2002 09:43:53 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] read() from driverfs files can read more bytes 
In-Reply-To: <11240BA04440@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.33.0202070940450.25114-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Can you also check for size >= PAGE_SIZE on enter to entry->show()
> procedure? It looks ugly to me that each driver has to check for this
> constant unless it wants to smash some innocent kernel memory.

Done. Thanks.

> And neither of driverfs_read_file nor driverfs_write_file supports
> semantic we use with other filesystems: If at least one byte was 
> read/written, return byte count (even if error happens). Only if zero 
> bytes was written, return error code.

I would think that you would want to return the error code. Say you did:

echo "action parameter" > file

and 'parameter' is an invalid parameter, as determined by the driver. It 
would require another arbitrary check to determine if the command 
succeeded or not if it returned the number of bytes written. Returning 
-EINVAL lets userspace know that it made a boo-boo. Is that not good?

	-pat

