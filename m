Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbUB0AgE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUB0AgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:36:03 -0500
Received: from pD9EF044B.dip.t-dialin.net ([217.239.4.75]:5619 "EHLO
	roesrv01.roemling.home") by vger.kernel.org with ESMTP
	id S261447AbUB0Afu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:35:50 -0500
Message-ID: <403E90DD.9060005@roemling.net>
Date: Fri, 27 Feb 2004 01:35:41 +0100
From: Jochen Roemling <jochen@roemling.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: en-us, en, de-de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Chris Wright <chrisw@osdl.org>
Subject: Re: shmget with SHM_HUGETLB flag: Operation not permitted
References: <1tDJX-4Ua-25@gated-at.bofh.it> <1tDJX-4Ua-27@gated-at.bofh.it> <1tDJX-4Ua-29@gated-at.bofh.it> <1tDTE-51P-23@gated-at.bofh.it> <1tDTE-51P-21@gated-at.bofh.it>
In-Reply-To: <1tDTE-51P-21@gated-at.bofh.it>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> did you try setpcaps?  smth like setpcaps cap_ipc_lock+e <pid>

Ok. One step further now. The syntax seems correct now. I tried to grant 
capabilities to the user's shell:

roesrv01~ # setpcaps cap_ipc_lock+e 2864
[caps set to:
= cap_ipc_lock+e
]
Failed to set cap's on process `2864': (Operation not permitted)

and with the setcap tool again:

roesrv01~ # setcap cap_ipc_lock+e a.out
Failed to set capabilities on file `a.out'
  (Function not implemented)

Hmmm. What do we do now?

>>Are you sure that this capability is my problem?
> 
> Yes, take a look at fs/hugetlbfs/inode.c::hugetlb_zero_setup()

Ok, this would explain it. But what role plays the pseudo-filesystem in 
this case? I don't have it mounted. Isn't it only needed when using 
mmap, not shmget? I guess, I have a serious lack of knownledge here.



