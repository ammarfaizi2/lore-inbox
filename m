Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266448AbRHaP3C>; Fri, 31 Aug 2001 11:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266688AbRHaP2m>; Fri, 31 Aug 2001 11:28:42 -0400
Received: from fire.osdlab.org ([65.201.151.4]:5773 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S266448AbRHaP2a>;
	Fri, 31 Aug 2001 11:28:30 -0400
Message-ID: <3B8FABA7.D06F4ACF@osdlab.org>
Date: Fri, 31 Aug 2001 08:22:15 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adam McKenna <adam-dated-999656018.ee55e0@flounder.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange kernel messages
In-Reply-To: <20010830191338.D19430@flounder.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam McKenna wrote:
> 
> Can someone please explain what these error messages mean?
> 
> Aug 30 12:23:17 ren kernel: expected (0x3af6c03f/0x24d6e80), got
> (0x3af6c03f/0x24d4ba0)
> Aug 30 12:23:17 ren kernel: expected (0x3af6c03f/0x24d4ba0), got
> (0x3af6c03f/0x24d6e80)
> Aug 30 12:35:02 ren kernel: expected (0x3af6c03f/0x24d6e80), got
> (0x3af6c03f/0x24d4ba0)
> Aug 30 12:35:02 ren kernel: expected (0x3af6c03f/0x24d4ba0), got
> (0x3af6c03f/0x24d6e80)
> Aug 30 13:49:36 ren kernel: expected (0x3af6c03f/0x2c05e81), got
> (0x3af6c03f/0x2c05ea0)
> Aug 30 13:49:36 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
> (0x3af6c03f/0x2c05e81)
> Aug 30 13:54:38 ren kernel: expected (0x3af6c03f/0x2c05e81), got
> (0x3af6c03f/0x2c05ea0)
> Aug 30 13:54:38 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
> (0x3af6c03f/0x2c05e81)
> Aug 30 13:59:40 ren kernel: expected (0x3af6c03f/0x2c05e81), got
> (0x3af6c03f/0x2c05ea0)
> Aug 30 13:59:40 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
> (0x3af6c03f/0x2c05e81)
> Aug 30 14:04:41 ren kernel: expected (0x3af6c03f/0x2c05e81), got
> (0x3af6c03f/0x2c05ea0)
> Aug 30 14:04:41 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
> (0x3af6c03f/0x2c05e81)
> Aug 30 14:09:43 ren kernel: expected (0x3af6c03f/0x2c05e81), got
> (0x3af6c03f/0x2c05ea0)
> Aug 30 14:09:43 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
> (0x3af6c03f/0x2c05e81)
> Aug 30 14:10:19 ren kernel: expected (0x3af6c03f/0x2c05e81), got
> (0x3af6c03f/0x2c05ea0)
> Aug 30 14:10:19 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
> (0x3af6c03f/0x2c05e81)
> Aug 30 14:15:17 ren kernel: expected (0x3af6c03f/0x2c05e81), got
> (0x3af6c03f/0x2c05ea0)
> Aug 30 14:15:17 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
> (0x3af6c03f/0x2c05e81)
> Aug 30 14:20:19 ren kernel: expected (0x3af6c03f/0x2c05e81), got
> (0x3af6c03f/0x2c05ea0)
> Aug 30 14:20:19 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
> (0x3af6c03f/0x2c05e81)
> Aug 30 14:25:21 ren kernel: expected (0x3af6c03f/0x2c05e81), got
> (0x3af6c03f/0x2c05ea0)
> Aug 30 14:25:21 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
> (0x3af6c03f/0x2c05e81)
> Aug 30 14:30:23 ren kernel: expected (0x3af6c03f/0x2c05e81), got
> (0x3af6c03f/0x2c05ea0)
> Aug 30 14:30:23 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
> (0x3af6c03f/0x2c05e81)
> Aug 30 14:35:27 ren kernel: expected (0x3af6c03f/0x2c05e81), got
> (0x3af6c03f/0x2c05ea0)
> Aug 30 14:35:27 ren kernel: expected (0x3af6c03f/0x2c05ea0), got
> (0x3af6c03f/0x2c05e81)
> 
> This is on stock Linux 2.4.5, SMP enabled.

Couple of observations:

a.  Not knowing this message, I grepped thru the kernel source tree
and found it easily (hint).  It comes from linux/fs/nfs/inode.c,
when the NFS inode is being updated but doesn't match what is
expected (it seems, from reading the code and comments).

b.  Some kernel message context would usually be helpful.
This message should have been preceded by the message:
  nfs_refresh_inode: inode number mismatch

I expect that some FS/NFS people can give you even better info.

~Randy
