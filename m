Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317810AbSFMT6t>; Thu, 13 Jun 2002 15:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317814AbSFMT6s>; Thu, 13 Jun 2002 15:58:48 -0400
Received: from mm02snlnto.sandia.gov ([132.175.109.21]:51209 "HELO
	mm02snlnto.sandia.gov") by vger.kernel.org with SMTP
	id <S317810AbSFMT6q>; Thu, 13 Jun 2002 15:58:46 -0400
X-Server-Uuid: 95b8ca9b-fe4b-44f7-8977-a6cb2d3025ff
Message-ID: <03781128C7B74B4DBC27C55859C9D73809840637@es06snlnt>
From: "Shipman, Jeffrey E" <jeshipm@sandia.gov>
To: "'John McBride'" <jmcbride@aep.ie>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: TCP checksum?
Date: Thu, 13 Jun 2002 13:58:44 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-Filter-Version: 1.8 (sass2426)
X-WSS-ID: 1116268A1294329-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks John, that function works great. However, I'm still having problems
where I'm not getting any responses from the destination. I've been setting
the destination address to the source address (this is just to play around
and learn things), and it's not working properly. If I connect straight to
the address (192.168.1.20), it works great. However, if I connect to
192.168.1.1, it looks like in the packet it's using 192.168.1.20, but all
I get no SYN/ACK back...my machine just keeps on sending out SYNs. Does
anyone know of things I need to also check in order to make sure this will
work. When I finish my module, it will be modifying all sorts of fields
inside of the TCP packet and I'd like to be sure that I can get responses
from remote machines.

Thanks.

Jeff Shipman - CCD 
Sandia National Laboratories 
(505) 844-1158 / MS-1372 

-----Original Message-----
From: John McBride [mailto:jmcbride@aep.ie]
Sent: Thursday, June 13, 2002 11:19 AM
To: Shipman, Jeffrey E
Subject: RE: TCP checksum?


Jeffrey, 
find snippet I used to update checksum in my netfilter module - 
partly nicked from nat core code 
/***************************************************************************
*/ 
static void update_checksum(struct sk_buff *skb) 
{ 
        struct tcphdr *th; 
        struct iphdr * iph; 
        int len; 
        iph = skb->nh.iph; 
        th = (struct tcphdr *)((u_int32_t *)iph + iph->ihl); 
        len = skb->len; 
        /* IP checksum */ 
        iph->check = 0; 
        iph->check = ip_fast_csum((u8 *)iph, iph->ihl); 
        
        if (iph->protocol != IPPROTO_TCP) 
                return; 
        
        th->check = 0; 
        th->check = tcp_v4_check(th, 
                                 len - 4*iph->ihl, 
                                 iph->saddr, iph->daddr, 
                                 csum_partial((char *)th, len-4*iph->ihl,
0)); 
} 
/***************************************************************************
*/ 



-----Original Message----- 
From: Shipman, Jeffrey E [mailto:jeshipm@sandia.gov] 
Sent: Thursday, June 13, 2002 4:11 PM 
To: 'linux-kernel@vger.kernel.org' 
Subject: TCP checksum? 


I'm looking for a function similar to skb_checksum(), but 
for the tcphdr->check field. I'm playing around with a module 
I've written for netfilter and I would like to modify options of 
the IP and TCP headers. For example, right now I'm trying 
to set the destination IP to the source IP, but the TCP checksum 
is coming out incorrectly. How can I calculate this checksum? 
Thanks a lot in advance. Also, if anyone knows where some 
documentation about the TCP/IP stack in the kernel are, please 
let me know. 
Jeff Shipman - CCD 
Sandia National Laboratories 
(505) 844-1158 / MS-1372 


- 
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in 
the body of a message to majordomo@vger.kernel.org 
More majordomo info at  http://vger.kernel.org/majordomo-info.html 
Please read the FAQ at  http://www.tux.org/lkml/ 


Accelerated Encryption Processing Ltd.

Bray Business Park,
Southern Cross Route ,
Bray, Co Wicklow,
Ireland

********************************************************************
This email and any files transmitted with it are confidential 
and intended solely for the use of the individual or entity to
whom they are addressed. If you have received this email
in error please notify the postmaster at the address below.

postmaster@aep.ie

This footnote also confirms that this email message has been
checked the presence of computer viruses.

**********************************************************************

