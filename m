Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754593AbWKHRL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593AbWKHRL3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 12:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754594AbWKHRL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 12:11:29 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:36023 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1754593AbWKHRL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 12:11:28 -0500
Date: Wed, 8 Nov 2006 18:09:16 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Michael Holzheu <holzheu@de.ibm.com>
Cc: pavel@ucw.cz, Ingo Oeser <ioe-lkml@rameria.de>,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com
Subject: Re: How to document dimension units for virtual files?
Message-ID: <20061108170916.GA570@wohnheim.fh-wedel.de>
References: <20061108175412.3c2be30c.holzheu@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061108175412.3c2be30c.holzheu@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 November 2006 17:54:12 +0100, Michael Holzheu wrote:
> 
> What about the following ...

Awesome.  The next time someone flames me over this subject, I can
simly refer to this file.

One could nitpick that a) this applies to any interface, so it also
includes kernel command line and module parameters and b) there are
existing interfaces that interpret "kb" as 2^10 bytes, etc.  Maybe
this could be noted somehow, but it's not too important imho.

Acked-by: Joern Engel <joern@wh.fh-wedel.de>

> 
>  Documentation/filesystems/00-INDEX   |    2 +
>  Documentation/filesystems/ExportData |   47 +++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
> 
> diff -Naur linux-2.6.18/Documentation/filesystems/00-INDEX linux-2.6.18-exp-data-doc/Documentation/filesystems/00-INDEX
> --- linux-2.6.18/Documentation/filesystems/00-INDEX	2006-09-20 10:50:34.000000000 +0200
> +++ linux-2.6.18-exp-data-doc/Documentation/filesystems/00-INDEX	2006-11-08 17:45:31.000000000 +0100
> @@ -1,5 +1,7 @@
>  00-INDEX
>  	- this file (info on some of the filesystems supported by linux).
> +ExportData
> +	- recommendation of how to export data via virtual File Systems.
>  Exporting
>  	- explanation of how to make filesystems exportable.
>  Locking
> diff -Naur linux-2.6.18/Documentation/filesystems/ExportData linux-2.6.18-exp-data-doc/Documentation/filesystems/ExportData
> --- linux-2.6.18/Documentation/filesystems/ExportData	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.18-exp-data-doc/Documentation/filesystems/ExportData	2006-11-08 17:44:59.000000000 +0100
> @@ -0,0 +1,47 @@
> +
> +Export data via virtual File Systems
> +====================================
> +
> +If you want to export data to userspace via virtual filesystems
> +like procfs, sysfs, debugfs etc., the following rules are recommended:
> +
> +- Export only one value in one virtual file.
> +- Data format should be as simple as possible.
> +- Use ASCII formated strings, no binary data if possible.
> +- If data has dimension units, encode that in the filename.
> +
> +Please use the following prefixes, when dimension units are required (According
> +to IEC 60027-2 and SI/International System of Units):
> +
> +Storage size (SI prefixes)
> +--------------------------
> +* kB: kilobyte (10^3 Byte)
> +* MB: megabyte (10^6 Byte)
> +* GB: gigabyte (10^9 Byte)
> +* TB: terabyte (10^12 Byte)
> +* PB: petabyte (10^15 Byte)
> +
> +Storage size (Binary prefixes)
> +------------------------------
> +* KiB: kibibyte (2^10 Byte)
> +* MiB: mebibyte (2^20 Byte)
> +* GiB: gibibyte (2^30 Byte)
> +* TiB: tebibyte (2^40 Byte)
> +* PiB: pebibyte (2^50 Byte)
> +
> +Time (SI pefixes)
> +-----------------
> +* s:  Second
> +* ms: Millisecond (10^-3 Seconds)
> +* us: Microsecond (10^-6 Seconds)
> +* ns: Nanosecond (10^-9 Seconds)
> +
> +Examples:
> +---------
> +> ls /sys/kernel/debug/sysinfo
> +free_mem_KiB
> +online_time_ms
> +cpu_time_us
> +
> +> cat /sys/kernel/debug/free_mem_KiB
> +147536
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Jörn

-- 
Courage is not the absence of fear, but rather the judgement that
something else is more important than fear.
-- Ambrose Redmoon
