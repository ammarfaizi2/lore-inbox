Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965889AbWKEVPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965889AbWKEVPH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 16:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965891AbWKEVPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 16:15:06 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:55770 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S965889AbWKEVPF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 16:15:05 -0500
Message-ID: <454E5437.1020909@in.ibm.com>
Date: Mon, 06 Nov 2006 02:44:31 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: menage@google.com
CC: sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net, pj@sgi.com,
       akpm@osdl.org, jlan@sgi.com, mbligh@google.com, rohitseth@google.com,
       winget@google.com, Simon.Derr@bull.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ckrm-tech] [PATCH 6/6] Resource Groups over generic containers
References: <20061004234316.677837000@menage.corp.google.com> <20061004235752.935272000@menage.corp.google.com>
In-Reply-To: <20061004235752.935272000@menage.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Paul,

I've just started playing with the new patchset and found a few issues.

menage@google.com wrote:
> +ssize_t res_group_file_write(struct container *cont,
> +				   struct cftype *cft,
> +				   struct file *file,
> +				   const char __user *userbuf,
> +				   size_t nbytes, loff_t *ppos)
> +{
> +	struct res_group_cft *rgcft = container_of(cft, struct res_group_cft, cft);
> +	struct res_controller *ctlr = rgcft->ctlr;
> +
> +	if (nbytes >= PAGE_SIZE)
> +		return -E2BIG;
> +
> +	char *buf;
> +	ssize_t retval;
> +	int filetype = cft->private;
> +
> +	buf = kmalloc(nbytes + 1, GFP_USER);

This should be kmalloc(nbytes), an echo ".." has a "\n" associated
with it.

> +	if (!buf) return -ENOMEM;
> +	if (copy_from_user(buf, userbuf, nbytes)) {
> +		retval = -EFAULT;
> +		goto out1;
> +	}
> +	buf[nbytes] = 0;	/* nul-terminate */
> +

this should be buf[nbytes - 1]



-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
