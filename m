Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVCPLvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVCPLvl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 06:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbVCPLvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 06:51:40 -0500
Received: from mx-s.protv.ro ([193.230.227.101]:56736 "EHLO mx-s.protv.ro")
	by vger.kernel.org with ESMTP id S261175AbVCPLuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 06:50:04 -0500
Message-ID: <42381D4B.7080707@tfm.ro>
Date: Wed, 16 Mar 2005 13:49:31 +0200
From: krn <krn@tfm.ro>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.11.3 / Openswan  machine freeze after
 establishing a connection
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-BitDefender-Spam: No (14)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to make an ipsec connection between 2 networks and i'm 
experiencing lots of machine freeze after establishing the connection.

Kernel 2.6.11.3  ( I also tried with 2.6.9 and got the same results )
Openswan 2.1.6 ( Also tried with 2.3.0 and got same results )


eth0:  192.168.11.1
eth1: 193.230.x.x

/etc/ipsec.conf
------------------------------------------------
version 2

config setup
   interfaces="ipsec0=eth0"
   klipsdebug=all
   plutodebug=all

conn tss-to-vpn
   type=tunnel
   authby=rsasig
   left=193.230.x.x
   leftnexthop=193.230.x.x
   leftsubnet=192.168.11.0/24
   leftcert=vpn-client-cert.pem
   right=193.231.x.x
   rightnexthop=193.231.x.x
   rightsubnet=0.0.0.0/0
   rightcert=vpn-srv-cert.pem
   auto=start
-----------------------------------------------------

/etc/ipsec.secrets contains:
-------------------------------------------------
: RSA vpn-client-priv.pem "xxxxxxxx"
--------------------------------------------------
The strange part is that the main vpn server works as expected and that 
never hanged . Only the machine with the above config .



If i press alt-sysreq-p after hang i get this:

Pid: 0 , comm:         swapper
EIP: 0060:[<c0432075>]    CPU:0
EIP is at  _spin_lock_irqsave+0x65/0x80
EFLAGS: 00000202    Not tainted ( 2.6.11.3-test-2tfm)
EAX:00000001 EBX:dace4e0c  ECX:00000403 EDX:00000001
ESI:c05cd000 EDI:db356f3c  EBP: c05cdd50 DS: 007b ES: 007b
CR0: 8005003b CR2: 080d30ec CR3: 1fe3f500 CR4: 000006e0


Anyone have an ideea why it behave like this and how i can fix it ?

Best regards,
Mihai Moldovanu

