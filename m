Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbTKGWOt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbTKGWN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:13:58 -0500
Received: from web25205.mail.ukl.yahoo.com ([217.12.10.65]:64375 "HELO
	web25205.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S264469AbTKGQke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 11:40:34 -0500
Message-ID: <20031107164033.19095.qmail@web25205.mail.ukl.yahoo.com>
Date: Fri, 7 Nov 2003 17:40:33 +0100 (CET)
From: =?iso-8859-1?q?francois=20donzet?= <fdonzet@yahoo.fr>
Subject: checksum offloading
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, please answer to my mail (not subscribed)
 
 i've posted this on netdev, and get no reply. I try
there :

It is about tcp checksum offloading :

in my understanding of the process, if the device
supports checksum offloading :

- an incoming packet is handled by the driver
networking code associated to the ethernet card (for
example)

1) the checksum is hardware computed. But in the case
of e100 for example, skb->csum is filled with a sum
covering the entire packet

2) then the packet passes through ip layer, checksum
is verified (not using skb->csum)

3) the packet comes to tcp layer, skb->csum is
extracted and used to compute (folding with the pseudo
header checksum) the final checksum

4) if the packet is incorrect, drop it.

You see the problem is between 1) and 2). In my
understanding, skb->csum is used by tcp, but as
skb->csum as been filled with a sum on the entire
packet content as seen by netif_rx() (that is what is
indicated in skbuff.h by yourself), there is a problem
because tcp only needs the sum on tcpheader+data no ?
no the entire sum computed by the hardware.

Before reading the code, i thought that the TCP
checksum was computed by hardware. (not a sum on
ipheader+tcpheader+data).

Thanks

please answer to my mail (not subscribed

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
