Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262715AbVD2OXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbVD2OXM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbVD2OWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:22:11 -0400
Received: from web51405.mail.yahoo.com ([206.190.38.184]:45936 "HELO
	web51405.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262715AbVD2OVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:21:20 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=4ZXpq/mlNnDbBmMfcOs0vUBJbosTnywcykXOFl9/evfibQ2z5mFLqgNnZrgwb65ASe0h36aKOvj4UbtF7NWH801QGeIjCpAUVk292GUfRi8UnV76bY0DTeGxA+q7M/pJOFeLf2Tjh661uDoSJ15q8I0fEhI4+x6Eo5QpOi9+woQ=  ;
Message-ID: <20050429142116.93850.qmail@web51405.mail.yahoo.com>
Date: Fri, 29 Apr 2005 16:21:15 +0200 (CEST)
From: Joerg Pommnitz <pommnitz@yahoo.com>
Subject: Urgent help needed: CardBus iomem allocation problem with 6 CardBus slots
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,
I try to get three devices to work in 6 CardBus (three adapters with 2
slots each) slots. The problem is, that it seems that Linux by default
fails to evenly distribute the available IO memory to the individual
slots. Here is what cat /proc/iomem says without a card plugged in:
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000de000-000defff : 0000:00:14.0
  000de000-000defff : ohci_hcd
000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  00100000-00307306 : Kernel code
  00307307-003ca37f : Kernel data
20000000-27ffffff : 0000:00:00.0
f4000000-f4003fff : 0000:00:09.0
f4004000-f4004fff : 0000:00:0a.0
  f4004000-f4004fff : e100
f4005000-f4005fff : 0000:00:0b.0
  f4005000-f4005fff : e100
f4007000-f40077ff : 0000:00:09.0
  f4007000-f40077ff : ohci1394
f4100000-f41fffff : 0000:00:0a.0
  f4100000-f41fffff : e100
f4200000-f42fffff : 0000:00:0b.0
  f4200000-f42fffff : e100
f4300000-f45fffff : PCI Bus #02
  f4300000-f4300fff : 0000:02:0d.0
    f4300000-f4300fff : yenta_socket
  f4301000-f4301fff : 0000:02:0d.1
    f4301000-f4301fff : yenta_socket
  f4302000-f4302fff : 0000:02:0e.0
    f4302000-f4302fff : yenta_socket
  f4303000-f4303fff : 0000:02:0e.1
    f4303000-f4303fff : yenta_socket
  f4304000-f4304fff : 0000:02:0f.0
    f4304000-f4304fff : yenta_socket
  f4305000-f4305fff : 0000:02:0f.1
    f4305000-f4305fff : yenta_socket
  f4308000-f430ffff : PCI CardBus #0f
  f4310000-f431ffff : PCI CardBus #0f
  f4320000-f433ffff : PCI CardBus #0b
  f4340000-f437ffff : PCI CardBus #03
  f4380000-f43bffff : PCI CardBus #07
  f43c0000-f43fffff : PCI CardBus #07
  f4400000-f44fffff : PCI CardBus #03
  f4500000-f45fffff : PCI CardBus #0b
f8000000-fbffffff : PCI Bus #01
  f8000000-fbffffff : 0000:01:00.0
    f8200000-f89fffff : vesafb
fffe0000-ffffffff : reserved

If I insert one of my target cards into slot 0 I get:
  f4308000-f430ffff : PCI CardBus #0f
  f4310000-f431ffff : PCI CardBus #0f
  f4320000-f433ffff : PCI CardBus #0b
  f4340000-f437ffff : PCI CardBus #03
    f4340000-f434ffff : 0000:03:00.0
    f4350000-f435ffff : 0000:03:00.0
    f4360000-f4360fff : 0000:03:00.1
      f4360000-f4360fff : ohci_hcd
  f4380000-f43bffff : PCI CardBus #07
  f43c0000-f43fffff : PCI CardBus #07
  f4400000-f44fffff : PCI CardBus #03
  f4500000-f45fffff : PCI CardBus #0b
As you can see, the card allocates 3 memory ranges from the memory
assigned to the slot. In this slot (with 256K memory), the card works
fine.
Trying slot 1:
  f4308000-f430ffff : PCI CardBus #0f
  f4310000-f431ffff : PCI CardBus #0f
  f4320000-f433ffff : PCI CardBus #0b
  f4340000-f437ffff : PCI CardBus #03
  f4380000-f43bffff : PCI CardBus #07
  f43c0000-f43fffff : PCI CardBus #07
    f43c0000-f43cffff : 0000:07:00.0
    f43d0000-f43dffff : 0000:07:00.0
    f43e0000-f43e0fff : 0000:07:00.1
      f43e0000-f43e0fff : ohci_hcd
  f4400000-f44fffff : PCI CardBus #03
  f4500000-f45fffff : PCI CardBus #0b
Fine as well with 256K IO memory.
Now slot 2:
  f4308000-f430ffff : PCI CardBus #0f
  f4310000-f431ffff : PCI CardBus #0f
  f4320000-f433ffff : PCI CardBus #0b
    f4320000-f432ffff : 0000:0b:00.0
    f4330000-f433ffff : 0000:0b:00.0
  f4340000-f437ffff : PCI CardBus #03
  f4380000-f43bffff : PCI CardBus #07
  f43c0000-f43fffff : PCI CardBus #07
  f4400000-f44fffff : PCI CardBus #03
  f4500000-f45fffff : PCI CardBus #0b
As you can see, only two of the allocations succeed, the usb hub on the
card fails. /var/log/messages contains the error message:
Apr 29 17:19:23 inova08 kernel: PCI: Failed to allocate mem resource
#0:1000@f4340000 for 0000:0b:00.1
Apr 29 17:19:23 inova08 kernel: PCI: Enabling device 0000:0b:00.1 (0000 ->
0002)
Apr 29 17:19:23 inova08 kernel: ohci_hcd: probe of 0000:0b:00.1 failed
with error -16

The system tries to allocate memory directly after the previous one, but
this address range (f4340000) is already allocated to a different socket.
The IO memory range allocated to socket 2 is only 128K. Why? What controls
these memory window sizes? How can I change them?

For completeness the result for socket 3:

  f4308000-f430ffff : PCI CardBus #0f
    f4308000-f4308fff : 0000:0f:00.1
      f4308000-f4308fff : ohci_hcd
  f4310000-f431ffff : PCI CardBus #0f
  f4320000-f433ffff : PCI CardBus #0b
  f4340000-f437ffff : PCI CardBus #03
  f4380000-f43bffff : PCI CardBus #07
  f43c0000-f43fffff : PCI CardBus #07
  f4400000-f44fffff : PCI CardBus #03
  f4500000-f45fffff : PCI CardBus #0b

Only one of the allocations succeeds. The usb host adpter on the card
works fine. The io memory window for this slot is 32K.

Thanks in advance
  Joerg


	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 250MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
