Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263970AbTCWWuJ>; Sun, 23 Mar 2003 17:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263983AbTCWWuJ>; Sun, 23 Mar 2003 17:50:09 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:10437 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S263970AbTCWWuI>;
	Sun, 23 Mar 2003 17:50:08 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.20 modem control
References: <001601c2ed7c$f984e900$0201a8c0@pluto>
	<Pine.LNX.4.53.0303181404270.27869@chaos>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 20 Mar 2003 19:51:56 +0100
In-Reply-To: <Pine.LNX.4.53.0303181404270.27869@chaos>
Message-ID: <m3fzphswfn.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> The problem is when you log out! With a terminal connected,
> you get the login prompt again. This is no good if you are
> connected to a modem.

How would that happen? Even assuming the modem doesn't see DTR line
being lowered (for a short time - say, too short) while closing the
device, getty should initialize the modem correctly, i.e. lowering DTR
first for ~1 s.

> The modem will not be disconnected
> and you have to forcably disconnect at the remote end by
> disconnecting the phone line or lowering DTR with your remote
> terminal program. Then the modem will not be ready to
> answer another call. It will remain in a off-line condition
> forever.

Why? Does your modem report on/off-line status using DCD (carrier detect)
line correctly?

The shell should get HUP/disconnect after DCD drops.


BTW: there is (and always was) another issue, security-related.
Normally the user can issue "stty clocal" command which disables DCD
level detection. Thus, the /dev/ttyS* device will be owned by the user
((s)he will have an open file descriptor to the device) after the line
is disconnected. The shell will not be terminated and no getty will be
spawn.

It allows making a script simulating getty/login and ie. collecting
passwords/sessions etc.

This isn't a kernel issue - the kernel has "LOCK TERMIOS" ioctl in place,
and it's probably enough to stop this attack. The problem is no getty
uses that ioctl (it might have changed from the last time I checked,
though - but I would rather check it again if I had untrusted users).
-- 
Krzysztof Halasa
Network Administrator
