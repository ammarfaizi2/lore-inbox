Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVBULhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVBULhz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 06:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVBULhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 06:37:54 -0500
Received: from hermes.domdv.de ([193.102.202.1]:49158 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261951AbVBULhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 06:37:52 -0500
Message-ID: <4219C811.5070906@domdv.de>
Date: Mon, 21 Feb 2005 12:37:53 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Adriaanse <alex.adriaanse@gmail.com>
CC: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Odd data corruption problem with LVM/ReiserFS
References: <93ca3067050220212518d94666@mail.gmail.com>
In-Reply-To: <93ca3067050220212518d94666@mail.gmail.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Adriaanse wrote:
> As far as I can tell all the directories are still intact, but there
> was a good number of files that had been corrupted.  Those files
> looked like they had some chunks removed, and some had a bunch of NUL
> characters (in blocks of 4096 characters).  Some files even had chunks
> of other files inside of them!

I can second that. I had the same experience this weekend on a 
md/dm/reiserfs setup. The funny thing is that e.g. find reports I/O 
errors but if you then run tar on the tree you eventually get the 
correct data from tar. Then run find again and you'll again get I/O errors.

> I did a reiserfsck (3.6.19) on /var, which did not report any problems.

You need to run 'reiserfsck --rebuild-tree' and see what happens :-(

> Anyway, what do you guys think could be the problem?  Could it be that
> the LVM / Device Mapper snapshot feature is solely responsible for
> this corruption?  (I'm sure there's a reason it's marked
> Experimental).

I don't think so - I changed from reiserfs to ext3 without changing the 
underlying dm/raid5 and this seems to work properly.

I can furthermore state that reiserfs without dm/md does work correctly 
as I use reiserfs on a ieee1394 backup disk (that saved me from terrible 
trouble).

Currently I can only warn to not use reiserfs with dm/md on 2.6.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
