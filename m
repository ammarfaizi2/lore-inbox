Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVACWmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVACWmO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVACWjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:39:18 -0500
Received: from terminus.zytor.com ([209.128.68.124]:19102 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261929AbVACWZo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:25:44 -0500
Message-ID: <41D9C635.1090703@zytor.com>
Date: Mon, 03 Jan 2005 14:24:53 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sfrench@samba.org, linux-ntfs-dev@lists.sourceforge.net,
       samba-technical@lists.samba.org, aia21@cantab.net,
       hirofumi@mail.parknet.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: FAT, NTFS, CIFS and DOS attributes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I recently posted to LKML a patch to get or set DOS attribute flags for 
fatfs.  That patch used ioctl().  It was suggested that a better way 
would be using xattrs, although the xattr mechanism seems clumsy to me, 
and has namespace issues.

I also think it would be good to have a unified interface for FAT, NTFS 
and CIFS for these attributes.

I noticed that CIFS has a placeholder "user.DosAttrib" in cifs/xattr.c, 
although it doesn't seem to be implemented.

Questions:

a) is xattr the right thing?  It seems to be a fairly complex and 
ill-thought-out mechanism all along, especially the whole namespace 
business (what is a system attribute to one filesystem is a user 
attribute to another, for example.)

b) if xattr is the right thing, shouldn't this be in the system 
namespace rather than the user namespace?

c) What should the representation be?  Binary byte?  String containing a 
subset of "rhsvda67" (barf)?

	-hpa
