Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265474AbTGLMWI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 08:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265483AbTGLMWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 08:22:08 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:29056 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265474AbTGLMWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 08:22:06 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: <lista1@telia.com>, <axboe@suse.de>
Subject: Re: 2.5.75 does not boot - TCQ oops
Date: Sat, 12 Jul 2003 06:46:01 -0400
User-Agent: KMail/1.5.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307120646.01060.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I figured out some more things.

I split my root fs in half and made two identical copies  - one on reiser and 
one on xfs. I compiled a bunch of kernels, and tested some more.

A TCQ enabled kernel with AS, queue depth of 32 works fine on both reiser and 
xfs. A TCQ enabled kernel with deadline, queue depth of 32 works fine on both 
reiser and xfs. Note the depth of 32. I had TCQ enabled on previous <74 
kernels and it worked fine, everywhere with depth 32. 

However, the kernel that crashed was using the default
(The default is 8, even though the comment says 32).
I tested that kernel again with reiserfs, TCQ, the two elevators, and queue 
depth 8 - on-boot fsck detects corruption every time, marks the system 
unclean, and requires --rebuild-tree or --fix-fixable on any further mounts. 
I now get "Wrong amount of used blocks." message.

Have not tested depth 8 TCQ kernel with xfs, since that's my surviving root 
fs, and I'd like to avoid corruption there. 

Have not tested queue depths other than 8 and 32. 
I could test some more on reiser now that I have a backup root fs.




