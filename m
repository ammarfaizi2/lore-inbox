Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263389AbREXGiP>; Thu, 24 May 2001 02:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263390AbREXGiG>; Thu, 24 May 2001 02:38:06 -0400
Received: from web11607.mail.yahoo.com ([216.136.172.59]:30474 "HELO
	web11607.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263389AbREXGhz>; Thu, 24 May 2001 02:37:55 -0400
Message-ID: <20010524063754.5547.qmail@web11607.mail.yahoo.com>
Date: Wed, 23 May 2001 23:37:54 -0700 (PDT)
From: John Lenton <jlenton@yahoo.com>
Subject: how to crash 2.4.4 w/SBLive
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found to my dismay that it's extremely easy to crash 2.4.4 if
it has a Live! in it. I have no way of getting at the oops, but
somebody out there probably has both this soundcard and a serial
console (or somethin').
I present it in the form of a script, but you'll probably have
no problem realizing where the problem is. The number of
"writers" never gets past 64. I guess the 65th should probably
get the same as the 2nd writer does on other cards...

As usual, let me know if this is useless without the lspci
--more-magic thing.

Cheers,
j.

----
#!/bin/sh

setup () {
	dd bs=1M count=10 </dev/urandom >/tmp/noise 2> /dev/null
}

noise () {
	cat /tmp/noise > /dev/dsp &
}

setup
i=0
while (noise); do
	i=$(( $i+1 ))
	echo $i
done
----


__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
