Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUAVHtT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 02:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265951AbUAVHtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 02:49:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:29596 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264444AbUAVHtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 02:49:18 -0500
Date: Wed, 21 Jan 2004 23:49:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: ncunningham@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Shutdown IDE before powering off.
Message-Id: <20040121234956.557d8a40.akpm@osdl.org>
In-Reply-To: <1074735774.31963.82.camel@laptop-linux>
References: <1074735774.31963.82.camel@laptop-linux>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@users.sourceforge.net> wrote:
>
> +static void ide_drive_shutdown (struct device * dev)
>  +{
>  +	generic_ide_suspend(dev, 5);
>  +}
>  +
>   int ide_register_driver(ide_driver_t *driver)
>   {
>   	struct list_head list;
>  @@ -2519,6 +2524,7 @@
>   	driver->gen_driver.name = (char *) driver->name;
>   	driver->gen_driver.bus = &ide_bus_type;
>   	driver->gen_driver.remove = ide_drive_remove;
>  +	driver->gen_driver.shutdown = ide_drive_shutdown;

This spins down the disk(s) when you're just doing do a reboot.  That's
fairly irritating and could affect reboot times if one has many disks.


