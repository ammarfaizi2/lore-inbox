Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbVIIRbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbVIIRbk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 13:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbVIIRbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 13:31:40 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:15079 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030279AbVIIRbj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 13:31:39 -0400
Date: Fri, 9 Sep 2005 18:31:38 +0100
From: viro@ZenIV.linux.org.uk
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Eric Piel <Eric.Piel@lifl.fr>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bogus #if (acpi/blacklist)
Message-ID: <20050909173138.GR9623@ZenIV.linux.org.uk>
References: <20050909160723.GI9623@ZenIV.linux.org.uk> <4321B5F6.4040707@lifl.fr> <20050909164358.GP9623@ZenIV.linux.org.uk> <Pine.LNX.4.61.0509091854500.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509091854500.3743@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 06:55:52PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Fri, 9 Sep 2005 viro@ZenIV.linux.org.uk wrote:
> 
> > Sigh...  It should be left as #if, of course, but I suspect that cleaner way to
> > deal with that would be (in Kconfig)
> > 
> > config ACPI_BLACKLIST_YEAR
> >         int "Disable ACPI for systems before Jan 1st this year" if X86
> >         default 0
> 
> That would be indeed the better fix.
> 
> bye, Roman

There we go, then (replacement for original variant, _not_ an incremental):

diff -urN RC13-git8-base/drivers/acpi/Kconfig current/drivers/acpi/Kconfig
--- RC13-git8-base/drivers/acpi/Kconfig	2005-09-08 23:42:49.000000000 -0400
+++ current/drivers/acpi/Kconfig	2005-09-09 12:41:37.000000000 -0400
@@ -250,8 +250,7 @@
 	  Enter the full path name to the file wich includes the AmlCode declaration.
 
 config ACPI_BLACKLIST_YEAR
-	int "Disable ACPI for systems before Jan 1st this year"
-	depends on X86
+	int "Disable ACPI for systems before Jan 1st this year" if X86
 	default 0
 	help
 	  enter a 4-digit year, eg. 2001 to disable ACPI by default
