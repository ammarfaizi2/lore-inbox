Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132186AbRDPV1J>; Mon, 16 Apr 2001 17:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132224AbRDPV1A>; Mon, 16 Apr 2001 17:27:00 -0400
Received: from mailhost3.lanl.gov ([128.165.3.9]:24175 "EHLO
	mailhost3.lanl.gov") by vger.kernel.org with ESMTP
	id <S132147AbRDPV0v>; Mon, 16 Apr 2001 17:26:51 -0400
Message-ID: <3ADB637B.13E4F1AD@lanl.gov>
Date: Mon, 16 Apr 2001 15:26:19 -0600
From: Eric Weigle <ehw@lanl.gov>
Organization: CCS-1 RADIANT team
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, es-ES, ex-MX, fr-FR, fr-CA
MIME-Version: 1.0
To: Sampsa Ranta <sampsa@netsonic.fi>, linux-net@vger.kernel.org,
        linux-kernel@vger.kernel.org, zebra@zebra.org
Subject: Re: ARP responses broken!
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello-

This is a known 'feature' of the Linux kernel, and can help with load sharing
and fault tolerance. However, it can also cause problems (such as when one nic
in a multi-nic machine fails and you don't know right away).

There are three 'solutions' I know of:

  * In recent 2.2 kernels, it was possible to fix this by doing the following as
root: 
        # Start the hiding interface functionality
        echo 1 > /proc/sys/net/ipv4/conf/all/hidden
        # Hide all addresses for this interface
        echo 1 > /proc/sys/net/ipv4/conf/<interface_name>/hidden
    but 2.4 doesn't have that option, for technical reasons.

   * Use 'ifconfig -arp ...' to force an interface not to respond to ARP
requests. Hosts which want to send to that interface may need to manually add
the proper mac address to their ARP tables with 'arp -s'.

   * Use a packet filtering tool (iptables arp filter module, for example) and
just filter the ARP requests and ARP replies so that only the proper set get
through, i.e. when an arp request for the mac address of an interface arrives,
filter out arp replies from all the other interfaces. 

There have been a few threads on this on the linux-kernel mailing list. Search
your favorite archive for them.

-Eric
 
--------------------------------------------
 Eric H. Weigle   CCS-1, RADIANT team
 ehw@lanl.gov     Los Alamos National Lab
 (505) 665-4937   http://home.lanl.gov/ehw/
--------------------------------------------
