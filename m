Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263473AbTDGPyk (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 11:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263503AbTDGPyk (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 11:54:40 -0400
Received: from riptidesoftware.com ([66.147.50.178]:7882 "EHLO
	ns1.riptidesoftware.com") by vger.kernel.org with ESMTP
	id S263473AbTDGPyh (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 11:54:37 -0400
Message-ID: <3E91A1E2.2070301@riptidesoftware.com>
Date: Mon, 07 Apr 2003 12:05:54 -0400
From: Christopher Curtis <chris.curtis@riptidesoftware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.3) Gecko/20030319 Debian/1.3-3
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Giger <gigerstyle@gmx.ch>
CC: Javier Achirica <achirica@telefonica.net>, linux-kernel@vger.kernel.org
Subject: OOPS in airo driver, 2.4 serial, skbuff.c: 315
References: <3E8E0B9B.5010805@riptidesoftware.com> <20030405115718.3db2d65f.gigerstyle@gmx.ch>
In-Reply-To: <20030405115718.3db2d65f.gigerstyle@gmx.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Giger wrote:
> On Fri, 04 Apr 2003 17:47:55 -0500
> Christopher Curtis <chris.curtis@riptidesoftware.com> wrote:
>> > I use a cisco pcmcia aironet card.
>> > kernel: kernel BUG at skbuff.c:315!
>>
>>I have the same problem with 2.4.21-pre5; do you know of a patch?
> 
> Yep, look @ http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/airo-linux/airo-linux/kernel/
> This driver is fixed but I still have the same problem...it just takes a little more time until it shows up...
> IMPORTANT: Please report bugs to Javier Achirica <achirica@telefonica.net> AND to the lkml linux-kernel@vger.kernel.org!

Hello all,

I had been running a 2.4.19 kernel with the same configuration without 
any problems.  I was told that I had to cut the TxPower from 100mW to 
20mW and found that this could only be done in the prepatches for the 
2.4.x series, so I upgraded to the latest 2.4.21-pre5 kernel.  I had 
been using the card without any problems using apt-get.  Then I tried 
connecting to the machine using VNC.  The system would OOPS in under a 
minute, regularly and repeatedly.

This morning I came in regretting not only the time change, but the 
possibility that I'd have to spend the next few days bug hunting. 
However, it appears that there may be a 'tell': aux_bap.  Normally, the 
only airo.o option I specified was the SSID, which defaulted the aux_bap 
setting to 0.  I set this value to 1, disabled my firewall settings, and 
ran VNC again.  No crashes.  I re-enabled the firewall and let it run. 
No crashes.  It ran fine for about 1/2 hr.

I then removed the aux_bap parameter, reloaded the driver, and tried to 
test some more.  Within 10 seconds, before VNC had painted the full 
screen, I got:

airo: BAP error 4000 2ocal Loopback
Warning kfree_skb passed an skb still on a list (from d0ae27dc)
kernel BUG at skbuff.c:315!
invalid operand: 0000
...
and a bunch of other things I can't ksymoops.

I think the "ocal Loopback" is cruft from a previous ifconfig.  However, 
it may be important to note that I was doing an ifconfig when this 
happened (probably not).  FWIW: eth0 (onboard) printed fine, as did eth1 
(the airo), then the 'lo' was overwritten by the OOPS.

I hope this is helpful to someone,
Chris

