Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbWACS4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbWACS4r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 13:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWACS4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 13:56:47 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:24315 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932486AbWACS4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 13:56:46 -0500
Subject: Re: 2.6.15-rt1
From: Steven Rostedt <rostedt@goodmis.org>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1136313652.6039.171.camel@localhost.localdomain>
References: <20060103094720.GA16497@elte.hu>
	 <20060103153317.26a512fa@mango.fruits.de>
	 <20060103161356.4e1b47e0@mango.fruits.de>
	 <1136313652.6039.171.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 13:56:40 -0500
Message-Id: <1136314600.6039.174.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 13:40 -0500, Steven Rostedt wrote:

[...]

> Ingo,  I guess we have a problem.  There must be a reason not to hold
> the rtc_lock and call the {add,mod,del}_timer functions, but your change
> only makes the race condition less likely to happen, and not prevent it.
> The attached program run on an SMP machine will eventually trigger the
> race. 
> 
> $ gcc -o rtc_ioctl rtc_ioctl.c -lpthread
> $ while : ; do ./rtc_ioctl ; done

[...]

> Should we create another lock to protect only the {add,mod,del}_timer?
> Like the following patch?

Well, with the patch, the above program has been running for over ten
minutes without the race occurring.  Without the patch, the race happens
in about one minute or less.

-- Steve



