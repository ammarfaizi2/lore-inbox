Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267809AbTBROA6>; Tue, 18 Feb 2003 09:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267811AbTBROA6>; Tue, 18 Feb 2003 09:00:58 -0500
Received: from nimbus19.internetters.co.uk ([209.61.216.65]:53167 "HELO
	nimbus19.internetters.co.uk") by vger.kernel.org with SMTP
	id <S267809AbTBROA5>; Tue, 18 Feb 2003 09:00:57 -0500
Subject: Re: Help !! calling function in module from a user program
From: Alex Bennee <kernel-hacker@bennee.com>
To: Srinivas Chinta <chintasrinivas_tech@yahoo.com>
Cc: Sudharsan Vijayaraghavan <svijayar@cisco.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030218134315.91052.qmail@web21206.mail.yahoo.com>
References: <20030218134315.91052.qmail@web21206.mail.yahoo.com>
Content-Type: text/plain
Organization: Hackers Inc
Message-Id: <1045577057.2506.122.camel@cambridge.braddahead>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1-1mdk 
Date: 18 Feb 2003 14:04:17 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-18 at 13:43, Srinivas Chinta wrote:
> Hi,
> One way of doing this is , by hooking up your function
> inside the module as a system call.
> Here i'm sending two files, module.c and user_space.c.
> first do "insmod module.o" and then run
> "./user_space".
> As i'm also a newbee, i'm not aware of the
> disadvantages of this approach.

The main disadvantage is your driver/module becomes a specialized device
that can only be accessed by special syscall incantaion by one
application. The Un*x way is about keeping every thing as standard as
possible so there is easy interaction between user-mode programs
accessing the device even if they don't know the details of the
internals.

Most devices can be treated as char devices or block devices and are
coded as such. This way you can dump the contents of your hard-drive by
doing "cat /dev/hda1 > dump" without cat having intimate knowledge of
what a hard drive is and how to access one.

Of course there will always be times when new system calls need to be
added but generally this should be done sparinginly.

-- 
Alex, homepage: http://www.bennee.com/~alex/

He missed an invaluable opportunity to hold his tongue.
		-- Andrew Lang

