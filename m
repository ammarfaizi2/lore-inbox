Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267032AbSKRXpb>; Mon, 18 Nov 2002 18:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267029AbSKRXpY>; Mon, 18 Nov 2002 18:45:24 -0500
Received: from dp.samba.org ([66.70.73.150]:14555 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267030AbSKRXpS>;
	Mon, 18 Nov 2002 18:45:18 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: Doug Ledford <dledford@redhat.com>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Why /dev/sdc1 doesn't show up... 
In-reply-to: Your message of "Mon, 18 Nov 2002 04:51:17 CDT."
             <Pine.GSO.4.21.0211180403440.23400-100000@steklov.math.psu.edu> 
Date: Tue, 19 Nov 2002 10:49:21 +1100
Message-Id: <20021118235221.637162C456@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.GSO.4.21.0211180403440.23400-100000@steklov.math.psu.edu> you 
write:
> Not really.  For case in question (block devices) there is only one path
> and I'd rather keep it that way, thank you very much.

See other posting.  This is a fundamental design decision, and it's
not changing.  Sorry.

> Again, by the time when add_disk() got to reading partition table, device
> is _there_.  That's it - we had set it up completely, it's ready for IO,
> whatever.  At that point we want generic code to do some work with that
> device.  And there is no magic path for that - it's normal open/read/close.
> 
> There is no "live" flag - you had shown it, you'd better be ready to have
> it used.  Doesn't cause any problems.

Unless the module does something else afterwards which fails and wants
to fail the init.  You're saying "don't do that", which is not a good
answer 8(

You can implement a "make_module_live()" in module.h if you want
module authors to do two-stage init manually (and trust them to get it
right).  Or you can run a notifier on "enlivening" a module: I'd hoped
to avoid that.

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
