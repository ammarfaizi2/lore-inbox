Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263551AbUCTVzd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 16:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263552AbUCTVzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 16:55:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:12504 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263551AbUCTVz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 16:55:28 -0500
Date: Sat, 20 Mar 2004 13:55:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Michael W. Shaffer" <mwshaffer@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.4 Hang in utime() on swap file
Message-Id: <20040320135530.7f06a7b8.akpm@osdl.org>
In-Reply-To: <20040320181630.27185.qmail@web10401.mail.yahoo.com>
References: <20040320181630.27185.qmail@web10401.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael W. Shaffer" <mwshaffer@yahoo.com> wrote:
>
> I have a Debian Sarge system running a 2.6 kernel (tested with 2.6.2, 2.6.3,
> 2.6.4 with the same behavior as described here), and am seeing un-killable
> hanging processes with our particular backup product.
> 
> When the backup disk agent process is running, one the the last files it
> tries to back up is a swap file at the path /swapfile00. The read of the
> file appears to work fine, but then it wants to call utime() to reset the
> atime/mtime on the file, and at this point the process becomes infinitely
> hung, doing nothing, no more output from strace, never terminating.
> 
> This only occurs if the swapfile is actively in use when the backup runs. If
> I run swapoff to deactivate the swapfile, then the utime() call apparently
> completes and the process immediately finishes and exits normally. If the
> swapfile is not in use at all, everything works fine.
> 

ho hum.  We do this to prevent anyone from ftruncate()ing the swapfile
while it is in use.  That can destroy filesystems.  Let me think about it a
bit.
