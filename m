Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265964AbRGAWrY>; Sun, 1 Jul 2001 18:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265966AbRGAWrO>; Sun, 1 Jul 2001 18:47:14 -0400
Received: from elin.scali.no ([195.139.250.10]:2569 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S265964AbRGAWrD>;
	Sun, 1 Jul 2001 18:47:03 -0400
Message-ID: <3B3FA814.95670F59@scali.no>
Date: Mon, 02 Jul 2001 00:45:40 +0200
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Router problems with transparent proxy
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think I've triggered a bug in the ipchains/iptables part of the kernel. Here is the
story :

The server was a 866MHz PIII with 384 MByte of RAM running RH7.1 with a 2.4.5-ac21 kernel.
It was used as a router/firewall with 2 netcards (not sure which type, but I don't think
that's important). Using this machine as a plain router was no problem at all, and serving
a class C net onto a 3 MBit line was a just a walk in the park, the machine was idle for
most of the time. Then we decided to set up transparent proxy and used a pretty standard
setup redirecting all port 80 accesses with ipchains to squid. Things worked fine for a
while (about 2 hrs) until we noticed that the machine got extremly unresponsive on the
console. A 'top' session showed us that the machine was almost a 100% in system time. If
we disconnected the some of the segments on the C net, system time went down a bit. We
rebooted the machine and noticed that the system time started at zero and went slowly
upwards until it reached 100 (after about 2hrs) and we just needed to reboot again. We
just disabled the ipchains stuff, and now the server is rock solid with a 'normal' proxy
setup (and 100% idle almost all the time). Just for the record : We also tried standard
RH7.1 kernels (2.4.2-2 and 2.4.3) with the same results.

Any ideas ? Anybody experienced similar behaviour ? It looks like a resource leak
somewhere in the IP filter code to me.

Regards,
-- 
  Steffen Persvold               Systems Engineer
  Email : mailto:sp@scali.no     Scali AS (http://www.scali.com)
  Tlf   : (+47) 22 62 89 50      Olaf Helsets vei 6
  Fax   : (+47) 22 62 89 51      N-0621 Oslo, Norway
