Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265857AbTB0SpU>; Thu, 27 Feb 2003 13:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265863AbTB0SpU>; Thu, 27 Feb 2003 13:45:20 -0500
Received: from air-2.osdl.org ([65.172.181.6]:40329 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265857AbTB0SpT>;
	Thu, 27 Feb 2003 13:45:19 -0500
Date: Thu, 27 Feb 2003 10:50:56 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: mbligh@aracnet.com, zwane@holomorphy.com, cw@f00f.org,
       linux-kernel@vger.kernel.org
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous reboots)
Message-Id: <20030227105056.3fd76ac6.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0302200847060.2493-100000@home.transmeta.com>
References: <39710000.1045757490@[10.10.2.4]>
	<Pine.LNX.4.44.0302200847060.2493-100000@home.transmeta.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2003 08:54:55 -0800 (PST)
Linus Torvalds <torvalds@transmeta.com> wrote:

| On Thu, 20 Feb 2003, Martin J. Bligh wrote:
| > 
| > There are patches in -mjb from Dave Hansen / Ben LaHaise to detect stack
| > overflow included with the stuff for the 4K stacks patch (intended for 
| > scaling to large numbers of tasks). I've split them out attatched, should 
| > apply to mainline reasonably easily.
| 
| Ok, the 4kB stack definitely won't work in real life, but that's because 
| we have some hopelessly bad stack users in the kernel. But the debugging 
| part would be good to try (in fact, it might be a good idea to keep the 
| 8kB stack, but with rather anal debugging. Just the "mcount" part should 
| do that).
| 
| A sorted list of bad stack users (more than 256 bytes) in my default build
| follows. Anybody can create their own with something like
| 
| 	objdump -d linux/vmlinux |
| 		grep 'sub.*$0x...,.*esp' |
| 		awk '{ print $9,$1 }' |
| 		sort > bigstack
| 
| and a script to look up the addresses.
| 
| That ide_unregister() thing uses up >2kB in just one call! And there are 
| several in the 1.5kB range too, with a long list of ~500 byte offenders.
| 
| Yeah, and this assumes we don't have alloca() users or other dynamic 
| stack allocators (non-constant-size automatic arrays). I hope we don't 
| have that kind of crap anywhere..

I don't get a nice listing from this script like you did.
Example of mine is below.  Do I just have a tools issue?

Thanks,
--
~Randy



$0x424,%esp c01f6bc0:
$0x490,%esp c0106010:
$0x4ac,%esp c016aec3:
$0x540,%esp c01061a6:
$0x5ac,%esp c010533e:
$0x798,%esp c02528b8:
$0x924,%esp c02484fb:
