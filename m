Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261590AbSIXHGo>; Tue, 24 Sep 2002 03:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261591AbSIXHGo>; Tue, 24 Sep 2002 03:06:44 -0400
Received: from khms.westfalen.de ([62.153.201.243]:6803 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S261590AbSIXHGm>; Tue, 24 Sep 2002 03:06:42 -0400
Date: 24 Sep 2002 08:51:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Message-ID: <8XSRl9U1w-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.33.0209231154520.3512-100000@penguin.transmeta.com>
Subject: Re: [PATCH] nanosecond resolution for stat(2)
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <Pine.LNX.4.33.0209231154520.3512-100000@penguin.transmeta.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 23.09.02 in <Pine.LNX.4.33.0209231154520.3512-100000@penguin.transmeta.com>:

> On Mon, 23 Sep 2002, Andi Kleen wrote:
> >
> > Some drivers (like mouse drivers or tty) do dubious inode [mac] time
> > accesses of the on disk inode and without even marking it dirty. This is
> > likely a bug.
>
> No, it is intentional. At least some versions of "w" (maybe all) will use
> the tty access times to judge how long the tty has been idle. The point is
> that this is all information that is interesting (and useful), but not
> worth sending to disk - it is useful only as long as the inode remains
> locked in-core for other reasons, ie being in use.
>
> (It's not only "not worth it" to send to disk, but it would be positively
> wrong to even _try_ updating the disk with the access times, since we want
> these things to work even with a read-only /dev).

Should there perhaps be a special function for this - say  
device_atime_update_nowrite() or something like that, to make it clearer  
what happens? You could put something like you just wrote as a comment  
before that function ...

MfG Kai
