Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267490AbTAXB27>; Thu, 23 Jan 2003 20:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267491AbTAXB27>; Thu, 23 Jan 2003 20:28:59 -0500
Received: from dial-ctb04185.webone.com.au ([210.9.244.185]:52235 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S267490AbTAXB26>;
	Thu, 23 Jan 2003 20:28:58 -0500
Message-ID: <3E30990D.3090305@cyberone.com.au>
Date: Fri, 24 Jan 2003 12:38:21 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Dave Olien <dmo@osdl.org>
CC: axboe@suse.de, akpm@digeo.com, linux-kernel@vger.kernel.org,
       markw@osdl.org, cliffw@osdl.org, maryedie@osdl.org, jenny@osdl.org
Subject: Re: [BUG] BUG_ON in I/O scheduler, bugme # 288
References: <20030123135448.A8801@acpi.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Olien wrote:

>Jens, Andrew
>
>The group here doing dbt2 workload measurements have hit a couple of
>problems APPARENTLY in the block I/O scheduler when doing write-intensive
>raw disk I/O through a DAC960 extremeraid 2000 controller.
> This wasn't a problem in 2.5.49.  It has appeared since then.
>
>I've filed a bug on the OSDL bugme database.  You can read it at:
>
>	http://bugme.osdl.org/show_bug.cgi?id=288
>
>I've also put a more complete report in my web site:
>
>	http://www.osdl.org/archive/dmo/deadline_bugon.
>
>Begin with the README file.
>
>For same reason, the README file isn't appearing on my web page.
>I'll look into that. In the mean time, I've included the contests
>of the README file below.
>
>I'm about to try reproducing the problem on a smaller hardware
>configuration.  Then, I'll test whether the same problem occurs with
>read intensive I/O.
>
Thanks for the report. Andrew, I think this may be because
deadline_add_drq_rb puts "aliased" requests in the next_drq although they
are not put on the sort or fifo lists. This is the problem I described to
you before and exists in mm4.

Nick

