Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbUKVHaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbUKVHaD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 02:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbUKVH3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 02:29:14 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:38923 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261967AbUKVH2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 02:28:38 -0500
Message-ID: <41A196BA.700@hist.no>
Date: Mon, 22 Nov 2004 08:35:22 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jagadeesh Bhaskar P <jbhaskar@hclinsys.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: on the concept of COW
References: <1100947100.4038.41.camel@myLinux>
In-Reply-To: <1100947100.4038.41.camel@myLinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jagadeesh Bhaskar P wrote:

>Hi,
>
> When a process forks, every resource of the parent, including the
>virtual memory is copied to the child process. The copying of VM uses
>copy-on-write(COW). I know that COW comes when a write request comes,
>and then the copy is made. Now my query follows:
>
>How will the copy be distributed. Whether giving the child process a new
>copy of VM be permanent or whether they will be merged anywhere? And
>  
>
Merging can only happen if the two pages becomes equal
again.  That is extremely unlikely, and checking for this
would cost a lot more than the memory saved.

>shouldn't the operations/updations by one process be visible to the
>other which inherited the copy of the same VM?
>  
>
Of course not - the whole reason for copying is so such
modifications won't be visible for the other process. 

There may be special cases (shared mapping) where one
process is supposed to see updates done by another - but
then no COW is performed because there is no need.

Helge Hafting
