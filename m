Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVAMXnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVAMXnG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 18:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVAMXjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 18:39:04 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:42936 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261824AbVAMXev
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 18:34:51 -0500
Date: Thu, 13 Jan 2005 15:34:46 -0800
From: Greg KH <greg@kroah.com>
To: Luca Falavigna <dktrkranz@gmail.com>
Cc: vamsi_krishna@in.ibm.com, prasanna@in.ibm.com,
       Nathan Lynch <nathanl@austin.ibm.com>, suparna@in.ibm.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Kprobes /proc entry
Message-ID: <20050113233446.GA2710@kroah.com>
References: <41E2AC82.8020909@gmail.com> <20050110181445.GA31209@kroah.com> <1105479077.17592.8.camel@pants.austin.ibm.com> <20050111213400.GB18422@kroah.com> <41E70234.50900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E70234.50900@gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 12:20:20AM +0100, Luca Falavigna wrote:
> 
> +#ifdef CONFIG_DEBUG_FS

This ifdef should not be needed.

> +int kprobes_open(struct inode *inode, struct file *file)

Shouldn't these calls be static?

> +{
> +	try_module_get(THIS_MODULE);

Check the return value of this call?

>  static int __init init_kprobes(void)
>  {
>  	int i, err = 0;
> @@ -140,6 +233,16 @@
>  	for (i = 0; i < KPROBE_TABLE_SIZE; i++)
>  		INIT_HLIST_HEAD(&kprobe_table[i]);
> 
> +#ifdef CONFIG_DEBUG_FS

ifdef not needed.

> +	if(!(kprobes_dir = debugfs_create_dir("kprobes", NULL)))
> +		return -ENODEV;
> +	if(!(kprobes_list = debugfs_create_file("list", S_IRUGO, kprobes_dir,
> +					  	NULL, &kprobes_fops))) {
> +		debugfs_remove(kprobes_dir);
> +		return -ENODEV;
> +	}

You never delete this file or directory on module unload, do you?

thanks,

greg k-h
