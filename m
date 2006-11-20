Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966339AbWKTWJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966339AbWKTWJw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966381AbWKTWJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:09:51 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:39069 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S966339AbWKTWJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:09:50 -0500
Subject: Re: how to handle indirect kconfig dependencies
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, zippel@linux-m68k.org
In-Reply-To: <20061116200741.fb607fe4.randy.dunlap@oracle.com>
References: <20061116200741.fb607fe4.randy.dunlap@oracle.com>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 16:09:31 -0600
Message-Id: <1164060571.2816.106.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-16 at 20:07 -0800, Randy Dunlap wrote:
> Hi,
> 
> I have a (randconfig) build of 2.6.19-rc5-mm2 with:
> 
> CONFIG_DEBUG_READAHEAD=y
> 
> which selects DEBUG_FS, so DEBUG_FS=y, but DEBUG_FS depends on
> SYSFS, and SYSFS is not set in the randconfig.
> 
> This randconfig causes this build error:
> 
> fs/built-in.o: In function `debugfs_init':
> inode.c:(.init.text+0xdb2): undefined reference to `kernel_subsys'
> 
> so the question is:
> (How) can kconfig follow the dependency chain and either
> - prevent this odd config combination or
> - see that 'select DEBUG_FS' implies 'select SYSFS' and then enable SYSFS
> ?
> 
> I don't believe that the right answer is to add
> 	depends on SYSFS
> to DEBUG_READAHEAD.
> 
> 
> .config is at http://oss.oracle.com/~rdunlap/configs/config-readahead-debugfs

Actually, no, I don't think this is the right thing to do.  If we can't
persuade selected CONFIG options to give an inherited dependency to the
selectee, then the only other option is to make sure that selectable
config options have no dependencies (i.e. they select everything they
need).

James


