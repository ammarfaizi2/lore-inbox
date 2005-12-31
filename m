Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVLaUIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVLaUIG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 15:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVLaUIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 15:08:06 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:32024 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932316AbVLaUIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 15:08:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=i9UnljwMWekIULaDXMo705nvcfkksZMVVhEbVcVVBTe1QXw1Ytakax2V0yBAMlKgsT+fnRAyC53l0Dn5pl4IvXJkyEabVdHfRGUAxNW6f2zvaYSAqhT/7E/lpC0Pi+HvhnING6j6HZCdeqvdrCuF/ThqWawjROfOuCAsG0HlfZY=
Date: Sat, 31 Dec 2005 22:07:58 +0200
From: Bradley Reed <bradreed1@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
Subject: Re: MPlayer broken under 2.6.15-rc7-rt1?
Message-ID: <20051231220758.56b3e096@galactus.example.org>
In-Reply-To: <1136058696.6039.133.camel@localhost.localdomain>
References: <20051231202933.4f48acab@galactus.example.org>
	<1136058696.6039.133.camel@localhost.localdomain>
X-Mailer: Sylpheed-Claws 1.9.100cvs108 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve,

Perhaps I'm doing something wrong, but it doesn't seem to apply cleanly
here:

patching file drivers/char/rtc.c
Hunk #1 succeeded at 384 with fuzz 2.
Hunk #2 FAILED at 396.
Hunk #3 FAILED at 417.
Hunk #4 FAILED at 582.
Hunk #5 FAILED at 605.
Hunk #6 FAILED at 900.
Hunk #7 FAILED at 918.
Hunk #8 FAILED at 999.
Hunk #9 FAILED at 1018.
Hunk #10 FAILED at 1285.
Hunk #11 FAILED at 1294.
Hunk #12 FAILED at 1304.
11 out of 12 hunks FAILED -- saving rejects to file drivers/char/rtc.c.rej

Brad


On Sat, 31 Dec 2005 14:51:36 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:


> Hey guys (Ingo, Thomas and John), second person with the rtc bug.
> 
> Bradley and Jan, try the below patch and see if it doesn't deadlock
> the system. I'm not sure why they pulled out the mod_timer add_timer
> and del_timer from the rtc_lock, but there might be a call back to it.
> 
> -- Steve
> 
> Index: linux-2.6.15-rc7-rt1/drivers/char/rtc.c
> ===================================================================
> --- linux-2.6.15-rc7-rt1.orig/drivers/char/rtc.c	2005-12-28
