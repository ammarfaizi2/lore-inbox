Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130149AbQLDOQj>; Mon, 4 Dec 2000 09:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130252AbQLDOQ3>; Mon, 4 Dec 2000 09:16:29 -0500
Received: from ife.ee.ethz.ch ([129.132.29.2]:20371 "EHLO ife.ee.ethz.ch")
	by vger.kernel.org with ESMTP id <S130149AbQLDOQT>;
	Mon, 4 Dec 2000 09:16:19 -0500
Message-ID: <3A2BA005.F85423F6@ife.ee.ethz.ch>
Date: Mon, 04 Dec 2000 14:45:41 +0100
From: Thomas Sailer <sailer@ife.ee.ethz.ch>
Organization: IfE
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: de,fr,ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Pavel Machek <pavel@suse.cz>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i810_audio 2.4.0-test11
In-Reply-To: <E142tvc-0003je-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> Definitely we should

If you start killing format conversion then >99% of the
existing applications won't work anymore with usbaudio.
At that point you can dump the OSS interface just as well.

And before killing format conversion you should kill
the mmap stunt, because the format conversion complexity
(~25 LOC) is by far dwarfed by the mmap emulation stuff.

The underlying question is:

- do we want an usb audio driver that supports the OSS
  interface and with which most existing applications work

- or do we want a simple driver with its own non-OSS
  interface.

Anything in between is IMO silly. Killing the format
conversion drops the advantage of running many existing
applications but don't bring you much closer to the goal
of simplicity.

Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
