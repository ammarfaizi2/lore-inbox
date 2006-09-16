Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWIPWaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWIPWaU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 18:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWIPWaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 18:30:19 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:2510 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964789AbWIPWaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 18:30:16 -0400
Date: Sun, 17 Sep 2006 00:26:22 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 05/22][RFC] Unionfs: Copyup Functionality
In-Reply-To: <20060916221341.GB28659@filer.fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609170023500.24270@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901014251.GF5788@fsl.cs.sunysb.edu>
 <Pine.LNX.4.61.0609040852550.9108@yvahk01.tjqt.qr>
 <20060904092534.GA19836@filer.fsl.cs.sunysb.edu>
 <Pine.LNX.4.61.0609041239390.17115@yvahk01.tjqt.qr>
 <20060916221341.GB28659@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> Is BUG the right thing, what do others think? (Using WARN, and set err to
>> >> something useful?)
>> > 
>> >Well, it is definitely a condition which Unionfs doesn't expect - if it
>> >doesn't know about the type, how could it copy it up?
>> 
>> Other filesystems don't seem to BUG either (at least I have not run into 
>> that yet) when - for whatever reasons - the statdata of a dentry is 
>> fubared. `ls`  just displays it then, like
>> 
>>  ?-w---Sr-T 1 root root 4294967295 date fubared_file
>
>I was thinking about this, and the difference between "other filesystems"
>and unionfs in this case is that the example above is just stat. During
>copyup, unionfs has to copy the file to another filesystem. How is it
>supposed to do that when it doesn't understand what the file is?
>
>Sure, when unionfs does stat, fubared statdata is fine, but during
>copyup...bad things could potentially happen.
>
>Any suggestions how to copyup an unknown file type?

Return some error value if possible. -EIO, banners, big printk()s,
anything. Tell the user the filesytem on some branch is hosed - or
too advanced to be understood by unionfs. (There seems to be a
variety of file types in other UNIXes according to `man 2 stat`,
such as doors, etc.)



Jan Engelhardt
-- 
