Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286758AbRLVK4C>; Sat, 22 Dec 2001 05:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286759AbRLVKzx>; Sat, 22 Dec 2001 05:55:53 -0500
Received: from elin.scali.no ([62.70.89.10]:38159 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S286758AbRLVKzi>;
	Sat, 22 Dec 2001 05:55:38 -0500
Message-ID: <3C246691.2CD6460F@scali.no>
Date: Sat, 22 Dec 2001 11:55:13 +0100
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, saw@saw.sw.com.sg
Subject: eepro100 ? network driver problem.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a 16 node cluster with dual Intel 82557 network controllers (eepro100) driver. All nodes have
RedHat 7.1 installed and using the latest kernel update from RH (2.4.9.-12). Here's a bit from dmesg
:

eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and
others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:30:48:11:3E:53, IRQ 31.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eth1: OEM i82557/i82558 10/100 Ethernet, 00:30:48:11:3C:44, IRQ 28.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).


Sometimes under heavy load one of the nodes (random node each time) crash with the following Oops :

Unable to handle kernel paging request at virtual address 0000d5ca
 printing eip:
c0200002
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<c0200002>]    Not tainted
EFLAGS: 00010282
eax: 00000000   ebx: 00000001   ecx: dfa36000   edx: c0311840
esi: dfa36000   edi: 0000d5c2   ebp: df7123c0   esp: c9bc5ee0
ds: 0018   es: 0018   ss: 0018
Process mpi_bomb (pid: 16020, stackpage=c9bc5000)
Stack: 00000001 df7123c0 00000001 df7123c0 c01d109c 00000108 00000002 00000020 
       0000003c c01ccd6c df7123c0 df7123c0 00000001 00000003 dfa36000 e0902188 
       dfa36000 00000001 dfa36144 0000000c 00000001 00000001 df7123c0 df7123c0 
Call Trace: [<c01d109c>] netif_rx [kernel] 0x8c 
[<c01ccd6c>] alloc_skb [kernel] 0xfc 
[<e0902188>] __insmod_eepro100_S.text_L11712 [eepro100] 0x2128 
[<c01d154b>] net_rx_action [kernel] 0x1eb 
[<c011f74b>] do_softirq [kernel] 0x7b 
[<c0108c4d>] do_IRQ [kernel] 0xdd 
[<c022a550>] call_do_IRQ [kernel] 0x5 


Code: 81 47 08 89 44 24 28 b8 b8 1a 31 c0 0f b7 5e 5c f0 83 28 01 
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


Is this a known problem with the eepro100 driver in 2.4.9 and fixed in later kernels, or is it a
generic network driver problem (maybe VM related since the machine might be stressed on memory). I
also wonder why the process running at the time (mpi_bomb) shows up in the Oops.

Feedback highly appreciated.

Thanks,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best   
 mailto:sp@scali.no  |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.12.2 -         
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >300MBytes/s and <4uS latency
