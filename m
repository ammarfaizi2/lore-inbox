Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267410AbTAWWKF>; Thu, 23 Jan 2003 17:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267431AbTAWWKF>; Thu, 23 Jan 2003 17:10:05 -0500
Received: from packet.digeo.com ([12.110.80.53]:51123 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267410AbTAWWKC>;
	Thu, 23 Jan 2003 17:10:02 -0500
Date: Thu, 23 Jan 2003 14:38:24 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dave Olien <dmo@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, markw@osdl.org,
       cliffw@osdl.org, maryedie@osdl.org, jenny@osdl.org
Subject: Re: [BUG] BUG_ON in I/O scheduler, bugme # 288
Message-Id: <20030123143824.4aae1efd.akpm@digeo.com>
In-Reply-To: <20030123135448.A8801@acpi.pdx.osdl.net>
References: <20030123135448.A8801@acpi.pdx.osdl.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jan 2003 22:19:07.0053 (UTC) FILETIME=[71D515D0:01C2C32D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Olien <dmo@osdl.org> wrote:
>
> 
> Jens, Andrew
> 
> The group here doing dbt2 workload measurements have hit a couple of
> problems APPARENTLY in the block I/O scheduler when doing write-intensive
> raw disk I/O through a DAC960 extremeraid 2000 controller.
> This wasn't a problem in 2.5.49.  It has appeared since then.
> 
> I've filed a bug on the OSDL bugme database.  You can read it at:
> 
> 	http://bugme.osdl.org/show_bug.cgi?id=288

The title is "2.5.59 and 2.5.50-mm2".  I assume it should be 2.5.59-mm2??


> I've also put a more complete report in my web site:
> 
> 	http://www.osdl.org/archive/dmo/deadline_bugon.

oooh, goody.  A new stresstest tool.

> Begin with the README file.
> 
> For same reason, the README file isn't appearing on my web page.
> I'll look into that. In the mean time, I've included the contests
> of the README file below.
> 
> I'm about to try reproducing the problem on a smaller hardware
> configuration.  Then, I'll test whether the same problem occurs with
> read intensive I/O.

OK, thanks.

The important thing about direct-io is that it will frequently cause multiple
I/Os to be in flight against the same disk sector.  That will never happen
with regular I/O because the pagecache acts as a synchronisation point.

Probably, this has tickled a bug in the I/O scheduler.  Possibly in
direct-io, too - that code's fairly fresh, and quite complex.


