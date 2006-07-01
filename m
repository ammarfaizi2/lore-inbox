Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWGAXgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWGAXgc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 19:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWGAXgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 19:36:32 -0400
Received: from mercury.realtime.net ([205.238.132.86]:31655 "EHLO
	ruth.realtime.net") by vger.kernel.org with ESMTP id S932115AbWGAXgb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 19:36:31 -0400
In-Reply-To: <20060701093927.GA25738@mars.ravnborg.org>
References: <200607010916.k619GuxT005076@sullivan.realtime.net> <20060701093927.GA25738@mars.ravnborg.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3616a5b01d543ea6b366e06b8464f67a@bga.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Milton Miller <miltonm@bga.com>
Subject: Re: [KBUILD] allow any PHONY in if_changed_dep
Date: Sat, 1 Jul 2006 18:36:13 -0500
To: Sam Ravnborg <sam@ravnborg.org>
X-Mailer: Apple Mail (2.623)
X-Server: High Performance Mail Server - http://surgemail.com r=-1092531819
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jul 1, 2006, at 4:39 AM, Sam Ravnborg wrote:

> On Sat, Jul 01, 2006 at 04:16:56AM -0500, Milton Miller wrote:
>> While all the if_changed family filter $(PHONY) from the list of newer
>> files, if_changed_dep was only filtering FORCE from the list of all
>> dependents.  This resulted in forced recompile every time.
>
> I see where you are heading with this. But on the principle of minimal
> suprise this is not good. Why does it not include file.o in the link
> when I mark it phony?

This is your suprise argument, right?  (Not my current problem).

Actually this is only changing weither file.o gets considered in
causing the build command to be executed.

> The root cause is buried in the powerpc/boot/Makefile restructuring.
> I do not see what is wrong with current approch if you do a simple
> s/cmd/if_changed/g and then assign targets += <relevant targets>
>

The issue is I need headers copied for some of the files.  The current
approach is any file that might need a copied header gets a dependency
on all of the copied .h files.  I was planning on coping some more
headers used in different files.  if_changed_dep

The issue is specifically COPYFILES.  The .o can not be built until
its dependencys are met, but it never exists itself.  The actual .h
files a given source will be detected by if_changed_dep and fixdep.

> You need to post a full diff of the Makefile before I can give better
> feedback.
>

Sure.  I'm reposting the series, I'll cc you and copy the makefile
patch to linux-kernel, its 3/5.    That patch is independent of 1 and 2 
while 4 and 5 require them.  The full series is available on the 
linuxppc-dev mailing list.

milton

