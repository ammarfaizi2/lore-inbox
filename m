Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269104AbRGaAVi>; Mon, 30 Jul 2001 20:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269113AbRGaAV2>; Mon, 30 Jul 2001 20:21:28 -0400
Received: from mail.zmailer.org ([194.252.70.162]:10515 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S269104AbRGaAVM>;
	Mon, 30 Jul 2001 20:21:12 -0400
Date: Tue, 31 Jul 2001 03:21:04 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010731032104.O2650@mea-ext.zmailer.org>
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <20010726130809.D17244@emma1.emma.line.org> <3B60022D.C397D80E@zip.com.au> <20010726143002.E17244@emma1.emma.line.org> <9jpea7$s25$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9jpea7$s25$1@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jul 26, 2001 at 03:51:35PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, Jul 26, 2001 at 03:51:35PM +0000, Linus Torvalds wrote:
> To:	linux-kernel@vger.kernel.org
> From:	torvalds@transmeta.com (Linus Torvalds)
> Subject: Re: ext3-2.4-0.9.4
> Date:	Thu, 26 Jul 2001 15:51:35 +0000 (UTC)
....
> Use fsync() on the directory. 
> 
> Logical, isn't it?

  No.  I don't see why I should opendir() a directory, fsync()
that handle, and closedir() the handle.  I would definitely prefer:

       lsync(dirpath)

This could, even, behave like  lstat()  with the path: if the last name
segment is symlink, the sync is done on the i-node data of symlink, not
on what it (possibly) points to.

I didn't check if POSIX folks have thought of that.

> 		Linus

/Matti Aarnio
