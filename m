Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317463AbSIIQLb>; Mon, 9 Sep 2002 12:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317482AbSIIQLb>; Mon, 9 Sep 2002 12:11:31 -0400
Received: from unknown.Level3.net ([63.210.233.154]:63096 "EHLO
	cinshrexc01.shermfin.com") by vger.kernel.org with ESMTP
	id <S317463AbSIIQL3> convert rfc822-to-8bit; Mon, 9 Sep 2002 12:11:29 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: syslogd: recvfrom inet: resource temporarily unavailable
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Mon, 9 Sep 2002 12:16:13 -0400
Message-ID: <CDF05CB9FCA0C845B9778F9E463C476101FC77@cinshrexc01.shermfin.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: syslogd: recvfrom inet: resource temporarily unavailable
Thread-Index: AcJYFkEXpBpnvh60RWSg2lgqSfRx4AAA3E0g
From: "Rechenberg, Andrew" <ARechenberg@shermanfinancialgroup.com>
To: <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That's odd because every box that I have looked at has the
0.0.0.0:PORTNUM in the netstat list if there is a service listening on a
particular port.  

I know most programs will allow one to specify on which interface to
listen, but it doesn't look as if syslogd has such an option.

As an additional piece of information, I've tried tweaking xinetd.conf,
but those messages are still being logged into /var/log/messages.

Thanks for your help,
Andy.

-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com] 
Sent: Monday, September 09, 2002 11:36 AM
To: Rechenberg, Andrew
Cc: linux-kernel@vger.kernel.org
Subject: Re: syslogd: recvfrom inet: resource temporarily unavailable


On Mon, 9 Sep 2002, Rechenberg, Andrew wrote:

> I am using a Dell PowerEdge 2300 running Red Hat Linux 7.2 for a
> syslog consolidation machine.  It is also our network monitoring
> system and it runs Cricket, NMIS, and cflowd and Flowscan for Cisco
> NetFlow collection.
> 
[SNIPPED]
> Lately the machine has been running extremely slow whenever anything
> that happens on the box needs to syslog something (su, logins, etc.). 
> I've checked /var/log/messages and it repeatedly contains the
> following line:
[SNIPPED]

> ESTABLISHED
> udp        0      0 0.0.0.0:32768           0.0.0.0:*
> udp    41056      0 0.0.0.0:514             0.0.0.0:*
> udp        0      0 0.0.0.0:2055            0.0.0.0:*
> udp        0      0 0.0.0.0:69              0.0.0.0:*
> udp        0      0 0.0.0.0:69              0.0.0.0:*
> udp        0      0 0.0.0.0:734             0.0.0.0:*
> udp        0      0 0.0.0.0:111             0.0.0.0:*

I think that all these 0.0.0.0 addresses are handled just like
broadcast addresses, i.e., your driver will get interrupted for
every packet on the wire. If so, this is not good and will severely
affect the performance of your computer. I think you need a real
"network(ed)" address for these, i.e., 10.0.0.1, 10.0.0.2, etc.
In the "olden" days, 0.0.0.0 was the broadcast address and I think
that Linux still maintains that compatibility.


> Andrew Rechenberg
> Infrastructure Team, Sherman Financial Group
> arechenberg@shermanfinancialgroup.com
> Phone: 513.677.7809
> Fax:   513.677.7838
> -


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

