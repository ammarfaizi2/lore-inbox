Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTF0AOt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 20:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbTF0AOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 20:14:49 -0400
Received: from smtp.terra.es ([213.4.129.129]:24891 "EHLO tsmtp9.mail.isp")
	by vger.kernel.org with ESMTP id S263129AbTF0AOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 20:14:25 -0400
Date: Fri, 27 Jun 2003 02:28:37 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: dgp85@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: PPP Modem connection impossible with 2.5.73-bk2
Message-Id: <20030627022837.3dca1b09.diegocg@teleline.es>
In-Reply-To: <20030626164116.1bfbad1e.shemminger@osdl.org>
References: <1056567978.931.8.camel@laurelin>
	<20030626195238.673bcffd.diegocg@teleline.es>
	<20030626164116.1bfbad1e.shemminger@osdl.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__27_Jun_2003_02:28:37_+0200_082bb590"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Fri__27_Jun_2003_02:28:37_+0200_082bb590
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2003 16:41:16 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> What is your ppp configuration, anything special? 

Nothing strange that i know of;
hide-password 
noauth
connect "/usr/sbin/chat -v -f /etc/chatscripts/provider"
debug
/dev/ttyS1
#200000
115200
#460800
defaultroute
noipdefault 
user XXXXXXXXXXXXX
remotename provider
ipparam provider


> Is serial line fat or slow? Is this on SMP or UP system?

It's a external serial (ttyS1) 56k modem (Supraexpress 56e).
It's a SMP system.

> 
> I can't reproduce this over a null modem cable so trying to see what could
> be different.

I reverted your changeset and everything works again.
pppd version is 2.4.1 (debian sid environment)
Config is attached.

This is the dmesg output when it works:
Jun 27 02:17:29 estel kernel: PPP generic driver version 2.4.2
Jun 27 02:17:29 estel modprobe: FATAL: Module ipv6 not found. 
Jun 27 02:17:29 estel pppd[405]: pppd 2.4.1 started by diego, uid 1234
Jun 27 02:17:30 estel chat[407]: abort on (BUSY)
Jun 27 02:17:30 estel chat[407]: abort on (NO CARRIER)
Jun 27 02:17:30 estel chat[407]: abort on (VOICE)
Jun 27 02:17:30 estel chat[407]: abort on (NO DIALTONE)
Jun 27 02:17:30 estel chat[407]: abort on (NO DIAL TONE)
Jun 27 02:17:30 estel chat[407]: abort on (NO ANSWER)
Jun 27 02:17:30 estel chat[407]: abort on (DELAYED)
Jun 27 02:17:30 estel chat[407]: send (ATZ^M)
Jun 27 02:17:31 estel chat[407]: expect (OK)
Jun 27 02:17:31 estel chat[407]: ATZ^M^M
Jun 27 02:17:31 estel chat[407]: OK
Jun 27 02:17:31 estel chat[407]:  -- got it 
Jun 27 02:17:31 estel chat[407]: send (ATDTXXXXXXXXX^M)
Jun 27 02:17:31 estel chat[407]: expect (CONNECT)
Jun 27 02:17:31 estel chat[407]: ^M
Jun 27 02:17:50 estel chat[407]: ATDTXXXXXXXXX^M^M
Jun 27 02:17:50 estel chat[407]: CONNECT
Jun 27 02:17:50 estel chat[407]:  -- got it 
Jun 27 02:17:50 estel chat[407]: send (\d)
Jun 27 02:17:51 estel pppd[405]: Serial connection established.
Jun 27 02:17:51 estel pppd[405]: using channel 1
Jun 27 02:17:51 estel pppd[405]: Using interface ppp0
Jun 27 02:17:51 estel pppd[405]: Connect: ppp0 <--> /dev/ttyS1
Jun 27 02:17:52 estel pppd[405]: sent [LCP ConfReq id=0x1 <asyncmap 0x0> <magic 0xf6e73be2> <pcomp> <accomp>]
Jun 27 02:17:53 estel pppd[405]: rcvd [LCP ConfReq id=0x1 <mru 1514> <asyncmap 0x0> <auth chap MD5> <magic 0xdc4f946b> <mrru 1514> <endpoint [null]>]
Jun 27 02:17:53 estel pppd[405]: sent [LCP ConfRej id=0x1 <mrru 1514>]
Jun 27 02:17:53 estel pppd[405]: rcvd [LCP ConfRej id=0x1 <pcomp>]
Jun 27 02:17:53 estel pppd[405]: sent [LCP ConfReq id=0x2 <asyncmap 0x0> <magic 0xf6e73be2> <accomp>]
Jun 27 02:17:53 estel pppd[405]: rcvd [LCP ConfReq id=0x2 <mru 1514> <asyncmap 0x0> <auth chap MD5> <magic 0xdc4f946b>]
Jun 27 02:17:53 estel pppd[405]: sent [LCP ConfAck id=0x2 <mru 1514> <asyncmap 0x0> <auth chap MD5> <magic 0xdc4f946b>]
Jun 27 02:17:53 estel pppd[405]: rcvd [LCP ConfRej id=0x2 <accomp>]
Jun 27 02:17:53 estel pppd[405]: sent [LCP ConfReq id=0x3 <asyncmap 0x0> <magic 0xf6e73be2>]
Jun 27 02:17:53 estel pppd[405]: rcvd [LCP ConfAck id=0x3 <asyncmap 0x0> <magic 0xf6e73be2>]
Jun 27 02:17:53 estel pppd[405]: sent [LCP EchoReq id=0x0 magic=0xf6e73be2]
Jun 27 02:17:53 estel pppd[405]: rcvd [CHAP Challenge id=0x3 <a00f1ece659797d59f6d87302c8bf0cf>, name = "Hiper"]
Jun 27 02:17:53 estel pppd[405]: sent [CHAP Response id=0x3 <a8d6954791920082eed78270fe8d0342>, name = "XXXXXXXXXXXXXXX"]
Jun 27 02:17:53 estel pppd[405]: rcvd [LCP EchoRep id=0x0 magic=0xdc4f946b]
Jun 27 02:17:53 estel pppd[405]: rcvd [CHAP Success id=0x3 "\000"]
Jun 27 02:17:53 estel pppd[405]: Remote message: ^@
Jun 27 02:17:53 estel pppd[405]: kernel does not support PPP filtering
Jun 27 02:17:53 estel pppd[405]: sent [IPCP ConfReq id=0x1 <addr 0.0.0.0> <compress VJ 0f 01>]
Jun 27 02:17:53 estel kernel: PPP BSD Compression module registered
Jun 27 02:17:53 estel kernel: PPP Deflate Compression module registered
Jun 27 02:17:53 estel pppd[405]: sent [CCP ConfReq id=0x1 <deflate 14> <deflate(old#) 14> <bsd v1 15>]
Jun 27 02:17:53 estel pppd[405]: rcvd [IPCP ConfReq id=0x4 <compress VJ 0f 01> <addr 80.58.197.167>]
Jun 27 02:17:53 estel pppd[405]: sent [IPCP ConfAck id=0x4 <compress VJ 0f 01> <addr 80.58.197.167>]
Jun 27 02:17:53 estel pppd[405]: rcvd [IPCP ConfNak id=0x1 <addr 81.42.135.126>]
Jun 27 02:17:53 estel pppd[405]: sent [IPCP ConfReq id=0x2 <addr 81.42.135.126> <compress VJ 0f 01>]
Jun 27 02:17:53 estel pppd[405]: rcvd [LCP ProtRej id=0x5 80 fd 01 01 00 0f 1a 04 68 00 18 04 68 00 15 03 2f]
Jun 27 02:17:53 estel pppd[405]: rcvd [IPCP ConfAck id=0x2 <addr 81.42.135.126> <compress VJ 0f 01>]
Jun 27 02:17:53 estel pppd[405]: Cannot determine ethernet address for proxy ARP
Jun 27 02:17:53 estel pppd[405]: local  IP address 81.42.135.126
Jun 27 02:17:53 estel pppd[405]: remote IP address 80.58.197.167



Any suggestion...patch....i'm fully available :)

--Multipart_Fri__27_Jun_2003_02:28:37_+0200_082bb590
Content-Type: application/octet-stream;
 name="config.gz"
Content-Disposition: attachment;
 filename="config.gz"
Content-Transfer-Encoding: base64

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

--Multipart_Fri__27_Jun_2003_02:28:37_+0200_082bb590--
