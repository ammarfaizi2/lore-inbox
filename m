Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759433AbWLBK3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759433AbWLBK3F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 05:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759434AbWLBK3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 05:29:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13737 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1759433AbWLBK3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 05:29:02 -0500
Subject: Re: [RFC] Include ACPI DSDT from INITRD patch into mainline
From: Arjan van de Ven <arjan@infradead.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Arkadiusz Miskiewicz <arekm@maven.pl>,
       Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org,
       Eric Piel <eric.piel@tremplin-utc>
In-Reply-To: <20061201221745.7bea6e72@localhost.localdomain>
References: <1164998179.5257.953.camel@gullible>
	 <1165006694.5257.968.camel@gullible>
	 <20061201215551.66b6eb60@localhost.localdomain>
	 <200612012301.20086.arekm@maven.pl>
	 <20061201221745.7bea6e72@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 02 Dec 2006 11:28:59 +0100
Message-Id: <1165055339.3233.148.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-01 at 22:17 +0000, Alan wrote:
> On Fri, 1 Dec 2006 23:01:20 +0100
> Arkadiusz Miskiewicz <arekm@maven.pl> wrote:
> 
> > Acer notebook users here dump DSDT from their own machine, fix it and then 
> > load via initrd. 
> 
> Under EU law thats two copies without permission and modification without
> permission of the rights holder....
> 
> > > and if they do does it have to be 
> > > an ugly hack in the mainstream kernel.
> > 
> > Can it be done without hacks somehow (in the way that adding fixed DSDT is 
> > easy for user)?
> 
> Arjan - can you explain the linking dsdt one in more detail ?


 config ACPI_CUSTOM_DSDT
       bool "Include Custom DSDT"
        depends on !STANDALONE
        default n 
        help
          This option is to load a custom ACPI DSDT
          If you don't know what that is, say N.

config ACPI_CUSTOM_DSDT_FILE
        string "Custom DSDT Table file to include"
        depends on ACPI_CUSTOM_DSDT
        default ""
        help
          Enter the full path name to the file which includes the
AmlCode
          declaration.


these allow you to nicely build a DSDT into the kernel, so that it can
be used FROM THE START. Not as some of the hacks do, replacing the DSDT
code while it is running. (would you really want to replace a kernel
modules' code while it's running by some other version of the module? If
the answer is no, why would you want to do it to bios code... )

Now for distro kernels this is somewhat awkward, however that's only a
bit of glue away realistically; stick it in it's own section and objcopy
the right one into the vmlinuz isn't that big a deal....


