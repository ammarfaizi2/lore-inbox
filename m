Return-Path: <linux-kernel-owner+w=401wt.eu-S965308AbXATRhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965308AbXATRhO (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 12:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965329AbXATRhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 12:37:13 -0500
Received: from 1wt.eu ([62.212.114.60]:2077 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965308AbXATRhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 12:37:12 -0500
Date: Sat, 20 Jan 2007 18:36:44 +0100
From: Willy Tarreau <w@1wt.eu>
To: Joe Barr <joe@pjprimer.com>
Cc: Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Serial port blues
Message-ID: <20070120173644.GY24090@1wt.eu>
References: <1169242654.20402.154.camel@warthawg-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1169242654.20402.154.camel@warthawg-desktop>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 19, 2007 at 03:37:34PM -0600, Joe Barr wrote:
> 
> I'm forwarding this post by the author of a great little program for
> digital amateur radio on Linux, because I'm curious whether or not the
> problem he is seeing can be resolved outside the kernel.

At least, I see one wrong claim and one unexplored track in his report.
The wrong claim : the serial port can only be controled by the kernel.
It is totally wrong for true serial ports. If he does not want to use
ioctl(), then he can directly program the I/O port.

The unexplored track : he talked about nice -20. He did not seem to try
playing with sched_setscheduler(). I've been using this with a few programs
to get (close to) real-time responsiveness and it gives very good results.
Not sure whether it will work for his case, though, but it's easy to try,
basically, he just has to add this to the top of his program :

#include <sched.h>
...
main() {
  struct sched_param sch;

  /* see man sched_setscheduler for other options */
  sch.sched_priority = 1;
  if (sched_setscheduler(getpid(), SCHED_FIFO, &sch) == -1)
    perror("failed. Got root ?");

  /* rest of the program now running with real-time prio */
}

Now he must be careful about avoiding busy loops in the rest of the
program, or he will have to use the reset button.

> All comments welcome on/off list.
> 
> Thanks,
> Joe Barr
> K1GPL

[ rest stripped ]

Regards,
Willy

