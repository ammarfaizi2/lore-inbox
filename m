Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbUL3R42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbUL3R42 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 12:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUL3R42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 12:56:28 -0500
Received: from [61.49.235.157] ([61.49.235.157]:52211 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261683AbUL3R4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 12:56:17 -0500
Date: Thu, 30 Dec 2004 09:45:31 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200412301745.iBUHjVu19959@adam.yggdrasil.com>
To: maneesh@in.ibm.com
Subject: Re: [Patch?] Teach sysfs_get_name not to use a dentry
Cc: akpm@osdl.org, chrisw@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2004 19:05:41 +0530, Maneesh Soni wrote:
>On Wed, Dec 01, 2004 at 10:41:08PM -0800, Adam J. Richter wrote:
>> Hi Maneesh,
>> 
>> 	The following patch changes syfs_getname to avoid using
>> sysfs_dirent->s_dentry for getting the names of directories (as
>> this pointer may be NULL in a future version where sysfs would
>> be able to release the inode and dentry for each sysfs directory).
>> It does so by defining different sysfs_dirent.s_type values depending
>> on whether the diretory represents a kobject or an attribute_group.
>> 
>> 	This patch is ground work for unpinning the struct inode
>> and struct dentry used by each sysfs directory.  The patch also may
>> facilitate eliminating the sysfs_dentry for each member of an
>> attribute group.  The patch has no benefits by itself, but I'm posting
>> it now separately in the hopes of making it easier for people
>> to spot problems, and, also, because if it is integrated, I think
>> it will make the rest of the change to unpin directories (which
>> I have not yet written) easier to understand.
>> 
>> 	This patch is against 2.6.10-rc2-bk13 with both Chris Wright's
>> patch to allocate sysfs_dirent's from a kmem_cache and my patch
>> for removing sysfs_dirent.s_count already applied (in other words,
>> bk13 with two patches --> bk13 with three patches).
>> 
>> 	I have verified that "find /sys" produces the same output
>> before and after applying this patch, and I have also been successfully
>> runing the tests that you previously suggested (loading and unloading
>> the dummy network device modules with running "ls -lR" on /sys and
>> cat'ing the files in /sys/class/net, all in a repeating loop).
>> 
>> 	Please let me know what you think.  If you could get this
>> patch integrated and forwarded downstream, that would be great, and
>> would be a step toward encouraging small incremental patches if you
>> prefer those when feasible, but it can also wait for the patch to
>> unpin sysfs directories that is your preference.


>Lots of changes, which donot make sense if we don't do unpinning 
>of directories. Lets see this if unpinning of directories can be
>done. Better to post with a patchset containing unpinning directory
>code. 

	Thanks for looking at my patches.

	I did post the patch unpinning sysfs directories, two and
a half weeks ago (the second URL is for a header file that I left out):

	http://marc.theaimsgroup.com/?l=linux-kernel&m=110257739705683&w=2
	http://marc.theaimsgroup.com/?l=linux-kernel&m=110257894222719&w=2

	The patches work fine for me.  I have been running with
all of these patches applied on every kernel that I've run up to
now (2.6.10-bk2) with zero problems.  I am not a heavy sysfs user,
but I have tried running your tests (loading and unloading the
dummy network module while reading the sysfs files that it creates),
including right now on 2.6.10-bk2.

	I am keen to know what you think of the patch unpinning
sysfs directories.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
