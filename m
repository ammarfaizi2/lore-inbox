Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264620AbTIDDMv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 23:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264624AbTIDDMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 23:12:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:21474 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264620AbTIDDMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 23:12:48 -0400
Date: Wed, 3 Sep 2003 20:12:47 -0700
From: Chris Wright <chrisw@osdl.org>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm5
Message-ID: <20030903201247.A4024@build.pdx.osdl.net>
References: <20030902231812.03fae13f.akpm@osdl.org> <20030904013059.GA11791@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030904013059.GA11791@gnuppy.monkey.org>; from billh@gnuppy.monkey.org on Wed, Sep 03, 2003 at 06:30:59PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bill Huey (billh@gnuppy.monkey.org) wrote:
> On Tue, Sep 02, 2003 at 11:18:12PM -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm5/
> 
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/linux/compile.h
>   CC      drivers/acpi/pci_link.o
> drivers/acpi/pci_link.c: In function `acpi_pci_link_try_get_current':
> drivers/acpi/pci_link.c:290: error: `_dbg' undeclared (first use in this function)
> drivers/acpi/pci_link.c:290: error: (Each undeclared identifier is reported only once
> drivers/acpi/pci_link.c:290: error: for each function it appears in.)
> make[2]: *** [drivers/acpi/pci_link.o] Error 1
> make[1]: *** [drivers/acpi] Error 2
> make: *** [drivers] Error 2

try the patch below.
thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--- drivers/acpi/pci_link.c.try	Wed Sep  3 15:06:33 2003
+++ drivers/acpi/pci_link.c	Wed Sep  3 15:07:22 2003
@@ -285,6 +285,8 @@ acpi_pci_link_try_get_current (
 {
 	int result;
 
+	ACPI_FUNCTION_TRACE("acpi_pci_link_try_get_current");
+
 	result = acpi_pci_link_get_current(link);
 	if (result && link->irq.active) {
  		return_VALUE(result);
