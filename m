Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136581AbRATHHo>; Sat, 20 Jan 2001 02:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136768AbRATHHe>; Sat, 20 Jan 2001 02:07:34 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:33550
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S136581AbRATHHa>; Sat, 20 Jan 2001 02:07:30 -0500
Date: Sat, 20 Jan 2001 20:07:27 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Michael Lindner <mikel@att.net>
Cc: Dan Maas <dmaas@dcine.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data available
Message-ID: <20010120200727.A1069@metastasis.f00f.org>
In-Reply-To: <fa.nc2eokv.1dj8r80@ifi.uio.no> <fa.dcei62v.1s5scos@ifi.uio.no> <015e01c082ac$4bf9c5e0$0701a8c0@morph> <3A69361F.EBBE76AA@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A69361F.EBBE76AA@att.net>; from mikel@att.net on Sat, Jan 20, 2001 at 01:54:23AM -0500
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 20, 2001 at 01:54:23AM -0500, Michael Lindner wrote:

    You know, there's one other possibility, and that's if the data that is
    being sent isn't actually arriving until the next clock tick, which
    means the delay is in the appearance of sent data, not in select().
    Given that the two processes are on the same machine, I would expect a
    send() on a TCP socket to deliver the data to its destination faster
    than that, however.

You can measure this latency; and it's indeed very low (lmbench gives
28 usecs on one of my machines).

If process A blocks waiting for data, and process B sleeps after
writing this data intended to wake process A, it should wake almost
immediately.

If you don't see this I would suspect an application bug -- can you
use strace or some such and confirm this is not the case?




  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
