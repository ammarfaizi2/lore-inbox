Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbUCUGcW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 01:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263613AbUCUGcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 01:32:22 -0500
Received: from 216-199-40-2.orl.fdn.com ([216.199.40.2]:5272 "EHLO
	masterlinkcorp.com") by vger.kernel.org with ESMTP id S263612AbUCUGcV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 01:32:21 -0500
Date: Sun, 21 Mar 2004 01:24:35 -0500
From: linguist@masterlinkcorp.com
To: linux-kernel@vger.kernel.org
Message-ID: <20040321062435.GA27226@goblin.masterlinkcorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a random observation, I don't know this piece of code
or the kernel in general, but instinct tells me that where is says
"if (!fd) return -EBADF", it should say "if (!file) return -EBADF".
Just a heads up.

Regards,
Rich

static int tiocgdev(unsigned fd, unsigned cmd,  unsigned int *ptr) 
{ 

	struct file *file = fget(fd);
	struct tty_struct *real_tty;

	if (!fd)
		return -EBADF;
	if (file->f_op->ioctl != tty_ioctl)
		return -EINVAL; 
	real_tty = (struct tty_struct *)file->private_data;
	if (!real_tty) 	
		return -EINVAL; 
	return put_user(new_encode_dev(tty_devnum(real_tty)), ptr); 
} 
