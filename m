Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbULCLO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbULCLO5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 06:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbULCLO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 06:14:57 -0500
Received: from [61.149.23.123] ([61.149.23.123]:7145 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S262154AbULCLO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 06:14:56 -0500
Date: Fri, 3 Dec 2004 03:05:20 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200412031105.iB3B5Kd05959@adam.yggdrasil.com>
To: chrisw@osdl.org
Subject: Re: [PATCH 2.6.10-rc2-bk15] sysfs_dir_close memory leak
Cc: akpm@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com, viro@parcelfarce.linux.theplanet.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
>* Adam J. Richter (adam@yggdrasil.com) wrote:
>> 	sysfs_dir_close did not free the "cursor" sysfs_dirent
>> used for keeping track of position in the list of sysfs_dirent nodes.
>> Consequently, doing a "find /sys" would leak a sysfs_dirent for
>> each of the 1140 directories in my /sys tree, or about 36kB
>> each time.

>Yeah, I noticed this as well.  Why the BUGON()?

	My thinking was that the preconditions in my tree for
calling release_sysfs_dirent are dirent->s_dentry == NULL and
list_empty(&dirent->s_sibling).  The latter should be apparent
from two lines above, but the former is less obvious, although
it is also theoretically always true.

	I'm OK with deleting the BUG_ON().  It was not verifying
anything passed in by an outside caller.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
