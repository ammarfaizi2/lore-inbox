Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261392AbSIZRNC>; Thu, 26 Sep 2002 13:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261412AbSIZRNB>; Thu, 26 Sep 2002 13:13:01 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:16890
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261392AbSIZRM7>; Thu, 26 Sep 2002 13:12:59 -0400
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Bill Davidsen <davidsen@tmr.com>, Bill Huey <billh@gnuppy.monkey.org>,
       Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0209221459040.20541-100000@twinlark.arctic.org>
References: <Pine.LNX.4.44.0209221459040.20541-100000@twinlark.arctic.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Sep 2002 18:21:07 +0100
Message-Id: <1033060867.1269.152.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-22 at 23:13, dean gaudet wrote:
> given that the existing code uses self-modifying-code for the safe-points
> i'm guessing there are so many safe-points that the above if statement
> would be excessive overhead (and the save/flag/wait stuff would probably
> cause a huge amount of code bloat -- but could probably be a subroutine).

It might be worth reminding people here that you cannot implement self
modifying code safely on x86 SMP systems without a lot of care. Several
common chips take a long walk off a short bus when the code they are
currently executing is modified as they execute it. Not just because of
write atomicity (which could be fixed) but because of hardware errata.

So if you are patching something that another cpu could be executing at
the same time - you already lost.

