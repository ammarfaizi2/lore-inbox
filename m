Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUFVJsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUFVJsV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 05:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbUFVJsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 05:48:21 -0400
Received: from web50007.mail.yahoo.com ([206.190.38.22]:16487 "HELO
	web50007.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261867AbUFVJsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 05:48:18 -0400
Message-ID: <20040622094818.45882.qmail@web50007.mail.yahoo.com>
Date: Tue, 22 Jun 2004 02:48:18 -0700 (PDT)
From: fc scsi <scsi_fc_group@yahoo.com>
Subject: kiobuf mapping with "mem=" boot option
To: linux-kernel@vger.kernel.org
Cc: scsi_fc_group@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have an application which uses a separate pool of
memory not managed by linux (reserved using "mem="
option at boot command line) and a memory manager
which manages this pool of memory in user space. The
algorithm works like this:

a. use "mem=xM" option to boot command line
b. mmap() the memory above "xM" till end of actual RAM
in user space application.
c. the mmaped region is managed by a user space memory
manager.

This works fine for the application.

1. Now we want to access a chunk of memory which we
allocated using the user level memory manager in
kernel space also. For this we tried kiobuf approach
on the memory which was allocated in user space. But
this approach doesn't seem to work on this mmaped
memory (map_user_kiobuf() gives EFAULT: Bad Address).
Is this valid behaviour? 

2. Also, will we be wrong in making the assumption
that the pages for memory above x Megs will never be
swapped out?

If the answer to question 1 above is, that memory
which is beyond x Megs (mem=xM) can not be used for
kiobuf mapping, then is it ok if we directly access
the user space address from kernel space (assuming the
answer to question 2 is yes).

Any information in this regard will be of great help.

Thanks in advance.



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
