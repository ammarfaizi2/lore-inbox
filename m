Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030375AbWJXOOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbWJXOOQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 10:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbWJXOOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 10:14:16 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:45382 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S965148AbWJXOOP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 10:14:15 -0400
In-Reply-To: <200610232103.33710.ioe-lkml@rameria.de>
Subject: Re: How to document dimension units for virtual files?
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, mschwid2@de.ibm.com
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OFA94CF0D3.C5318A12-ON42257211.004B4AC4-42257211.004E4728@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Tue, 24 Oct 2006 16:15:00 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 24/10/2006 16:16:53
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Ingo Oeser <ioe-lkml@rameria.de> wrote on 10/23/2006 09:03:32 PM:

[snip]

> > 2. Encode dimension unit into filename (e.g. onlinetime_ms or
memory_kb)
>
> This is the recommended one.
> - simple to implement and understand on both sides
>
> - if you change units, you notice breaking userspace immediately
>   and can even notice it being used in closed source tools
>   with a simple strace
>
> - no parsing involved, as the author of the user space tool
>   usually assumes the unit implicitly (like "programming by contract",
where
>   the "contract" is the filename, which is quite easy to check for.
>
> - you can keep a legacy interface with neglible effort and code wastage
>
> - many advantages I forgot :-)
>

I also think that this is the best solution. It would be nice to have
that documented somewhere. Maybe in the Documentation directory
something like:

Howto export data in virtual files
==================================

If you want to export data to userspace via virtual filesystems
like procfs, sysfs, debugfs etc., the following rules are recommended:

- Export only one value in one virtual file.
- Data format should be as simple as possible.
- Use ASCII formated strings, no binary data if possible.
- If data has dimension units, encode that in the filename.
  Please use the following suffixes:
  * kb: Kilobytes
  * mb: Megabytes
  * ms: Milliseconds
  * us: Microseconds
  * ns: Nanoseconds
  * ...

Examples:
---------
> ls /sys/mydata
memory_kb
online_time_ms

> cat /sys/mydata/memory_kb
4769

Michael

