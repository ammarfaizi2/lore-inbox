Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbTDKQvs (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 12:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTDKQvs (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 12:51:48 -0400
Received: from [203.197.168.150] ([203.197.168.150]:9989 "HELO
	mailscanout256k.tataelxsi.co.in") by vger.kernel.org with SMTP
	id S261293AbTDKQvp (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 12:51:45 -0400
Message-ID: <3E96F517.7020002@tataelxsi.co.in>
Date: Fri, 11 Apr 2003 22:32:15 +0530
From: "Sriram Narasimhan" <nsri@tataelxsi.co.in>
Organization: Tata Elxsi
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sk_buff doubt
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A doubt in sk_buff. I am running the fcc_enet driver provided in the PPC 
architecture tree for MPC8260 on ADS board.
Kernel version is 2.4.1. The driver has been modified to be loaded as a 
module.
When IFNET provides the sk_buff to transmit I store them up in an array 
and at transmit complete I release the sk_buff.

When the module is unloaded, I release all the sk_buffs.
When I release the sk_buff I get the following output. Am I doing 
anything wrong here ?
-----------------------------------------------------------------------------------------

# ifconfig eth1 10.1.70.56 netmask 255.255.0.0 up
eth1: config: auto-negotiation on, 10FDX, 10HDX.
# ping 10.1.1.1
Inside fcc_enet_start_xmit... skb: c01e5c60
Inside fcc_enet_start_xmit... skb: c01e5620
Inside fcc_enet_start_xmit... skb: c01e5080
No response from 10.1.1.1
# lsmod
Module                  Size  Used by
enet                   12512   0  (unused)
# rmmod enet
Warning: kfree_skb passed an skb still on a list (from c208360c).
kernel BUG at skbuff.c:277!
Oops: Exception in kernel mode, sig: 4

-----------------------------------------------------------------------------------------

Sriram

