Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbSJAOW4>; Tue, 1 Oct 2002 10:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261643AbSJAOWz>; Tue, 1 Oct 2002 10:22:55 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:18840 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S261640AbSJAOWu>; Tue, 1 Oct 2002 10:22:50 -0400
Subject: Re: 2.5.39 Oops on boot (device_attach+0x3a)
From: Steven Cole <elenstev@mesatop.com>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Thomas Molina <tmolina@cox.net>
In-Reply-To: <20021001053957.GA5177@kroah.com>
References: <1033434784.3100.10.camel@localhost.localdomain> 
	<20021001053957.GA5177@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 01 Oct 2002 08:24:00 -0600
Message-Id: <1033482240.32404.116.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-30 at 23:39, Greg KH wrote:
> On Mon, Sep 30, 2002 at 07:13:02PM -0600, Steven Cole wrote:
> > I tried to boot 2.5.39 on my home machine and got the
> > following oops on boot with CONFIG_KALLSYMS=y (thanks Ingo!).
> 
> Do you have CONFIG_ISAPNP enabled?  If so, search the archives for the
> fix for this.  If not, please post your whole .config.

Although I don't have that test box in front of me now, I'm almost
certain that I do have CONFIG_ISAPNP enabled.  Searching the archives
turned up a fix similar to the one below which is part of 2.5.40, (which
I haven't been able to download yet).  I won't be able to test this
until tonight, but perhaps Thomas can see if this fixes the same oops
for him in the meantime.

Thanks,
Steven

--- 1.13/drivers/pnp/isapnp.c	Fri Sep 27 04:10:46 2002
+++ 1.14/drivers/pnp/isapnp.c	Sun Sep 29 18:19:31 2002
@@ -2281,7 +2281,9 @@
 EXPORT_SYMBOL(isapnp_register_driver);
 EXPORT_SYMBOL(isapnp_unregister_driver);
 
-static struct device_driver isapnp_device_driver = {};
+static struct device_driver isapnp_device_driver = {
+	.devices = LIST_HEAD_INIT(isapnp_device_driver.devices),
+};
static inline int isapnp_init_device_tree(void)
 {



