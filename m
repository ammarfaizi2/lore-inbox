Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263219AbUE1Oe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbUE1Oe0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 10:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbUE1Oe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 10:34:26 -0400
Received: from cmlapp16.siteprotect.com ([64.41.126.229]:58284 "EHLO
	cmlapp16.siteprotect.com") by vger.kernel.org with ESMTP
	id S263219AbUE1OeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 10:34:25 -0400
Message-ID: <40B74DFF.9090402@serice.net>
Date: Fri, 28 May 2004 09:34:39 -0500
From: Paul Serice <paul@serice.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040127
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Help with Non-Unique Inodes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I've finished changing the inode scheme in the isofs code to
better support DVDs.  Pursuant to a comment in fs/inode.c, I switched
from iget() to iget5_locked() because a 32-bit inode number was unable
to uniquely identify all the possible inodes.

I want to make sure I understand what is expected of the ino_t value
returned to the user before I post the patch:

1) Does the ino_t returned to the user have to be unique? I ask
    because the inodes on the isofs are sparse, and a unique number
    could probably be generated for the benefit of the user.  I'm
    currently returning the same hash value I pass to iget5_locked().

2) In order to avoid recursion loops, I believe the "ls" and "find"
    commands assume inodes are unique for a particular device, and they
    refuse to recurse down different directories on the same device
    with the same inode number.  If the ino_t returned to the user does
    not have to be unique, how do I guarantee that these basic
    utilities are capable of fully recursing the file system?

