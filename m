Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbVCCWgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVCCWgX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 17:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbVCCWen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 17:34:43 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:18165 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262699AbVCCW35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 17:29:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=c2gb4YdvQQENpFCeYDlbaltJ7ajnA60wIPepdhAMCjtic2AaJ3DDICrMFAFNbaHdEsDafGqo7jjTiH5Q7TLMWL19zfwYIMq6cxNxn5roL9yfMyfPplzL7nh67pl7qoN6WoTV5l+WpfunucfZEmrys0tUAEmN69koKak+g0KLAkE=
Message-ID: <c9ad8560050303142963fa4bb7@mail.gmail.com>
Date: Thu, 3 Mar 2005 16:29:39 -0600
From: V P <upathiyayan@gmail.com>
Reply-To: V P <upathiyayan@gmail.com>
To: linux-os@analogic.com
Subject: Re: I/O error propagation
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0503031506410.7559@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <c9ad856005030311286314ebfd@mail.gmail.com>
	 <Pine.LNX.4.61.0503031506410.7559@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree.

But what if the file systems can handle certain errors better than
what the drivers can do now ? Take for e.g., data corruption. If the
driver finds a corrupted sector that it cannot recover, it is going to
convert this specific error in to a more generic error code (-EIO) and
report it to the file system, But the file system might find it is ok
to have a block of data with few corrupted bytes (say, if the block
belongs to a large video file) rather than receive an I/O error code
with no data at all.

What I'm thinking is this: do we have to export richer error codes to
the filesystem from the driver and let the file system handle them as
it thinks appropriate ?

thanks,

On Thu, 3 Mar 2005 15:20:55 -0500 (EST), linux-os <linux-os@analogic.com> wrote:
> On Thu, 3 Mar 2005, V P wrote:
> 
> > Hi,
> >
> > I have a question on how disk errors get propagated to
> > the file systems.
> >
> >> From looking at the SCSI/IDE drivers, it looks like there
> > could be many reasons for an I/O to fail. It could be
> > bus timeout, media errors, and so on.
> >
> > Does all these errors get reported to the file system ?
> > It looks like all the different types of errors get
> > turned into a single I/O error (-EIO) and passed on to the
> > file system.
> >
> > Or is there a way where we can export better error codes
> > to the file system ?
> >
> > Any idea/input regarding this is greatly appreciated.
> >
> > Thanks.
> 
> It depends upon the disk devices, i.e., IDE SCSI, etc., but in
> general all errors reported by the hardware result in retrying
> the operation. If the retry fails after several (device dependent)
> attempts, the actual error is reported as a kernel message. These
> errors can be retrieved using the `dmesg` command and they
> will usually be retained in some kernel log in /var/log (actual
> log-name is vendor dependent).
> 
> Following the Unix convention, any errors reported back upstream,
> eventually to the user, get reported ONLY as something defined
> in /usr/include/errno.h (which includes others, ultimately
> /usr/asm/errno.h).
> 
> So, you don't need to reinvent anything. If you have hardware
> errors they will be reported in /var/log/messages (or whatever)
> and if you are making a new driver, you are expected to comply
> with the same protocol.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
>   Notice : All mail here is now cached for review by Dictator Bush.
>                   98.36% of all statistics are fiction.
>
