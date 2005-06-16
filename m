Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVFPMpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVFPMpm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 08:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVFPMpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 08:45:42 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:61022 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261664AbVFPMpc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 08:45:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ue6OhMp+oDAefgv7Ny1cs9NC3j83kY4kBQcO5l94fANgK0YfVSioaA+3TSFbWJ6XvQlEoQfr5+S97lu7lGilk/Kk0/khDKkef9jJIYhQmFhm1Hpl51U0tsdlC0XiU1hisruXMduw87YLBqhZRfwGKT0Iqi0HKA4L9fgr9wIA3+0=
Message-ID: <4ad99e0505061605452e663a1e@mail.gmail.com>
Date: Thu, 16 Jun 2005 14:45:30 +0200
From: Lars Roland <lroland@gmail.com>
Reply-To: Lars Roland <lroland@gmail.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I am testing kernel 2.6.12-rc6 on a 6 IBM 335 servers. The NICs are
gigabit broadcom. If I use the tg3 driver then each of the servers are
unable to communicate with a Cisco PIX  using SMTP fixup, the
connection simply get cut:

-------------
telnet xx.x.xx.xx 25
Trying xx.x.xxx.xx...
Connected to xx.x.xxx.xx.
Escape character is '^]'.
mail to: <test@test.com>
Connection closed by foreign host.
-------------

Using tcpdump does not give me any clue as to what goes wrong, the
connection is simply lost so I am suspecting some kind of TX/RX mess
up. If I instead use the tg3 driver in kernel 2.6.8.1 (or the official
broadcom bcm5700 driver (version 8.1.55) with kernel 2.6.12-rc6) then
I get:

-------------
telnet xx.x.xxx.xx 25
Trying xx.x.xxx.xx...
Connected to xx.x.xxx.xx.
Escape character is '^]'.
220 ***************
mail to: <test@test.com>
250 ok
quit
221 test.com
Connection closed by foreign host.
-------------

So are there any differences in the tg3 driver between 2.6.8.1 and
2.6.12-rc6 that would cause this kind of behaviour ?.

I know that SMTP fixup is mostly a poorly implemented Sendmail
security fix left over from the pre ESMTP era that cripples SMTP
connectivity without offering any real
security advantages. So the best thing would be to turn it off, but
given that I do not control the firewall and the admin refuses to
change it because he believes it to be a security risk then I am
looking for another solution (still hoping that it is not shifting
NICs in all my servers).


Regards.

Lars Roland
