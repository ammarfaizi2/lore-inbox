Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVBVSpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVBVSpS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 13:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVBVSpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 13:45:18 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:30704 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261275AbVBVSpL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 13:45:11 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6: USB Storage hangs machine on bootup for ~2 minutes
Date: Tue, 22 Feb 2005 13:44:58 -0500
User-Agent: KMail/1.7.92
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0502071115130.2261-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0502071115130.2261-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502221344.58420.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 February 2005 11:18 am, Alan Stern wrote:
> > I am already running 2.6.11-rc3 and the problem has not gone away. Are
> > there any relevant fixes in -bk?
>
> No.
>
> > Attached is the bootup log after enabling CONFIG_USB_STORAGE_DEBUG.
>
> You said that the system hangs during bootup.  Where in the log does that
> hang occur?  The log itself looks perfectly normal.  The Maxtor drive is
> scanned, the partitions detected, and then apparently one or two
> partitions are mounted.  There's no indication of any problem.

I have tracked down the reason for this hang  - it seems that kudzu gets stuck 
in D state on usb_device_read - Below SysRQ+T from 2.6.11-rc4 - always 
reproducible.

kudzu         D 00000000ffffffff     0  4424   4472                     
(NOTLB)
ffff81002bebfd98 0000000000000086 ffff81002c538150 ffff81002f21d00e
       000000078847ce40 ffff81002b5977c0 000000000000fd38 ffffffff803defc0
       ffff81002bebfd88 ffffffff80219b32
Call Trace:
<ffffffff80219b32>{_atomic_dec_and_lock+290} <ffffffff80383835>{__down+421}
       <ffffffff80133e30>{default_wake_function+0} 
<ffffffff803868ae>{__down_failed+53}
       <ffffffff802db9f1>{.text.lock.usb+5} 
<ffffffff802edb35>{usb_device_read+229}
       <ffffffff801998d1>{vfs_read+225} <ffffffff80199bd0>{sys_read+80}
       <ffffffff8010ed1e>{system_call+126}

Thereafter, if I try to mount the USB drive, even mount gets stuck.

Parag
