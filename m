Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285263AbRLMXym>; Thu, 13 Dec 2001 18:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285266AbRLMXyd>; Thu, 13 Dec 2001 18:54:33 -0500
Received: from harlie.han.de ([212.63.63.17]:32162 "EHLO harlie.han.de")
	by vger.kernel.org with ESMTP id <S285263AbRLMXyV>;
	Thu, 13 Dec 2001 18:54:21 -0500
From: Peter Cleve <toad@harlie.han.de>
Message-Id: <200112132353.fBDNrda32369@harlie.han.de>
Subject: What does CONFIG_NETDEVICES *really* mean ?
To: linux-kernel@vger.kernel.org
Date: Fri, 14 Dec 2001 00:53:39 +0100 (CET)
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

CONFIG_NETDEVICES is referenced only at 2 files in the kernel source:
	- net/core/sock.c
	- drivers/isdn/isdn_common.c

In net/core/sock.c it's used as an #ifdef around the SO_BINDTODEVICE code
in sock_setsockopt().

This is the interesting part from net/core/sock.c :

	[ ... ]
                case SO_SNDTIMEO:
                        ret = sock_set_timeout(&sk->sndtimeo, optval, optlen);
                        break;

#ifdef CONFIG_NETDEVICES
                case SO_BINDTODEVICE:
                {
                        char devname[IFNAMSIZ];
	[ ... ]

IMHO it's completly legal to bind a socket to the loopback interface if you
have an machine with CONFIG_INET=y and unset CONFIG_NETDEVICES. I'm not a
kernel hacker and think the surrounding #ifdef should be removed.

In drivers/isdn/isdn_common.c it is used as an #ifdef about some cmd's
in isdn_ioctl(). Some cmd's which are surrounded by CONFIG_NETDEVICES are: 

	case IIOCNETGPN: /* Get peer phone number of a connected isdn network interface */
	case IIOCNETAIF: /* Add a network-interface */
	case IIOCNETASL: /* Add a slave to a network-interface */

	..... many follows .......

Consider a kernel with no additional Network interfase except isdn interfaces,
these ioctl's cannot work, but IMHO these are needed to set up the isdn interfaces.

IMHO CONFIG_INET fit's better.

Maybe somebody with more knowledge about the kernel can comment about these topics.

Greetings

