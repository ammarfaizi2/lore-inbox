Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267543AbUJNUx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267543AbUJNUx7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 16:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUJNUvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 16:51:33 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:40709 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S267543AbUJNU2E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 16:28:04 -0400
Date: Thu, 14 Oct 2004 13:26:33 -0700
To: Mark_H_Johnson@Raytheon.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
Message-ID: <20041014202633.GA17855@nietzsche.lynx.com>
References: <OF2289D554.769CEFC1-ON86256F2D.005DF70B-86256F2D.005DF791@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF2289D554.769CEFC1-ON86256F2D.005DF70B-86256F2D.005DF791@raytheon.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 12:06:22PM -0500, Mark_H_Johnson@Raytheon.com wrote:
> Not sure if I can bring this up to multi user yet. Some initial testing
> in single user mode indicates problems when I turn on networking. See
> the attached messages from /var/log/messages to see the kinds of problems
> I am having. The key ones appear after doing
>   ./S10network start
> as part of single stepping the init sequence. I stopped at this point
> to make sure I had a good record of the messages.

... 

> I also managed to get the machine stuck with
>   /sbin/reboot
> not sure why.

These are two seperate problems from my guess.

Mount the file system read/write and start slamming it with heavy disk
activity. If it locks up, then it might just as well be a problem with
the journaling code and the softirq system backing it. I ran into this
in my project and it was the softirq related IO code all of the way down
to the SCSI driver.

It was difficult to get debug messages during a deadlock and I don't
know what kind of mileage you'll get by doing this.

bill

