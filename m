Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbUCDV5h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 16:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbUCDV44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 16:56:56 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:54536 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261952AbUCDV4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 16:56:49 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Thomas Mueller <linux-kernel@tmueller.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 much worse than 2.4 on poor wlan reception
Date: Thu, 4 Mar 2004 23:47:52 +0200
User-Agent: KMail/1.5.4
References: <20040304180154.GA1893@tmueller.com>
In-Reply-To: <20040304180154.GA1893@tmueller.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403042347.52657.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 March 2004 20:01, Thomas Mueller wrote:
> I have big problems with kernel 2.6 and WLAN. Quite often the connection
> interrupts completely, I can't transfer anything for minutes - making
> 2.6 unusable for me :-(

> blade:~# iwconfig eth1
> eth1      IEEE 802.11-DS  ESSID:"WLAN"  Nickname:"Prism  I"
>           Mode:Managed  Frequency:2.412GHz  Access Point:00:60:B3:17:F8:8C
>           Bit Rate:11Mb/s   Tx-Power=15 dBm   Sensitivity:1/3
>           Retry min limit:8   RTS thr:off   Fragment thr:off
>           Encryption key:[ secret ]   Security mode:open
>           Power Management:off
>           Link Quality:1/92  Signal level:-101 dBm  Noise level:-149 dBm

I have Prism 2.5 cards. I run them with hostap driver.
Link quality of 1/92 is very bad. You are on the edge
of losing connection. (At least this is the case for
my hardware).

Let's see how much errors do you have. Do this:

# cat /proc/net/wireless /proc/net/dev

On my system wlan1 has "Link Quality:66/92"
(wlan0 is an AP, has no meaningful Link Quality)

Inter-| sta-|   Quality        |   Discarded packets               | Missed | WE
 face | tus | link level noise |  nwid  crypt   frag  retry   misc | beacon | 16
 wlan0: 0000    0     0     0        0   9178     13  23727 142280        0
 wlan1: 0000   66.  195.  156.       0      0      0   3422 309008        0

Inter-|   Receive                                                |  Transmit
 face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
 wlan0:1829928225 2539552    0 80689    0     0          0         0 1966341385 2579089    0   42    0     0       0          0
 wlan1:143242367  907236    0    0    0     0          0         0 11481487   74357    0    0    0     0       0          0

So, wlan1: 907236 rx packets, 3422 retries
(and 309008 packets wasn't for me, wrong MAC, I suppose ;) )
What's your numbers?

> There was a break when netio transfered the 2k blocks.
>
> My log is full of entries like this one:
> Mar  1 17:54:12 blade kernel: eth1: New link status: AP Out of Range
> (0004)
> Mar  1 17:54:12 blade kernel: eth1: New link status: AP In Range (0005)
> Mar  1 17:54:16 blade kernel: eth1: New link status: AP Out of Range
> (0004)
> Mar  1 17:54:16 blade kernel: eth1: New link status: AP In Range (0005)
> Mar  1 17:54:19 blade kernel: eth1: New link status: AP Out of Range
> (0004)
> Mar  1 17:54:20 blade kernel: eth1: New link status: AP In Range (0005)
> Mar  1 17:54:22 blade kernel: eth1: New link status: AP Out of Range
> (0004)
>
> Kernel 2.4 works far better in the poor reception situation I have,
> anyone any idea what I could do without moving the AP or laptop?
> When I'm near my AP everything works fine with 2.6 too.

Is your orinoco driver is the same for 2.4 and 2.6?
Maybe 2.6 one has a bit lower max retry count or some such?

> BTW: removing the PCMCIA card when it's in use freezes my system
> completely, that was no problem with 2.4.

No oops? No SysRq?
--
vda

