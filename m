Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288781AbSBGQ3h>; Thu, 7 Feb 2002 11:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288810AbSBGQ30>; Thu, 7 Feb 2002 11:29:26 -0500
Received: from [202.172.46.73] ([202.172.46.73]:55058 "HELO mail.celestix.com")
	by vger.kernel.org with SMTP id <S288781AbSBGQ3N>;
	Thu, 7 Feb 2002 11:29:13 -0500
Date: Thu, 7 Feb 2002 23:56:03 +0800
From: Thibaut Laurent <thibaut@celestix.com>
To: Michael Cohen <lkml@ohdarn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] 2.4.18-pre8-mjc
Message-Id: <20020207235603.4ea1ba49.thibaut@celestix.com>
In-Reply-To: <1013073474.3684.3.camel@ohdarn.net>
In-Reply-To: <1013073474.3684.3.camel@ohdarn.net>
Organization: Celestix Networks Pte Ltd
X-Mailer: Sylpheed version 0.7.0claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Feb 2002 04:17:54 -0500
Michael Cohen <lkml@ohdarn.net> wrote:

 | Volatile xtime				(MV)

The change in include/sched.h seems to miss its counter-part in kernel/timer.c, hence a type mismatch leading to a compilation failure.

--- linux/kernel/timer.c	Thu Feb  7 23:44:00 2002
+++ linux/kernel/timer.c~	Thu Feb  7 23:27:47 2002
@@ -34,7 +34,7 @@
 long tick = (1000000 + HZ/2) / HZ;	/* timer interrupt period */
 
 /* The current time */
-struct timeval xtime __attribute__ ((aligned (16)));
+volatile struct timeval xtime __attribute__ ((aligned (16)));
 
 /* Don't completely fail for HZ > 500.  */
 int tickadj = 500/HZ ? : 1;		/* microsecs */


Regards,
Thibaut

