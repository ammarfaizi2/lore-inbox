Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVKQNqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVKQNqo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVKQNqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:46:44 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:995 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1750824AbVKQNqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:46:43 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: "Cipriani, Lawrence V (Larry)" <lvc@lucent.com>, kai.germaschewski@gmx.de,
       kkeil@suse.de, isdn4linux@listserv.isdn4linux.de
Subject: Re: bugs in /usr/src/linux/net/ipv6/mcast.c
Date: Thu, 17 Nov 2005 15:46:00 +0200
User-Agent: KMail/1.8.2
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
References: <0C6AA2145B810F499C69B0947DC5078107BCDE20@oh0012exch001p.cb.lucent.com>
In-Reply-To: <0C6AA2145B810F499C69B0947DC5078107BCDE20@oh0012exch001p.cb.lucent.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511171546.00862.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.6.14 in drivers/isdn/hisax:

# grep -r '[^a-z0-9_]if *([^()]*([^)]*)[^)]*);' .
./hfc_sx.c:     if (Read_hfc(cs, HFCSX_INT_S1));
./hfc_sx.c:     if (Read_hfc(cs, HFCSX_INT_S2));
./hfc_sx.c:                                             if (Read_hfc(cs, HFCSX_INT_S1));
./hfc_pci.c:    if (Read_hfc(cs, HFCPCI_INT_S1));
./hfc_pci.c:    if (Read_hfc(cs, HFCPCI_INT_S1));
./hfc_pci.c:                                            if (Read_hfc(cs, HFCPCI_INT_S1));

These are not bugs, but rather "interesting" coding style:

        Write_hfc(cs, HFCSX_INT_M1, cs->hw.hfcsx.int_m1);

        /* Clear already pending ints */
        if (Read_hfc(cs, HFCSX_INT_S1));

        Write_hfc(cs, HFCSX_STATES, HFCSX_LOAD_STATE | 2);      /* HFC ST 2 */

Obviously author tried to silence something like lint.
I think it may be replaced with (void)expr; construct.
--
vda
