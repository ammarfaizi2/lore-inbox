Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268929AbRHFTCy>; Mon, 6 Aug 2001 15:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268932AbRHFTCg>; Mon, 6 Aug 2001 15:02:36 -0400
Received: from [203.12.97.41] ([203.12.97.41]:45585 "EHLO vasquez.zip.com.au")
	by vger.kernel.org with ESMTP id <S268929AbRHFTC0>;
	Mon, 6 Aug 2001 15:02:26 -0400
Message-ID: <3B6EEB04.D75CF1B6@zip.com.au>
Date: Mon, 06 Aug 2001 12:07:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steve Kieu <haiquy@yahoo.com>
CC: kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.7-ac7 ext3: Can I remount and change mount option ?
In-Reply-To: <20010806062455.44858.qmail@web10406.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Kieu wrote:
> 
> Hi,
> 
> I still can not remount my ext3 root partition to
> change to the data=writeback mode using 2.4.7-ac7 .
> And any other partition too.

This is not possible - you must unmount to change the
data journalling mode.

> >From alan post...
> 
> Don't refuse unneccessarily on remount with     (Petr
> Vandrovec)
>                               data= option with ext3
> 
> it means that I can do a remount an already mounted
> ext3 FS and change the data mode?

No, this refers to a problem where
	mount foo -o data=journal
would succeed, but then
	mount foo -o remount,data=journal
would fail.  We now allow remount to specify the journalling
mode, but it must be the same as the current mode - this change
is just to allow us to work more nicely with the mount tools.

-
