Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbTFLK3G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 06:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264809AbTFLK3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 06:29:06 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:58541 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S264808AbTFLK3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 06:29:03 -0400
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- blkdev_put() problem?
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Andy Pfiffer <andyp@osdl.org>, adam@yggdrasil.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030611172958.5e4d3500.akpm@digeo.com>
References: <1052507057.15923.31.camel@andyp.pdx.osdl.net>
	 <1052510656.6334.8.camel@chtephan.cs.pocnet.net>
	 <1052513725.15923.45.camel@andyp.pdx.osdl.net>
	 <1055369326.1158.252.camel@andyp.pdx.osdl.net>
	 <1055373692.16483.8.camel@chtephan.cs.pocnet.net>
	 <1055377253.1222.8.camel@andyp.pdx.osdl.net>
	 <20030611172958.5e4d3500.akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1055414558.565.4.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 12 Jun 2003 12:42:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Don, 2003-06-12 um 02.29 schrieb Andrew Morton:

> But sync() should certainly write everything out, and lilo does perform a
> sync.

Yep.

> I'd be interested in seeing the contents of /proc/meminfo immediately after
> the lilo run, see if there's any dirty memory left around.

Yes, one page. After running lilo, there are 4k diry, running sync
doesn't get it below 4k. Only flushb /dev/hda does (or waiting several
minutes).

If you're interested, I've put an annotated version of

( cat /proc/meminfo; lilo; cat /proc/meminfo; sync; cat /proc/meminfo;
flushb /dev/hda; cat /proc/meminfo ) | buffer > meminfo.out.txt

on my web space: http://www.saout.de/files/meminfo.out.txt

(the kernel used was 2.5.70-mm7 with some unrelated patches backed out)

BTW: I found out that now strace lilo freezes the machine...

-- 
Christophe Saout <christophe@saout.de>

