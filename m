Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbTDSUkB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 16:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTDSUkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 16:40:00 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:37905 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263461AbTDSUj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 16:39:58 -0400
Date: Sat, 19 Apr 2003 22:51:52 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Christian Staudenmayer <eggdropfan@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-ac2 and lilo
Message-ID: <20030419205152.GA19800@win.tue.nl>
References: <20030419170725.35871.qmail@web41812.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030419170725.35871.qmail@web41812.mail.yahoo.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 19, 2003 at 10:07:25AM -0700, Christian Staudenmayer wrote:

> i'm running a machine that uses the aic7xxx driver for the old adaptec 2940 scsi
> controller. i had problems with getting 2.5.67-ac2 to run, it used to end in
> a kernel panic. i got told to remove the body of the function ide_xlate_1024
> by just "return 0;", which fixed the problem, i could then boot the kernel.
> but now, when running lilo, i get the following message:
> 
> Fatal: First boot sector doesn't have a valid LILO signature
> 
> these problems do not occur on kernels 2.4.20, 2.4.21-pre7-ac1 and 2.5.67-bk9,
> if i boot another kernel, i can run/install LILO without problems.
> 
> i'd appreciate any insight on this problem.

Hmm. You did not forget to rerun LILO or so?
If ide_xlate_1024 does nothing but "return 0" then
handle_ide_mess() does nothing.

What other differences does -ac2 have?
It reintroduces a bug in the partition reading code - the fragment

@@ -456,7 +556,7 @@
                if (!subtypes[n].parse)
                        continue;
                subtypes[n].parse(state, bdev, START_SECT(p)*sector_size,
-                                               NR_SECTS(p)*sector_size, slot);
+                                               NR_SECTS(p)*sector_size, n);
        }
        put_dev_sector(sect);

of the -ac2 patch is bad.
In order to judge whether it is this or something else I would have
to know much more about your system. What are the kernel boot messages
for this disk under 2.5.67-bk9 that works and 2.5.67-ac2 that fails?
What is the partition table? No disk managers in sight? Does LILO
have lba32 or linear options?
Does 2.5.67-ac2 work if you replace its fs/partitions/msdos.c by
the vanilla one?

Andries

