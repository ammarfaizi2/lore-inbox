Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbUCUQpd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 11:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263677AbUCUQpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 11:45:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31382 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263676AbUCUQpZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 11:45:25 -0500
Message-ID: <405DC698.4040802@pobox.com>
Date: Sun, 21 Mar 2004 11:45:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linguist@masterlinkcorp.com
CC: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix tiocgdev 32/64bit emul
References: <20040321062435.GA27226@goblin.masterlinkcorp.com>
In-Reply-To: <20040321062435.GA27226@goblin.masterlinkcorp.com>
Content-Type: multipart/mixed;
 boundary="------------040506080304070304000403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040506080304070304000403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

linguist@masterlinkcorp.com wrote:
> This is just a random observation, I don't know this piece of code
> or the kernel in general, but instinct tells me that where is says
> "if (!fd) return -EBADF", it should say "if (!file) return -EBADF".
> Just a heads up.
> 
> Regards,
> Rich
> 
> static int tiocgdev(unsigned fd, unsigned cmd,  unsigned int *ptr) 
> { 
> 
> 	struct file *file = fget(fd);
> 	struct tty_struct *real_tty;
> 
> 	if (!fd)
> 		return -EBADF;

Yup, looks like a real bug to me...  good catch.

Untested but obvious patch attached.

	Jeff



--------------040506080304070304000403
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== arch/x86_64/ia32/ia32_ioctl.c 1.38 vs edited =====
--- 1.38/arch/x86_64/ia32/ia32_ioctl.c	Wed Feb 25 11:06:01 2004
+++ edited/arch/x86_64/ia32/ia32_ioctl.c	Sun Mar 21 11:43:56 2004
@@ -27,7 +27,7 @@
 	struct file *file = fget(fd);
 	struct tty_struct *real_tty;
 
-	if (!fd)
+	if (!file)
 		return -EBADF;
 	if (file->f_op->ioctl != tty_ioctl)
 		return -EINVAL; 

--------------040506080304070304000403--

