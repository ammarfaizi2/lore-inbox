Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131123AbRA1PQA>; Sun, 28 Jan 2001 10:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131156AbRA1PPv>; Sun, 28 Jan 2001 10:15:51 -0500
Received: from smtp3.libero.it ([193.70.192.53]:60568 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S131123AbRA1PPe>;
	Sun, 28 Jan 2001 10:15:34 -0500
Message-ID: <3A743766.98DACE29@alsa-project.org>
Date: Sun, 28 Jan 2001 16:14:46 +0100
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre6 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Subject: Re: patch for 2.4.0 disable printk and panic messages, third try
In-Reply-To: <01012815533500.01191@deepthought.seibold.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefani Seibold wrote:
> 
> Hi guys,
> 
> this is now the third try to release my patch for disabling all kernel
> messages. It is usefull on deep embedded systems with no human interactions
> and for rescue discs where the diskspace is always to less.
> 
> This patch has now the following features:
> 
> The macro printk throws away all parameters and calls now a funciton "inline
> int printk_inline(void)" which always return 0 integer. So it should be now
> compatibel to the original printk funciton.
> 

Then I suppose that you've checked that never in kernel printk arguments
have side effects, don't you ;-)

printk("%d", p());
printk("%d", a++);
etc.

You're changing semantics of a well known function and also if you don't
broke anything now, what grants this for the future?

You need also a big warning in printk documentation: "Note that
arguments may to be not evaluated" and hope everybody note it.

I'd prefer to rely on modern compiler smartness.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project is            http://www.alsa-project.org
sponsored by SuSE Linux    http://www.suse.com

It sounds good!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
