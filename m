Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262623AbVBCPgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbVBCPgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 10:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263342AbVBCPfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 10:35:51 -0500
Received: from alog0137.analogic.com ([208.224.220.152]:8576 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263086AbVBCPfN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 10:35:13 -0500
Date: Thu, 3 Feb 2005 10:35:22 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Pankaj Agarwal <pankaj@toughguy.net>
cc: linux-kernel@vger.kernel.org, Linux Net <linux-net@vger.kernel.org>
Subject: Re: Query - Regarding strange behaviour.
In-Reply-To: <001501c509ff$d4be02e0$8d00150a@dreammac>
Message-ID: <Pine.LNX.4.61.0502031017430.9404@chaos.analogic.com>
References: <001501c509ff$d4be02e0$8d00150a@dreammac>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Feb 2005, Pankaj Agarwal wrote:

> Hi,
>
> In my system there's a strange behaviour.... its not allowing me to create 
> any file in /usr/bin even as root. Its chmod is set to 755. Its even not 
> allowing me to change the chmod value of /usr/bin. The strangest part which i 
> felt is ...its shows the owner and group as root when i issue command "ls -ld 
> /usr/bin" and not allowing root to create any file or directory under 
> /usr/bin and not even allowing to change the chmod value. The error is access 
> permission denied... I can change the chmod value of /usr and other 
> directories under /usr/...but not of bin....
>
> I need your help/support. kindly let me know what all can i try to resolve 
> this problem.
>
> Thanks and Regards,
>
> Pankaj Agarwal

See if your file-system has gotten hurt. Boot with init=/bin/bash
and execute `/sbin/fsck -f /` to force a check of the root file-system.

The next check is to see if you can fix the protections when
you are the only one accessing the file-system:

# mount -n -o remount /	# re-mount root r/w
# cd /usr
# chmod 755 bin
# ls -la		# See if it worked
# unmount /

The next check is to replace the /usr/bin directory. Since `mv`
and `mkdir` are in /bin, the following should work.

# mount -n -o remount /  # re-mount root r/w
# cd /usr
# mv bin foo		# Rename 'strange' directory
# mkdir bin		# Make a new one
# cd foo		# Change to original
# mv * ../bin		# Rename all contents to new
# cd .. 
# rmdir foo		# Remove bad directory
# chmod 755 bin		# Fix protection
# umount /

After you have fixed things, you don't have to re-boot.
Just execute:

# exec /sbin/init auto


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
