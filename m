Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291049AbSBGNK3>; Thu, 7 Feb 2002 08:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291129AbSBGNKU>; Thu, 7 Feb 2002 08:10:20 -0500
Received: from pc-62-31-66-114-ed.blueyonder.co.uk ([62.31.66.114]:33921 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S291049AbSBGNKK>; Thu, 7 Feb 2002 08:10:10 -0500
Date: Thu, 7 Feb 2002 13:10:05 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andres Salomon <dilinger@mp3revolution.net>
Cc: linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: D state processes in 2.4.18-pre7-ac3
Message-ID: <20020207131005.F2227@redhat.com>
In-Reply-To: <20020207090237.GA2137@mp3revolution.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020207090237.GA2137@mp3revolution.net>; from dilinger@mp3revolution.net on Thu, Feb 07, 2002 at 04:02:37AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 07, 2002 at 04:02:37AM -0500, Andres Salomon wrote:
> Linux incandescent 2.4.18-pre7-ac3 #1 Tue Feb 5 01:00:50 EST 2002 i686 unknown
> 
> I came home today to a bunch of processes apparently hung in jbd's
> do_get_write_access(); apparently, something deadlocked, where no
> processes could write to one of my partition's journal.  That's my
> theory, anyways.  Several processes had stacks similar to:

> Trace; c011271c <sleep_on+3c/50>
> Trace; d08ecac6 <[jbd]do_get_write_access+2e6/4f0>

They are blocked waiting on the journal thread, and:

> And, kjournald had the following:
> 
> Call Trace: [<c0131f0a>] [<d08ee6e6>] [<c0112380>] [<d08f08eb>]
> [<d08f07c0>] 
>    [<c010f4e8>]
> Warning (Oops_read): Code line not seen, dumping what data is available
> 
> Trace; c0131f0a <__wait_on_buffer+6a/90>

... the journal thread is waiting for some IO to complete.  

> Not sure what caused the actual deadlock; the partition uses lvm and
> ext3, and the underlying controller uses hedrick's pdc driver.

Were you doing anything particular on the LVM at the time?  Is there
anything in the log which might indicate a failed IO?  The trace above
just indicates that IO was initialised and never completed --- it
doesn't really give us any clue WHY that IO was lost.

Cheers,
 Stephen
