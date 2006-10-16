Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161054AbWJPUNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbWJPUNi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 16:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161056AbWJPUNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 16:13:38 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:37540 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1161054AbWJPUNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 16:13:38 -0400
Message-ID: <4533E7E2.6010506@oracle.com>
Date: Mon, 16 Oct 2006 13:13:22 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: AIO, DIO fsx tests failures on 2.6.19-rc1-mm1
References: <1161013338.32606.2.camel@dyn9047017100.beaverton.ibm.com>	 <4533C6A1.40203@oracle.com> <1161021586.32606.6.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1161021586.32606.6.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Here is the easiest case to fix first :)
> simple DIO wrote more than asked for :(
> 
> elm3b29:~ # /root/fsx-linux -N 10000 -o 128000 -r 2048 -w 4096 -Z -R -W
> jnk
> mapped writes DISABLED
> truncating to largest ever: 0x32740
> truncating to largest ever: 0x39212
> truncating to largest ever: 0x3bae9
> short write: 0x17000 bytes instead of 0x14000   <<<<<<

So the answer is that -rc1-mm1 doesn't quite have the most recent
version of this patch.  Grab the final patch at the end of this post
from Andrew:

	http://lkml.org/lkml/2006/10/11/234

It fixes up a misunderstanding that came from
generic_file_buffered_write()'s habit of adding its 'written' input into
the amount of bytes it announces having written in its return value.

>From mm-commits it looks like -mm2 will have the full patch.

- z
