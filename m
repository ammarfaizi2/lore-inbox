Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbVICAPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbVICAPk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 20:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVICAPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 20:15:40 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:7917 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751342AbVICAPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 20:15:39 -0400
From: gcoady@gmail.com
To: Andrew Morton <akpm@osdl.org>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1
Date: Sat, 03 Sep 2005 10:15:18 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <glphh1tkn5i36g3m5rt48b79hrej9f6h3r@4ax.com>
References: <fa.hqupr0d.1u3af35@ifi.uio.no> <4317AD4D.6030001@reub.net> <1125626219l.6072l.0l@werewolf.able.es> <20050901190655.345914ba.akpm@osdl.org> <1125676407l.6262l.0l@werewolf.able.es> <20050902144552.77c92d06.akpm@osdl.org>
In-Reply-To: <20050902144552.77c92d06.akpm@osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sep 2005 14:45:52 -0700, Andrew Morton <akpm@osdl.org> wrote:

>"J.A. Magallon" <jamagallon@able.es> wrote:
>>
[...] 
>> Still the same result, system bocks starting udev...
>> 
>
>OK, thanks.   Nothing from sysrq-t?  Does the below help?
>
>--- devel/fs/sysfs/file.c~gregkh-driver-sysfs-strip_leading_trailing_whitespace-fix	2005-09-02 04:01:40.000000000 -0700
>+++ devel-akpm/fs/sysfs/file.c	2005-09-02 04:05:02.000000000 -0700
>@@ -202,13 +202,14 @@ fill_write_buffer(struct sysfs_buffer * 
>  *	passing the buffer that we acquired in fill_write_buffer().
>  */
> 
>-static int 
>-flush_write_buffer(struct dentry * dentry, struct sysfs_buffer * buffer, size_t count)
>+static int flush_write_buffer(struct dentry *dentry,
>+			struct sysfs_buffer *buffer, size_t count_in)
> {
> 	struct attribute * attr = to_attr(dentry);
> 	struct kobject * kobj = to_kobj(dentry->d_parent);
> 	struct sysfs_ops * ops = buffer->ops;
> 	char *x;
>+	size_t count = count_in;
> 
> 	/* locate trailing white space */
> 	while ((count > 0) && isspace(buffer->page[count - 1]))
>@@ -224,7 +225,8 @@ flush_write_buffer(struct dentry * dentr
> 	/* terminate the string */
> 	x[count] = '\0';
> 
>-	return ops->store(kobj, attr, x, count);
>+	ops->store(kobj, attr, x, count);
>+	return count_in;
> }
> 
>
Hi Andrew,
Patch above fixes problem with sysfs writes to adm9240 driver 
locking up console in last three -mm kernels.

Grant.

