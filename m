Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbVIIQoB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbVIIQoB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 12:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbVIIQoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 12:44:01 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57555 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751429AbVIIQoA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 12:44:00 -0400
Date: Fri, 9 Sep 2005 17:43:58 +0100
From: viro@ZenIV.linux.org.uk
To: Eric Piel <Eric.Piel@lifl.fr>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       zippel@linux-m68k.org
Subject: Re: [PATCH] bogus #if (acpi/blacklist)
Message-ID: <20050909164358.GP9623@ZenIV.linux.org.uk>
References: <20050909160723.GI9623@ZenIV.linux.org.uk> <4321B5F6.4040707@lifl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4321B5F6.4040707@lifl.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 06:19:02PM +0200, Eric Piel wrote:
> 09/09/2005 06:07 PM, viro@zeniv.linux.org.uk wrote/a ??crit:
> >Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> >----
> >diff -urN RC13-git8-base/drivers/acpi/blacklist.c 
> >current/drivers/acpi/blacklist.c
> >--- RC13-git8-base/drivers/acpi/blacklist.c	2005-09-08 
> >23:42:49.000000000 -0400
> >+++ current/drivers/acpi/blacklist.c	2005-09-09 11:28:44.000000000 -0400
> >@@ -73,7 +73,7 @@
> > 	{""}
> > };
> > 
> >-#if	CONFIG_ACPI_BLACKLIST_YEAR
> >+#ifdef	CONFIG_ACPI_BLACKLIST_YEAR
> > 
> > static int __init blacklist_by_year(void)
> > {
> 
> Are you sure about this? IIRC, CONFIG_ACPI_BLACKLIST_YEAR is defined to 
> 0 when it should not be blacklisted. In drivers/acpi/Kconfig :
>     Enter 0 to disable this mechanism and allow ACPI to
>     run by default no matter what the year.  (default)

Hmm....  Oh, lovely - so we have that non-zero if set, 0 if it's i386 or
amd64 and not set and not defined if it's ia64 and not set.

Sigh...  It should be left as #if, of course, but I suspect that cleaner way to
deal with that would be (in Kconfig)

config ACPI_BLACKLIST_YEAR
        int "Disable ACPI for systems before Jan 1st this year" if X86
        default 0

Roman?
