Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263245AbREWUWy>; Wed, 23 May 2001 16:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263247AbREWUWp>; Wed, 23 May 2001 16:22:45 -0400
Received: from ns.suse.de ([213.95.15.193]:37649 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S263246AbREWUWi>;
	Wed, 23 May 2001 16:22:38 -0400
Date: Wed, 23 May 2001 22:21:37 +0200
From: Andi Kleen <ak@suse.de>
To: "David Gordon (LMC)" <David.Gordon@ericsson.ca>
Cc: Andi Kleen <ak@suse.de>,
        "David Gordon (LMC)" <David.Gordon@lmc.ericsson.se>,
        linux-kernel@vger.kernel.org,
        "Ibrahim Haddad (LMC)" <Ibrahim.Haddad@lmc.ericsson.se>
Subject: Re: IPv6 implementation in kernel 2.4.4 oopses
Message-ID: <20010523222137.A874@gruyere.muc.suse.de>
In-Reply-To: <3B0C0D0B.2010101@lmc.ericsson.se> <20010523214654.A779@gruyere.muc.suse.de> <3B0C15F3.1070408@lmc.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B0C15F3.1070408@lmc.ericsson.se>; from David.Gordon@ericsson.ca on Wed, May 23, 2001 at 03:56:35PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 03:56:35PM -0400, David Gordon (LMC) wrote:
>  >>EIP; c0237bc4 <ipv6_addr_type+4/e0> <=====
> 
> What exactly was the problem that was fixed in the latest pre kernel ?


A coding mistake was fixed.

Here is the patch if you're interested (cut'n'pasted so not applicable)


RCS file: /cvs/linux/net/ipv6/ndisc.c,v
retrieving revision 1.49
retrieving revision 1.50
diff -u -u -r1.49 -r1.50
--- net/ipv6/ndisc.c    2001/05/03 07:02:47     1.49
+++ net/ipv6/ndisc.c    2001/05/05 01:59:27     1.50
@@ -382,7 +382,7 @@
        int send_llinfo;
 
        len = sizeof(struct icmp6hdr) + sizeof(struct in6_addr);
-       send_llinfo = dev->addr_len && ipv6_addr_type(saddr) != IPV6_ADDR_ANY;
+       send_llinfo = dev->addr_len && saddr && ipv6_addr_type(saddr) != IPV6_AD
DR_ANY;
        if (send_llinfo)
                len += NDISC_OPT_SPACE(dev->addr_len);
 

