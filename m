Return-Path: <linux-kernel-owner+w=401wt.eu-S932404AbXAGFYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbXAGFYX (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 00:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbXAGFYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 00:24:23 -0500
Received: from terminus.zytor.com ([192.83.249.54]:52222 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932400AbXAGFYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 00:24:22 -0500
Message-ID: <45A083F2.5000000@zytor.com>
Date: Sat, 06 Jan 2007 21:24:02 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
CC: nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       webmaster@kernel.org
Subject: How git affects kernel.org performance
References: <20061214223718.GA3816@elf.ucw.cz>	 <20061216094421.416a271e.randy.dunlap@oracle.com>	 <20061216095702.3e6f1d1f.akpm@osdl.org>  <458434B0.4090506@oracle.com>	 <1166297434.26330.34.camel@localhost.localdomain>	 <1166304080.13548.8.camel@nigel.suspend2.net>  <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com>
In-Reply-To: <45A08269.4050504@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some more data on how git affects kernel.org...

During extremely high load, it appears that what slows kernel.org down 
more than anything else is the time that each individual getdents() call 
takes.  When I've looked this I've observed times from 200 ms to almost 
2 seconds!  Since an unpacked *OR* unpruned git tree adds 256 
directories to a cleanly packed tree, you can do the math yourself.

I have tried reducing vm.vfs_cache_pressure down to 1 on the kernel.org 
machines in order to improve the situation, but even at that point it 
appears the kernel doesn't readily hold the entire directory hierarchy 
in memory, even though there is space to do so.  I have suggested that 
we might want to add a sysctl to change the denominator from the default 
100.

The one thing that we need done locally is to have a smart uploader, 
instead of relying on rsync.  That, unfortunately, is a fairly sizable 
project.

	-hpa
