Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbRFXMnk>; Sun, 24 Jun 2001 08:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265755AbRFXMnV>; Sun, 24 Jun 2001 08:43:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22533 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265754AbRFXMnP>; Sun, 24 Jun 2001 08:43:15 -0400
Subject: Re: replay on read-only filesystem
To: jeffchua@silk.corp.fedex.com (Jeff Chua)
Date: Sun, 24 Jun 2001 13:42:53 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0106241313470.982-100000@boston.corp.fedex.com> from "Jeff Chua" at Jun 24, 2001 01:16:46 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15E9E5-0008CX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> what's the impact of mounting reiserfs as Read-Only (specified in fstab)?
> >From syslog ...
> 
> Jun 24 01:10:30 boston kernel: Warning, log replay starting on readonly
> filesystem
> 
> Is this a problem?

In normal configurations it shouldnt be. Both ext3 and reiserfs currently
have the problem that they need to replay the log to get a stable file 
system. Obviously you cant replay the log to disk if its read only, so they
replay the log to disk read/write then mount the fixed fs read only.

It breaks if your hardware has given up writing (certain disk fails) or if
you are running the swsuspend patch (serious disk corruption) but really
the swsusp patch interaction is the only problem one
