Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267083AbSLDU5m>; Wed, 4 Dec 2002 15:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267085AbSLDU5m>; Wed, 4 Dec 2002 15:57:42 -0500
Received: from [207.61.129.108] ([207.61.129.108]:29653 "EHLO
	mail.datawire.net") by vger.kernel.org with ESMTP
	id <S267083AbSLDU5l>; Wed, 4 Dec 2002 15:57:41 -0500
From: Shawn Starr <shawn.starr@datawire.net>
Organization: Datawire Communication Networks Inc.
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.50, ACPI] link error
Date: Wed, 4 Dec 2002 16:05:11 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200212041605.11935.shawn.starr@datawire.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thats what I thought until Pavel told me SOFTWARE_SUSPEND requires ACPI_SLEEP 
and ACPI_SLEEP should not be unchecked if SOFTWARE_SUSPEND is disabled.

My patch was only to fix a link error in 2.5.49/50. A better solution is 
needed :-)

Shawn.


>List:     linux-kernel
>Subject:  Re: [2.5.50, ACPI] link error
From:     Roman Zippel <zippel@linux-m68k.org>
>Date:     2002-12-04 20:29:08
>[Download message RAW]
>
>Hi,
>
>On Wed, 4 Dec 2002, Adrian Bunk wrote:
>
> In drivers/acpi/Config.in in 2.5.44:
> 
> <--   snip  -->
> 
> ...
> if [ "$CONFIG_ACPI_HT_ONLY" != "y" ]; then
>    bool     '  Sleep States' CONFIG_ACPI_SLEEP
> ...
>    define_bool CONFIG_ACPI_SLEEP $CONFIG_SOFTWARE_SUSPEND
> ...
> fi
> ...
> 
> <--  snip  -->
> 
> 
> This double definition was at least confusing, a simple
> 
>   dep_bool '  Sleep States' CONFIG_ACPI_SLEEP $CONFIG_SOFTWARE_SUSPEND
> 
> would have expressed it better.

>It's not really the same and the first probably heavily confuses xconfig.
>If CONFIG_SOFTWARE_SUSPEND can do without CONFIG_ACPI_SLEEP, the second 
>version should work fine.

>  config ACPI_SLEEP
>       bool "Sleep States"
> -     depends on X86 && ACPI && !ACPI_HT_ONLY
> +     depends on X86 && ACPI && !ACPI_HT_ONLY && SOFTWARE_SUSPEND
>       default SOFTWARE_SUSPEND
>       ---help---
>         This option adds support for ACPI suspend states. 

>The default is probably not needed anymore.

-- 
Shawn Starr
UNIX Systems Administrator, Operations
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008
shawn.starr@datawire.net
"The power to Transact" - http://www.datawire.net

