Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129148AbQKFTe0>; Mon, 6 Nov 2000 14:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129690AbQKFTeH>; Mon, 6 Nov 2000 14:34:07 -0500
Received: from slc510.modem.xmission.com ([166.70.7.2]:51973 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129148AbQKFTd5>; Mon, 6 Nov 2000 14:33:57 -0500
To: David Woodhouse <dwmw2@infradead.org>
Cc: Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <Pine.LNX.4.21.0011060800490.15143-100000@imladris.demon.co.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Nov 2000 11:09:41 -0700
In-Reply-To: David Woodhouse's message of "Mon, 6 Nov 2000 08:02:53 +0000 (GMT)"
Message-ID: <m11ywpezve.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> writes:

> The current situation is equivalent to stopping forwarding packets each
> time an app on the local machine decides it wants to send its own packets,
> after a period of inactivity.
> 
> Defaulting to zero on boot is fine. Defaulting to zero after the module
> has been auto-unloaded and auto-loaded again is less good.

Well we don't have auto unload.
And module persistent data for the second load case causes chaos with 
the goal of having exactly the same code in modules and compiled in
kernel code.

It would probably be better (in this case) to increment the module count
when the mixer settings go above 0, and decrement it when the settings 
go totally to 0.  This prevents an unwanted unload.

But for reliability and code simplicity there does not yet seem to
be a case for persistent module storage.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
