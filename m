Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129224AbRBGVRp>; Wed, 7 Feb 2001 16:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129609AbRBGVRf>; Wed, 7 Feb 2001 16:17:35 -0500
Received: from pizda.ninka.net ([216.101.162.242]:57474 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129224AbRBGVR1>;
	Wed, 7 Feb 2001 16:17:27 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14977.47893.105950.209438@pizda.ninka.net>
Date: Wed, 7 Feb 2001 13:16:05 -0800 (PST)
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: single copy pipe/fifo
In-Reply-To: <3A81B9C8.476E66CF@colorfullife.com>
In-Reply-To: <3A81AE75.3CEF5577@colorfullife.com>
	<14977.46399.167035.94694@pizda.ninka.net>
	<3A81B9C8.476E66CF@colorfullife.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Manfred Spraul writes:
 > process 2 (on cpu 1)
 > 	read(fd,buf,64kB).
 > 	* reads the data
 > 	* now it must wake up, but it will return from the syscall, thus
 > wake_up_interruptible().

Oh, I see and thus the pre-kiovec case would be:

process 2 (on cpu 1)
	read(fd, buf,64kb)
	* reads 4K
	* wake_up_interruptible_sync()
	* sleep()
	* reads 4K

etc etc.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
