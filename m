Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261949AbREURtJ>; Mon, 21 May 2001 13:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261972AbREURs7>; Mon, 21 May 2001 13:48:59 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:61328 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261949AbREURsv>; Mon, 21 May 2001 13:48:51 -0400
Date: Mon, 21 May 2001 18:47:58 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew McNamara <andrewm@connect.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, tytso@valinux.com,
        linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: Ext2, fsync() and MTA's?
Message-ID: <20010521184758.B24682@redhat.com>
In-Reply-To: <E14ya9b-0004Bc-00@the-village.bc.nu> <20010512145338.0D3D6285BF@wawura.off.connect.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010512145338.0D3D6285BF@wawura.off.connect.com.au>; from andrewm@connect.com.au on Sun, May 13, 2001 at 12:53:37AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, May 13, 2001 at 12:53:37AM +1000, Andrew McNamara wrote:

> I seem to recall that in 2.2, fsync behaved like fdatasync, and that
> it's only in 2.4 that it also syncs metadata - is this correct?

No, fsync should be safe on 2.2.  There was a problem with O_SYNC not
syncing all metadata on 2.2 if you were extending a file, but that
never applied to fsync.

> Do the BSD's sync the directory data on an fsync of a file? I guess
> this is the bone of contention

No --- the old BSDs were safe because their directory operations were
fully synchronous so they *never* needed to be sync'ed manually.
According to SuS, an application relying on sync directory updates is
buggy, because SuS simply makes no such guarantees.

Just set chattr +S on the spool dir.  That's what the flag is for.
The biggest problem with that is that it propagates to subdirectories
and files --- would a version of the flag which applied only to
directories be a help here?

Cheers,
 Stephen
