Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265015AbUGBW5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265015AbUGBW5X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 18:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265041AbUGBW5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 18:57:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:29111 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265015AbUGBW46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 18:56:58 -0400
Date: Fri, 2 Jul 2004 15:59:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: petero2@telia.com, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
Message-Id: <20040702155945.5c375bd2.akpm@osdl.org>
In-Reply-To: <20040702224720.GA7969@kroah.com>
References: <m2lli36ec9.fsf@telia.com>
	<m2u0wqqdpl.fsf@telia.com>
	<20040702150819.646b6103.akpm@osdl.org>
	<20040702224720.GA7969@kroah.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> > const char *__bdevname(dev_t dev, char *buffer)
> > {
> > 	struct gendisk *disk;
> > 	int part;
> > 
> > 	disk = get_gendisk(dev, &part);
> > 	if (disk) {
> > 		buffer = disk_name(disk, part, buffer);
> > 		put_disk(disk);
> > 	} else {
> > 		snprintf(buffer, BDEVNAME_SIZE, "unknown-block(%u,%u)",
> > 				MAJOR(dev), MINOR(dev));
> > 	}
> > 
> > get_gendisk() did an internal module_get() in kobj_lookup().
> 
> But if kobj_lookup() succeeds, module_put() is called before returning
> (actually it's always called, right?) 

Oop, sorry, yes.  Peter, are you sure this is where the leak is coming from?
