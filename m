Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287134AbRL2FCc>; Sat, 29 Dec 2001 00:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287137AbRL2FCW>; Sat, 29 Dec 2001 00:02:22 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:22025 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287134AbRL2FCQ>; Sat, 29 Dec 2001 00:02:16 -0500
Message-ID: <3C2D4DA5.E688FF43@zip.com.au>
Date: Fri, 28 Dec 2001 20:59:17 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Fwd: Hard Lockup on 2.4.16 with Via ieee1394 (sbp2 mode)
In-Reply-To: <200112290321.fBT3GCSs007627@svr3.applink.net> <3C2D3DBB.6ADE1CC5@zip.com.au>,
		<3C2D3DBB.6ADE1CC5@zip.com.au>; from akpm@zip.com.au on Fri, Dec 28, 2001 at 07:51:23PM -0800 <20011228204041.A14736@one-eyed-alien.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dharm wrote:
> 
> Hrm...
> 
> Does this apply to usb-storage also?  Under what conditions do you need to
> hold the io_request_lock when calling the done function?
> 

That's scsi_old_done().  I don't think scsi_done() cares whether
io_request_lock is held or not.

And io_request_lock *must* be held by the caller of scsi_old_done() - it
assumes this.   I think we'd have heard by now if usb was getting this
wrong.  Looks like it's using scsi_done(), yes?

-
