Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbTD1Rou (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 13:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbTD1Rou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 13:44:50 -0400
Received: from CPE-65-30-34-80.kc.rr.com ([65.30.34.80]:1922 "EHLO
	cognition.home.hanaden.com") by vger.kernel.org with ESMTP
	id S261222AbTD1Rot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 13:44:49 -0400
Message-ID: <3EAD6B7C.4090108@hanaden.com>
Date: Mon, 28 Apr 2003 12:57:16 -0500
From: Hanasaki JiJi <hanasaki@hanaden.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030426
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux - LIST <linux-kernel@vger.kernel.org>
Subject: iptables NAT entry times out but connects from firewall
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a firewall with two NICs and the below rule to allow an 
internal host to connect out to smtp servers on the internet.  Some 
hosts have a connection timeout on a connect from $INTERNAL_IP_OF_SMTP 
yet connect from the firewall just fine.

iptables -t nat -A POSTROUTING -p tcp -o $NIC_EXTERNAL \
        --dport 25 -s $INTERNAL_IP_OF_SMTP -j MASQUERADE

ex:
on firewall:
	telnet csoc-mail-msfc.csoconline.com 25
	
	above connects ok

on $INTERNAL_IP_OF_SMTP
	telnet csoc-mail-msfc.csoconline.com 25

	connection times out

