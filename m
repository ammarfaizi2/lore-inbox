Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbSLEQkR>; Thu, 5 Dec 2002 11:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261678AbSLEQkR>; Thu, 5 Dec 2002 11:40:17 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:16389 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261660AbSLEQkN>; Thu, 5 Dec 2002 11:40:13 -0500
Date: Thu, 5 Dec 2002 17:47:42 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Shawn Starr <shawn.starr@datawire.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.50, ACPI] link error
In-Reply-To: <200212051057.14882.shawn.starr@datawire.net>
Message-ID: <Pine.LNX.4.44.0212051729120.2113-100000@serv>
References: <200212042312.gB4NC8UJ021406@BlackBerry.NET>
 <Pine.LNX.4.44.0212050030190.2113-100000@serv> <200212051057.14882.shawn.starr@datawire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 5 Dec 2002, Shawn Starr wrote:

> SLEEP	SUSPEND		SLEEP visible		SUSPEND visible
> n		n			y				n
> y		n			y				y
> y		y			y				y
> 
> We really do need recursive support though. A user should not be able to 
> select SOFTWARE_SUSPEND without SLEEP selected.

So just let SOFTWARE_SUSPEND depend on ACPI_SLEEP, if ACPI_SLEEP is 
independent it doesn't has to depend on SUSPEND.
Another possibility is that you might want to restore the old behaviour, 
that SOFTWARE_SUSPEND is always visible and forces ACPI_SLEEP to y if 
needed, but then you have to explicitly disable the user prompt and 
SOFTWARE_SUSPEND must not depend on ACPI_SLEEP:

config ACPI_SLEEP
	bool "Sleep States" if !SOFTWARE_SUSPEND
	default SOFTWARE_SUSPEND

config SOFTWARE_SUSPEND
	bool "Software Suspend (EXPERIMENTAL)"
	depends on EXPERIMENTAL && PM

bye, Roman

PS: Could you check your mailer why your mails don't reach lkml?

