Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266237AbUBSNCo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 08:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267268AbUBSNCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 08:02:44 -0500
Received: from openoffice.demon.nl ([212.238.150.237]:2568 "EHLO
	sahara.openoffice.nl") by vger.kernel.org with ESMTP
	id S266237AbUBSNBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 08:01:17 -0500
Date: Thu, 19 Feb 2004 14:01:15 +0100
From: Valentijn Sessink <linux-kernel-1073394249@mail.v.sessink.nl>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: IPsec 2.6 fragmentation issue(s)
Message-ID: <20040219130115.GA30379@openoffice.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

As sent to linux-net: I'm having various problems with 2.6 IPsec and
fragmentation. Most notably, the following - between host valentijn (2.6.1)
and host21 there's a Wifi IPsec tunnel:

  valentijn:~# ping -s 1435 host21
  PING host21.wireless.palmgracht.nl (10.15.67.21): 1435 data bytes
  ping: sendto: Message too long
  ping: wrote host21.wireless.palmgracht.nl 1443 chars, ret=-1
  ping: sendto: Message too long
  ping: wrote host21.wireless.palmgracht.nl 1443 chars, ret=-1

Resetting the MTU on the network interface helps:

  valentijn:~# ifconfig eth1 mtu 1400
  valentijn:~# ping -s 1417 host21
  PING host21.wireless.palmgracht.nl (10.15.67.21): 1417 data bytes
  1425 bytes from 10.15.67.21: icmp_seq=0 ttl=64 time=93.0 ms
  1425 bytes from 10.15.67.21: icmp_seq=1 ttl=64 time=78.2 ms

Then, resetting it to 1500 again does this:
valentijn:~# ifconfig eth1 mtu 1500
valentijn:~# ping -s 1435 host21
  PING host21.wireless.palmgracht.nl (10.15.67.21): 1435 data bytes
  ping: sendto: Message too long
  ping: wrote host21.wireless.palmgracht.nl 1443 chars, ret=-1
  1443 bytes from 10.15.67.21: icmp_seq=1 ttl=64 time=89.0 ms
  1443 bytes from 10.15.67.21: icmp_seq=2 ttl=64 time=79.9 ms

These MTU difficulties seem to propagate to a whole set of tunneling
difficulties, none of them clear enough to mention here, as my other side is
still a 2.4.24-with-IPsec backport. I'll try to set up a 2.6 machine there,
too, and report findings.

(If there's a better place to discuss 2.6 IPsec, please say so.)

Best regards,

Valentijn
-- 
http://www.openoffice.nl/   Open Office - Linux Office Solutions
Valentijn Sessink  valentyn+sessink@nospam.openoffice.nl
