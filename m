Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282555AbRKZVON>; Mon, 26 Nov 2001 16:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282556AbRKZVOC>; Mon, 26 Nov 2001 16:14:02 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:64009 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S282555AbRKZVNy> convert rfc822-to-8bit; Mon, 26 Nov 2001 16:13:54 -0500
From: Steve Brueggeman <xioborg@yahoo.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Date: Mon, 26 Nov 2001 15:14:06 -0600
Message-ID: <b0b50u0s566g9fusmrfs275lsjvr0dd0hu@4ax.com>
In-Reply-To: <k1t40uciislnibv9927hekv82ejgu3eahb@4ax.com> <Pine.LNX.4.10.10111261232140.8817-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10111261232140.8817-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, since you don't clearify what part you object to, I'll have to
assume that you object to my statement that the disk drive will not
auto-reallocate when it cannot recover the data.

If you think that a disk drive should auto-reallocate a sector (ARRE
enabled in the mode pages) that it cannot recover the original data
from, than you can dream on.  I seriously hope this is not what you're
recommending for ATA.  If a disk drive were to auto-reallocate a
sector that it couldn't get valid data from, you'd have serious
corruptions probelms!!!  Tell me, what data should exist in the sector
that gets reallocated if it cannot retrieve the data the system
believes to be there???  If the reallocated sector has random data,
and the next read to it doesn't return an error, than the system will
get no indication that it should not be using that data.

If the unrecoverable error happens durring a write, the disk drive
still has the data in the buffer, so auto-reallocation on writes (AWRE
enabled in the mode pages), is usually OK

That said, it'd be my bet that most disk drives still have a window of
opportunity durring the reallocation operation, where if the drive
lost power, they'd end up doing bad things.

You can force a reallocation, but the data you get when you first read
that unreadable reallocated sector is usually undefined, and often is
the data pattern written when the drive was low-level formatted.

That IS what is done, my knowledge is also first hand.

I have no descrepency with your description of how spare sectors are
dolled out.

Steve Brueggeman


On Mon, 26 Nov 2001 12:36:02 -0800 (PST), you wrote:

>
>Steve,
>
>Dream on fellow, it is SOP that upon media failure the device logs the
>failure and does an internal re-allocation in the slip-sector stream.
>If the media is out of slip-sectors then it does an out-of-bounds
>re-allocation.  Once the total number of out-of-bounds sectors are gone
>you need to deal with getting new media or exectute a seek and purge
>operation; however, if the badblock list is full you are toast.
>
>That is what is done - knowledge is first hand.
>
>Regards,
>
>Andre Hedrick
>CEO/President, LAD Storage Consulting Group
>Linux ATA Development
>Linux Disk Certification Project
>
>On Mon, 26 Nov 2001, Steve Brueggeman wrote:


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

