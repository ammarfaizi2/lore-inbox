Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUHBJTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUHBJTA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 05:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUHBJTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 05:19:00 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:65030 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266362AbUHBJS6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 05:18:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Miroslav Zubcic <mvz@nimium.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Bug in ethernet module b44.c (2.6.7)
Date: Mon, 2 Aug 2004 12:18:21 +0300
X-Mailer: KMail [version 1.4]
References: <lzd629zzcz.fsf@devana.nimium.local>
In-Reply-To: <lzd629zzcz.fsf@devana.nimium.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200408021218.21958.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 August 2004 12:02, Miroslav Zubcic wrote:
> I had problems with b44 module on 2.6.6 kernel, but this was resolved
> with patch from Pekka Pietikainen on this list, and later merged in
> 2.6.7 kernel. Thanks Pekka and Jeff.
>
> Meanwhile, I have discovered new bug in this module. When opening raw
> socket, network card will stop sending and receiveing packets.
>
> For example, if I start `nmap -v -sS 192.168.1.70'. nmap(1) freezes
> and waits forever. While nmap(1) is active (and trying to do it's
> job), I cannot do anything on the net. Existing ssh connections are
> freezed and unresponsive. If I interrupt nmap, everything comes back
> to normal after 1-2 seconds.

Provide strace of hung nmap.

> Only working mode for nmap(1) is: "nmap -v -sT -P0". This mode will
> not freeze broadcom ethernet card.
>
> However, I have found one workaround. If I start tcpdump(8) in one
> xterm on eth interface to wait for traffic, and "nmap -v -sS" in other
> window, nmap (and all other active or new connections, like ssh, http)
> are working without problem. So, if PROMISC is set on interface
> (tcpdump will set this flag when started, and remove on interrupt),
> everything works as expected. Of course, if I stop tcpdump(8), and
> start nmap(1) again, it will not work, and network will be unusable
> until I kill nmap(1). In normal mode without nmap(1), that is -
> tcp,udp ssh/http/imap/smtp ... there is no visible problems.  dmesg(8)
> does not report anything unusual, neither logfiles do.

Does just setting promisc with ifconfig or ip tool helps?

> I hope this is enough info.
--
vda
