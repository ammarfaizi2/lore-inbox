Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131244AbRCUJGC>; Wed, 21 Mar 2001 04:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbRCUJFv>; Wed, 21 Mar 2001 04:05:51 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:24588 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131244AbRCUJFp>;
	Wed, 21 Mar 2001 04:05:45 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: george anzinger <george@mvista.com>
cc: nigel@nrg.org, Rusty Russell <rusty@rustcorp.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.5] preemptible kernel 
In-Reply-To: Your message of "Wed, 21 Mar 2001 00:04:56 -0800."
             <3AB860A8.182A10C7@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 21 Mar 2001 20:04:57 +1100
Message-ID: <22873.985165497@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001 00:04:56 -0800, 
george anzinger <george@mvista.com> wrote:
>Exactly so.  The method does not depend on the sum of preemption being
>zip, but on each potential reader (writers take locks) passing thru a
>"sync point".  Your notion of waiting for each task to arrive
>"naturally" at schedule() would work.  It is, in fact, over kill as you
>could also add arrival at sys call exit as a (the) "sync point".  In
>fact, for module unload, isn't this the real "sync point"?  After all, a
>module can call schedule, or did I miss a usage counter somewhere?

A module can call schedule but it must do MOD_INC_USE_COUNT first.
Sleeping in module code without incrementing the module use count first
is a shooting offence.  It is so full of races that you may as well
call it Daytona.

>By the way, there is a paper on this somewhere on the web.  Anyone
>remember where?

http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf

