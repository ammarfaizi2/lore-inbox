Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWBKDbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWBKDbL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 22:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWBKDbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 22:31:11 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:52399 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S932137AbWBKDbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 22:31:10 -0500
Message-ID: <43ED5A7B.7040908@tlinx.org>
Date: Fri, 10 Feb 2006 19:31:07 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: max symlink = 5? ?bug? ?feature deficit?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The maximum number of followed symlinks seems to be set to 5.

This seems small when compared to other filesystem limits.
Is there some objection to it being raised?  Should it be
something like Glib's '20' or '255'?

It would involve a change in include/namei.h and perhaps
a cleanup of the comment (which states the limit is '8') in
namei.c

There is some confusion with the shell utilities thinking
some links are valid, but other utilities giving an error:

 > readlink -f cpu/args.t
/usr/src/packages/BUILD/perl-5.8.6/t/op/args.t
 > cat cpu/args.t
cat: cpu/args.t: Too many levels of symbolic links
 > namei cpu/args.t
f: cpu/args.t
 d cpu
 l args.t -> ../op/args.t
   d ..
   l op -> ../t/op/
     d ..
     l t -> perldir/t
       l perldir -> perl-5.8.6
         l perl-5.8.6 -> ../build/perl-5.8.6
           d ..
           l build -> BUILD
             d BUILD
           d perl-5.8.6
       d t
     d op
   - args.t

