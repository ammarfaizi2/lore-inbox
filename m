Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132226AbRDFTMU>; Fri, 6 Apr 2001 15:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132316AbRDFTML>; Fri, 6 Apr 2001 15:12:11 -0400
Received: from numerator.trivergent.net ([64.89.70.13]:53729 "EHLO
	numerator.trivergent.net") by vger.kernel.org with ESMTP
	id <S132226AbRDFTME>; Fri, 6 Apr 2001 15:12:04 -0400
Message-ID: <3ACE14EA.2030502@trivergent.net>
Date: Fri, 06 Apr 2001 15:11:38 -0400
From: Kevin Stone <kstone@trivergent.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac11 i686; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.3 tcp window id causes problems talking to windows clients
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From linux/include/net/ip.h (2.4.3):

static inline void ip_select_ident(struct iphdr *iph, struct dst_entry *dst)
{
   if (iph->frag_off&__constant_htons(IP_DF))
       iph->id = 0;
   else
       __ip_select_ident(iph, dst);
}

This sets the id on the packet to zero if don't fragment is set.  
Windows however is broken and under certain cirumstances (I think this 
was identified on the list several weeks ago as dialup+compressed 
headers), windows doesn't ack the packets....  The result for the client 
is terrible-- it's like there's no connectivity at all-- web  pages 
never load.. etc.

This problem is fixed in the ac series, but didn't make it into Linus's 
2.4.3.  We're running 2.4.2ac11 right now across the board, and it seems 
to be working quite well (except for the lack of swap reclamation-- I 
appreciate the reasoning, but it makes upgrading older machines very 
difficult.)  However, I would rather, for maintenance and sanity 
reasons, run a stock kernel on production machines.  There are also a 
lot of differences between the ac and stock series-- binfmt_misc as 
filesystem vs. proc, ram filesystem (ex: tmpfs on ac), etc. which we 
use.  (We use binfmt_misc+suexec to run php on webservers.)

Is there any plan to include the zerocopy patches into the stock kernel? 
  The win2k dial-up/window id problem is really a showstopper but hasn't 
generated much traffic on lkml or the digests. 


Thanks!
Kevin

