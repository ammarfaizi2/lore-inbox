Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVCWLhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVCWLhD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 06:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVCWLhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 06:37:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:46550 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261379AbVCWLg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 06:36:59 -0500
Date: Wed, 23 Mar 2005 03:36:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: "shafa.hidee" <shafa.hidee@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Redirecting output
Message-Id: <20050323033631.0f7ad778.akpm@osdl.org>
In-Reply-To: <001e01c52f74$2f27daa0$6a88cb0a@hss.hns.com>
References: <001e01c52f74$2f27daa0$6a88cb0a@hss.hns.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"shafa.hidee" <shafa.hidee@gmail.com> wrote:
>
>      I have created a dummy module for learning device driver in linux. I
>  want to redirect the standard output of printk to my xterm. But by default
>  it is redirected to tty.
> 
>  I have remote logged into the machine.

You can do this from within the module_init() handler only:

module_init_handler(...)
{
	mm_segment_t old_fs;

	....
	old_fs = set_fs(KERNEL_DS);
	sys_write(1, "foo\n", 4);
	set_fs(old_fs);
	...
}

The text comes out on modprobe's standard output.

Don't tell anyone I told you this.

