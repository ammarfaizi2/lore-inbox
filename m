Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132985AbRAYR7V>; Thu, 25 Jan 2001 12:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132699AbRAYR7B>; Thu, 25 Jan 2001 12:59:01 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:13578 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S132577AbRAYR7A>; Thu, 25 Jan 2001 12:59:00 -0500
Date: Thu, 25 Jan 2001 13:03:56 -0500
From: Chris Mason <mason@suse.com>
To: Ondrej Sury <ondrej@globe.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre10 slowdown at boot.
Message-ID: <20130000.980445836@tiny>
In-Reply-To: <87d7dby0yi.fsf@ondrej.office.globe.cz>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, January 25, 2001 06:51:33 PM +0100 Ondrej Sury
<ondrej@globe.cz> wrote:

> Chris Mason <mason@suse.com> writes:
>> > reiserfs: checking transaction log (device 03:04) ...
>> > Warning, log replay starting on readonly filesystem
>> > 
>> 
>> Here, reiserfs is telling you that it has started replaying transactions
>> in the log.  You should also have a reiserfs message telling you how many
>> transactions it replayed, and how long it took.  Do you have that
>> message?
> 
> Nope.  I rebooted with Alt-SysRQ+B after some while (aprox more than 30
> sec, normally reiserfs replay is taking ~5 sec (pre9)).  I wasn't so
> patient.  I could test it before I'll go from work to home.
> 

Ok, depending on the metadata load before the crash, replay can take 30
seconds or more.  You usually have to try to generate that many metadata
changes, something like creating 100,000 tiny files or directories.
Compiling with CONFIG_REISERFS_CHECK turned on will give you more details
about the log replay.

Or, perhaps DMA is now off on your IDE drive, making everything slower.

Regardless, rebooting in the middle of log replay is safe.  Those
transactions will just be replayed again on the next boot.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
