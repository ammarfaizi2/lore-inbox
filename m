Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267945AbUINWkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267945AbUINWkW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 18:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269485AbUINWjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 18:39:24 -0400
Received: from mail.gmx.de ([213.165.64.20]:60839 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267945AbUINWgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 18:36:20 -0400
X-Authenticated: #1725425
Date: Wed, 15 Sep 2004 00:43:32 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Peter Jones <pjones@redhat.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow root to modify raw scsi command permissions list
Message-Id: <20040915004332.6fe581f5.Ballarin.Marc@gmx.de>
In-Reply-To: <1095173470.5728.3.camel@localhost.localdomain>
References: <1095173470.5728.3.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004 10:51:10 -0400
Peter Jones <pjones@redhat.com> wrote:

Good to see someone do this. I tried myself but didn't get very far.


> diff -urpN linux-2.5-export/drivers/block/genhd.c pjones-2.5-export/drivers/block/genhd.c
...

>  };
> +static struct disk_attribute disk_attribute_driver = {

This obviously needs to be

+static struct disk_attribute disk_attr_driver = {

otherwise the following part won't work:

> @@ -409,6 +422,7 @@ static struct attribute * default_attrs[
>  	&disk_attr_removable.attr,
>  	&disk_attr_size.attr,
>  	&disk_attr_stat.attr,
> +	&disk_attr_driver.attr,
>  	NULL,
>  };

Additionally, the naming "rawio_cmd_filter" and RCF_* seems a bit
confusing (after all raw IO usually refers to O_DIRECT file access).
"sg_cmd_filter" and SGF_* appear to be a better choice IMHO.

How should changes to the table be made? I suppose something like "echo
add 04 > ok_read_commands". But rcf_store doesn't seem to get called. Am I
missing something?

Regards, and thanks for this patch
