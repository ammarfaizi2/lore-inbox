Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbUCGMCA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 07:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbUCGMBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 07:01:51 -0500
Received: from moutng.kundenserver.de ([212.227.126.184]:54770 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261840AbUCGMBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 07:01:44 -0500
Date: Sun, 7 Mar 2004 13:01:40 +0100
From: Thomas Mueller <linux-kernel@tmueller.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6 much worse than 2.4 on poor wlan reception
Message-ID: <20040307120140.GA1582@tmueller.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040304180154.GA1893@tmueller.com> <200403042347.52657.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200403042347.52657.vda@port.imtp.ilyichevsk.odessa.ua>
X-PGP-Key-FingerPrint: F921 8CA2 4BB6 CF07 4F5B 22FC CF8B A4C1 9570 2B3B
X-Operating-System: Debian Linux K2.6.2-1-686
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:2c17e390e92c60a8a0573432b44c4ce0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

> > blade:~# iwconfig eth1
> > eth1      IEEE 802.11-DS  ESSID:"WLAN"  Nickname:"Prism  I"
> >           Mode:Managed  Frequency:2.412GHz  Access Point:00:60:B3:17:F8:8C
> >           Bit Rate:11Mb/s   Tx-Power=15 dBm   Sensitivity:1/3
> >           Retry min limit:8   RTS thr:off   Fragment thr:off
> >           Encryption key:[ secret ]   Security mode:open
> >           Power Management:off
> >           Link Quality:1/92  Signal level:-101 dBm  Noise level:-149 dBm
> 
> I have Prism 2.5 cards. I run them with hostap driver.
> Link quality of 1/92 is very bad. You are on the edge
> of losing connection. (At least this is the case for
> my hardware).

Yes I am. When I move some meters in the room I loose connection with
kernel 2.4 too.

> Let's see how much errors do you have. Do this:
> 
> # cat /proc/net/wireless /proc/net/dev
[..]

tmm@blade:~$ cat /proc/net/wireless /proc/net/dev
Inter-| sta-|   Quality        |   Discarded packets               |
Missed | WE
 face | tus | link level noise |  nwid  crypt   frag  retry   misc |
beacon | 16
  eth1: 0000    0.  150.  107.       0      8      0      0      0
0
Inter-|   Receive                                                |
Transmit
 face |bytes    packets errs drop fifo frame compressed multicast|bytes
packets errs drop fifo colls carrier compressed
    lo:   58298     881    0    0    0     0          0         0
58298     881    0    0    0     0       0          0
  eth0:       0       0    0    0    0     0          0         0
3456      14    0    0    0     0       0          0
  eth1:  532101    1336    0    0    0     0          0         0
223614    1299  466    0    0     0       0          0
  sit0:       0       0    0    0    0     0          0         0
0       0    0    0    0     0       0          0

That's really interesting, thanks for that hint!
Transmit: 1299 packets, 466 errs - argh.

When I can't transmit anything 'errs' increases by one every few
seconds.

As comparison: kernel 2.4.20 has 1743 packets and 9 errs at the moment.
So the interesting question is: why is the error rate with kernel 2.6
that high?

> > There was a break when netio transfered the 2k blocks.
> >
> > My log is full of entries like this one:
> > Mar  1 17:54:12 blade kernel: eth1: New link status: AP Out of Range
> > (0004)
> > Mar  1 17:54:12 blade kernel: eth1: New link status: AP In Range (0005)
> > Mar  1 17:54:16 blade kernel: eth1: New link status: AP Out of Range
> > (0004)
> > Mar  1 17:54:16 blade kernel: eth1: New link status: AP In Range (0005)
> > Mar  1 17:54:19 blade kernel: eth1: New link status: AP Out of Range
> > (0004)
> > Mar  1 17:54:20 blade kernel: eth1: New link status: AP In Range (0005)
> > Mar  1 17:54:22 blade kernel: eth1: New link status: AP Out of Range
> > (0004)
> >
> > Kernel 2.4 works far better in the poor reception situation I have,
> > anyone any idea what I could do without moving the AP or laptop?
> > When I'm near my AP everything works fine with 2.6 too.
> 
> Is your orinoco driver is the same for 2.4 and 2.6?
> Maybe 2.6 one has a bit lower max retry count or some such?

2.6.2 has version 0.13e, 2.4.23 has 0.13d. I diffed the orinoco.* but
there are only small changes.

> > BTW: removing the PCMCIA card when it's in use freezes my system
> > completely, that was no problem with 2.4.
> 
> No oops? No SysRq?

Nope, it just freezes :-(


-- 
MfG Thomas Mueller - http://www.tmueller.com for pgp key (95702B3B)
