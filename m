Return-Path: <linux-kernel-owner+w=401wt.eu-S1754424AbWLIUz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424AbWLIUz6 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 15:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755972AbWLIUz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 15:55:58 -0500
Received: from gate.crashing.org ([63.228.1.57]:40757 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754424AbWLIUz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 15:55:57 -0500
Subject: Re: sysfs file creation result nightmare (WAS radeonfb: Fix
	sysfs_create_bin_file warnings)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jean Delvare <khali@linux-fr.org>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20061209123817.f0117ad6.akpm@osdl.org>
References: <20061209165606.2f026a6c.khali@linux-fr.org>
	 <1165694351.1103.133.camel@localhost.localdomain>
	 <20061209123817.f0117ad6.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 10 Dec 2006 07:55:47 +1100
Message-Id: <1165697748.1103.152.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Why would I prevent the framebuffer from initializing (and thus a
> > console to be displayed at all on many machines) just because for some
> > reason, I couldn't create a pair of EDID files in sysfs that are not
> > even very useful anymore ?
> 
> Because there's a bug in your kernel.  We don't hide and work around bugs.

But not initializing the fbdev will be much more effective at hiding the
bug than just displaying a warning, which could just be done inside
sysfs_create_file.

Besides, in most cases, there is no bug. That is, there is no bug that
will cause the file creation to fail and it will not fail.

> Just fix the bugs, for heck's sake.

Considering that in 99% of the case, the creation cannot fail unless
some cosmic ray hit your machine or you are running oom... that is,
plenty of cases where there is _no_ bug now gets a useless code bloat
for checking a result code where there is nothing sane you can do about
it anyway.

Ben.


