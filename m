Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVKUJTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVKUJTQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 04:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbVKUJTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 04:19:16 -0500
Received: from xm.freeshell.ORG ([192.94.73.22]:52209 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S932226AbVKUJTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 04:19:16 -0500
From: Jim Nance <jlnance@sdf.lonestar.org>
Date: Mon, 21 Nov 2005 09:18:37 +0000
To: Arijit Das <Arijit.Das@synopsys.com>
Cc: 7eggert@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: Does Linux has File Stream mapping support...?
Message-ID: <20051121091837.GA2619@SDF.LONESTAR.ORG>
References: <7EC22963812B4F40AE780CF2F140AFE920906A@IN01WEMBX1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7EC22963812B4F40AE780CF2F140AFE920906A@IN01WEMBX1.internal.synopsys.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 06:21:59PM +0530, Arijit Das wrote:
> Ye...I know of tee.
> 
> But the issue here is I have a HUGE Compiler (an Simulation tool)
> in which thousands of places there are "printf" statements to print
> messages to STDOUT stream. Now, a requirement came up which needs
> all those messages thrown to STDOUT also to be logged in a LOGFILE
> (in addition to STDOUT). Yes, this can be done through tee...but
> the usage model of the compiler doesn't leave that possibility open
> for me.

You have the source code for the compiler?  Put a call to something
like this at the beginning of main().  I'm leaving out the error handling,
you can write that ;)

void startlogging()
{
    pid_t tpid;
    int pfd[2];
    pipe(pfd);

    tpid=fork();
    if(tpid==0) {
        /* child process */
	close(0);
	dup2(pfd[0], 0);
	close(pfd[0]);
	close(pfd[1]);
	execl("/usr/bin/tee", "logfile");
    } else {
	close(1);
	dup2(pfd[1], 1);
	close(pfd[0]);
	close(pfd[1]);
    }
}

-- 
jlnance@sdf.lonestar.org
SDF Public Access UNIX System - http://sdf.lonestar.org
