Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbTEFUwO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 16:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTEFUwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 16:52:14 -0400
Received: from [12.47.58.20] ([12.47.58.20]:47720 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261886AbTEFUwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 16:52:12 -0400
Date: Tue, 6 May 2003 14:01:04 -0700
From: Andrew Morton <akpm@digeo.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: viro@parcelfarce.linux.theplanet.co.uk, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, jaharkes@cs.cmu.edu,
       linux-security-module@wirex.com
Subject: Re: [PATCH] Process Attribute API for Security Modules 2.5.69
Message-Id: <20030506140104.78dda82f.akpm@digeo.com>
In-Reply-To: <1052237601.1377.991.camel@moss-huskers.epoch.ncsc.mil>
References: <1052237601.1377.991.camel@moss-huskers.epoch.ncsc.mil>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2003 21:04:38.0874 (UTC) FILETIME=[1B2353A0:01C31413]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@epoch.ncsc.mil> wrote:
>
> This patch against 2.5.69 implements a process attribute API for
> security modules via a set of nodes in a /proc/pid/attr directory.

Just a few triviata:

> +static int proc_attr_readdir(struct file * filp,

Can all this be inside CONFIG_SOMETHING?  It's quite a lot of code.

> +	switch (i) {
> +		case 0:

We often line the `case' up with the `switch' to save a tabstop.

> +			if (i>=sizeof(attr_stuff)/sizeof(attr_stuff[0])) {

The ARRAY_SIZE macro does this.

> +static ssize_t proc_pid_attr_read(struct file * file, char * buf,
> +				  size_t count, loff_t *ppos)
> +{
> ...
> +	copy_to_user(buf, (char *) page + *ppos, count);

Need to check the return value here, return a short read if something was
copied, else -EFAULT.  Or just EFAULT.


