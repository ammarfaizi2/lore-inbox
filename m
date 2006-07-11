Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWGKHsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWGKHsk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWGKHsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:48:40 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:36810 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750701AbWGKHsj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:48:39 -0400
Date: Tue, 11 Jul 2006 09:48:35 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Joshua Hudson <joshudson@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] 'volatile' in userspace
In-Reply-To: <44B29461.40605@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0607110945580.30961@yvahk01.tjqt.qr>
References: <44B0FAD5.7050002@argo.co.il>  <MDEHLPKNGKAHNMBLJOLKMEPGNAAB.davids@webmaster.com>
  <20060709195114.GB17128@thunk.org> <20060709204006.GA5242@nospam.com> 
 <20060710034250.GA15138@thunk.org> <bda6d13a0607101000w6ec403bbq7ac0fe66c09c6080@mail.gmail.com>
 <44B29461.40605@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> What's wrong with _exit(exec() == -1 ? 0 : errno);
> and picking up the status with wait(2) ?
>
The exec'd application may return regular error codes, which would 
interfere. IIRC /usr/sbin/useradd has different exit codes depending on 
what failed (providing some option, failure to create account, failure to 
create home dir, etc.). Now if you exit(errno) instead, you have an 
overlap.
And your code is somewhat wrong. Given that exec() would stand for 
execve(someprogram_and_args_here), if it returned -1 you would return 0, 
indicating success. Can't be. And if exec() does not return -1, which it 
never should, you return errno, which never reaches anyone.


Jan Engelhardt
-- 
