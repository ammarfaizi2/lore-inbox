Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266826AbUFYSCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266826AbUFYSCx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 14:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266827AbUFYSCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 14:02:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6838 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266826AbUFYSBQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 14:01:16 -0400
Date: Fri, 25 Jun 2004 19:01:15 +0100
From: Matthew Wilcox <willy@debian.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: willy@debian.org, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [2.6 patch] fix arch/i386/pci/Makefile
Message-ID: <20040625180115.GC28162@parcelfarce.linux.theplanet.co.uk>
References: <20040625001513.GB18303@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040625001513.GB18303@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 02:15:14AM +0200, Adrian Bunk wrote:
> This problem occurs with
>   CONFIG_ACPI_PCI=y && (CONFIG_X86_VISWS=y || CONFIG_X86_NUMAQ=y)

That combination certainly doesn't make sense.  No VisWS or NUMAQ systems
have ACPI.  How did you manage to turn this on given:

menu "ACPI (Advanced Configuration and Power Interface) Support"
        depends on !X86_VISWS
        depends on !IA64_HP_SIM
        depends on IA64 || X86

If you apply the following patch, does it help?

--- drivers/acpi/Kconfig        30 Mar 2004 12:42:25 -0000      1.11
+++ drivers/acpi/Kconfig        25 Jun 2004 18:00:29 -0000
@@ -3,7 +3,7 @@
 #
 
 menu "ACPI (Advanced Configuration and Power Interface) Support"
-       depends on !X86_VISWS
+       depends on !X86_VISWS && !X86_NUMAQ
        depends on !IA64_HP_SIM
        depends on IA64 || X86
 

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
