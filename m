Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVFPW4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVFPW4O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 18:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVFPW4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 18:56:11 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:57218 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261879AbVFPWyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 18:54:51 -0400
Message-ID: <42B20317.6000204@nortel.com>
Date: Thu, 16 Jun 2005 16:54:15 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Hugh Blemings <hab@au1.ibm.com>
Subject: Re: why does fsync() on a tmpfs directory give EINVAL?
References: <42B1DBF1.4020904@nortel.com> <20050616135708.4876c379.akpm@osdl.org>
In-Reply-To: <20050616135708.4876c379.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Chris Friesen <cfriesen@nortel.com> wrote:

>> Would a patch that makes it 
>>just return successfully without doing anything be accepted?
> 
> 
> yup.

Currently tmpfs reuses the simple_dir_operations from libfs.c.

Would it make sense to add the empty fsync() function there, and have 
all other users pick it up as well?  Is this likely to break stuff?

Currently the following code uses simple_dir_operations:

./kernel/cpuset.c
./security/selinux/selinuxfs.c
./ipc/mqueue.c
./include/linux/fs.h
./fs/relayfs/inode.c
./fs/debugfs/inode.c
./fs/ocfs2/dlm/dlmfs.c
./fs/autofs/inode.c
./fs/hugetlbfs/inode.c
./fs/libfs.c
./fs/ramfs/inode.c
./fs/devpts/inode.c
./net/sunrpc/rpc_pipe.c
./mm/shmem.c
./drivers/misc/ibmasm/ibmasmfs.c
./drivers/oprofile/oprofilefs.c
./drivers/isdn/capi/capifs.c
./drivers/usb/core/inode.c
./drivers/usb/gadget/inode.c

Chris

