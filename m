Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286692AbSBGJYP>; Thu, 7 Feb 2002 04:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286750AbSBGJYG>; Thu, 7 Feb 2002 04:24:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62212 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S286692AbSBGJXx>;
	Thu, 7 Feb 2002 04:23:53 -0500
Message-ID: <3C624782.14FC8C70@zip.com.au>
Date: Thu, 07 Feb 2002 01:23:14 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andres Salomon <dilinger@mp3revolution.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: D state processes in 2.4.18-pre7-ac3
In-Reply-To: <20020207090237.GA2137@mp3revolution.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andres Salomon wrote:
> 
> Linux incandescent 2.4.18-pre7-ac3 #1 Tue Feb 5 01:00:50 EST 2002 i686 unknown
> 
> I came home today to a bunch of processes apparently hung in jbd's
> do_get_write_access(); apparently, something deadlocked, where no
> processes could write to one of my partition's journal.  That's my
> theory, anyways.  Several processes had stacks similar to:
> 
> ...
> 
> And, kjournald had the following:
> 
> Call Trace: [<c0131f0a>] [<d08ee6e6>] [<c0112380>] [<d08f08eb>]
> [<d08f07c0>]
>    [<c010f4e8>]
> Warning (Oops_read): Code line not seen, dumping what data is available
> 
> Trace; c0131f0a <__wait_on_buffer+6a/90>
> Trace; d08ee6e6 <[jbd]journal_commit_transaction+776/dd6>
> Trace; c0112380 <schedule+2c0/2f0>
> Trace; d08f08ea <[jbd]kjournald+10a/1a0>
> Trace; d08f07c0 <[jbd]commit_timeout+0/10>

This is the important part - we sent a write request down the
stack and it seems that I/O completion was never signalled.

You should check for any odd messages from the device driver
or LVM layers, if the logs made it to disk.

-
