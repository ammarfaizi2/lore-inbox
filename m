Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUBDXtW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbUBDXq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:46:59 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:37557
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S264278AbUBDXqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:46:01 -0500
Message-ID: <402184AA.2010302@tmr.com>
Date: Wed, 04 Feb 2004 18:47:54 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: the grugq <grugq@hcunix.net>, "Theodore Ts'o" <tytso@mit.edu>,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch 
References: Your message of "Wed, 04 Feb 2004 12:05:07 EST."             <40212643.4000104@tmr.com> <200402041714.i14HEIVD005246@turing-police.cc.vt.edu>
In-Reply-To: <200402041714.i14HEIVD005246@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Wed, 04 Feb 2004 12:05:07 EST, Bill Davidsen said:
> 
> 
>>It would be useful to have this as a directory option, so that all files 
>>in directory would be protected. I think wherever you do it you have to 
>>prevent hard links, so that unlink really removes the data.
> 
> 
> This of course implies that 'chattr +s' (or whatever it was) has to fail
> if the link count isn't exactly one.

Do you disagree that the count does need to be one?

>                                       Also makes for lots of uglyiness
> if it's a directory option - you then have to walk all the entries in the
> directory and check *their* link counts.  Bad Juju doing it in the kernel
> if you have a directory with a million entries - and racy as hell if you
> do it in userspace.

I agree with everything you said, "useful" doesn't always map to "easy." 
But if you agree that the count needs to be one on files, then you could 
also fail if you tried to add it to a directory which was not empty.

In case I didn't make it clear, the use I was considering was to create 
a single directory in which created files would really go away when 
deleted. I hadn't considered doing it after files were present, what you 
say about overhead is clearly an issue. I think I could even envision 
some bizarre race conditions if the kernel had to do marking of each 
file, so perhaps it's impractical.

But what happens when the 'setgid' bit is put on a directory? At least 
in 2.4 existing files do NOT get the group set, only files newly 
created. So unless someone feels that's a bug which needs immediate 
fixing, I can point to it as a model by which the feature could be 
practically implemented.

Comment?


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
