Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261914AbSLCRPo>; Tue, 3 Dec 2002 12:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbSLCRPo>; Tue, 3 Dec 2002 12:15:44 -0500
Received: from mta11n.bluewin.ch ([195.186.1.211]:37049 "EHLO
	mta11n.bluewin.ch") by vger.kernel.org with ESMTP
	id <S261914AbSLCRPm>; Tue, 3 Dec 2002 12:15:42 -0500
Date: Tue, 3 Dec 2002 18:23:10 +0100
From: Martin Buck <mb-kernel0212@gromit.dyndns.org>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Race condition in tty_flip_buffer_push/flush_to_ldisc?
Message-ID: <20021203172310.GA5373@gromit.at.home>
References: <20021203093323.GA25957@gromit.at.home> <006601c29ae5$57b28220$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006601c29ae5$57b28220$294b82ce@connecttech.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 11:02:12AM -0500, Stuart MacDonald wrote:
> What causes the DONT_FLIP bit to be un/set? I don't think your
> situation can occur under normal operation. But ICBW.

n_tty.c seems to do it in read_chan(), i.e. it will happen when the
process reading from the TTY is currently in read(2) while at the same time
new characters arrive on the serial port.

> If you search the lkml archive, recently Ted stated that it's
> acceptable to call the line discpline's receive_buf() routine
> directly, bypassing the flip buffers.

Interesting, that should solve my problem. But then the next question is:
What's the use of the DONT_FLIP bit if it's legal to bypass it by calling
receive_buf() directly?

Also, if somebody enables low_latency using setserial with the standard
serial driver, he can still trigger the race condition. It's not very
likely to happen, but it does happen - I added code to flush_to_ldisc() to
detect concurrent calls and it triggered once during an over-night test.

Thanks,
Martin

