Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291332AbSBMEBj>; Tue, 12 Feb 2002 23:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291335AbSBMEBa>; Tue, 12 Feb 2002 23:01:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45071 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291332AbSBMEBN>;
	Tue, 12 Feb 2002 23:01:13 -0500
Message-ID: <3C69E506.5DBE50A@mandrakesoft.com>
Date: Tue, 12 Feb 2002 23:01:10 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <Pine.LNX.3.96.1020212224341.8017C-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
> Alan and/or Linus:
> 
>   Am I misreading this or is the Linux implementation of sync() based on
> making the shutdown scripts pause until disk i/o is done? Because I don't
> think commercial unices work that way, I think they work as SuS
> specifies. More reason to rethink this in 2.4 as well as 2.5 and get the
> possible live lock out of the kernel.



I don't think SuSv2 can be any more clear than:

> The writing, although scheduled, is not necessarily complete
> upon return from sync().

Quoting from http://www.opengroup.org/onlinepubs/007908799/xsh/sync.html

As I mentioned in the other message, IMHO we need some way to introduce
a global system I/O barrier, and then wait for all I/O scheduled before
that barrier to complete.  My suggestion for naming was the "checkpoint"
system call.

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
