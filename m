Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131035AbQLGT7C>; Thu, 7 Dec 2000 14:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131026AbQLGT6m>; Thu, 7 Dec 2000 14:58:42 -0500
Received: from hera.cwi.nl ([192.16.191.1]:50371 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131023AbQLGT6k>;
	Thu, 7 Dec 2000 14:58:40 -0500
Date: Thu, 7 Dec 2000 20:28:09 +0100
From: Andries Brouwer <aeb@veritas.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test9 Root no longer permitted to format floppies?
Message-ID: <20001207202809.A24021@veritas.com>
In-Reply-To: <Pine.LNX.3.95.1001207114503.171A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.3.95.1001207114503.171A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Thu, Dec 07, 2000 at 11:54:38AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2000 at 11:54:38AM -0500, Richard B. Johnson wrote:

> # fdformat /dev/fd0h1440
> Double-sided, 80 tracks, 18 sec/track. Total capacity 1440 kB.
> Formatting ... 
> ioctl(FDFMTBEG): Operation not permitted

Probably an old fdformat?
Try a recent util-linux.


[I forgot the details - people will correct me -
Old situation: a special kludge in floppy.c allows ioctls,
including formatting, on a fd opened without read or write
permission. And the old fdformat did just that.
Some cleanup removed the kludge, and fdformat had to open
the fd for writing. So the util-linux fdformat was updated.
Later Alain Knaff said that the old kludge remained necessary,
because one might wish to use ioctl's on write protected floppies.
Maybe the change was partially reverted, I have not checked.]

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
