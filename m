Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266210AbTIKH1G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 03:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266211AbTIKH1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 03:27:06 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:6017 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S266210AbTIKH1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 03:27:04 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Local DoS on single_open? 
In-reply-to: Your message of "Thu, 11 Sep 2003 05:55:07 +0100."
             <20030911045507.GQ454@parcelfarce.linux.theplanet.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Sep 2003 17:26:54 +1000
Message-ID: <5311.1063265214@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003 05:55:07 +0100, 
viro@parcelfarce.linux.theplanet.co.uk wrote:
>On Thu, Sep 11, 2003 at 02:42:13PM +1000, Keith Owens wrote:
>> single_open() requires the kernel to kmalloc a buffer which lives until
>> the userspace caller closes the file.  What prevents a malicious user
>> opening the same /proc entry multiple times, allocating lots of kmalloc
>> space and causing a local DoS?
>
>Size of that buffer is limited.  IOW, it's not different from opening
>e.g. a shitload of pipes or sockets.

In some cases, the buffer size is set to hold _all_ of the output for
that particular /proc file and will be much larger than the data
reserved for files and sockets.  It is a difference in scale.

fs/proc/proc_misc.c		stat_open
fs/proc/proc_misc.c		interrupts_open
kernel/dma.c			proc_dma_open

All those functions will kmalloc a reasonably sized buffer then let the
user control the lifetime of that buffer.  Looks like a recipe for a
local DoS to me.

