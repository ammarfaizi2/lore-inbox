Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278968AbRKFLUO>; Tue, 6 Nov 2001 06:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279013AbRKFLUE>; Tue, 6 Nov 2001 06:20:04 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:55968 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S278968AbRKFLTx>;
	Tue, 6 Nov 2001 06:19:53 -0500
Date: Tue, 6 Nov 2001 12:19:47 +0100
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: linux-kernel@vger.kernel.org
Subject: ip_conntrack & timing out of connections
Message-ID: <20011106121947.A678@schmorp.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: Linux version 2.4.13-ac5 (root@cerebro) (gcc version 2.95.4 20010319 (prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-2.4.13-ac5 (other versions untested) has this peculiar behaviour: If I
"killall -STOP thttpd", I, of course, still get connection requests which
usually time out:

tcp      238      0 217.227.148.85:80       213.76.191.129:3120 CLOSE_WAIT  
tcp      162      0 217.227.148.85:80       213.76.191.129:3128 CLOSE_WAIT  
tcp      238      0 217.227.148.85:80       213.76.191.129:3136 CLOSE_WAIT  
tcp      162      0 217.227.148.85:80       213.76.191.129:3152 CLOSE_WAIT  
tcp      134      0 217.227.148.85:80       66.42.121.15:3305 CLOSE_WAIT  
tcp      162      0 217.227.148.85:80       213.76.191.129:3160 CLOSE_WAIT  
tcp      279      0 217.227.148.85:80       62.83.11.19:2742 CLOSE_WAIT  

however, after some time, I get many of these messages:

Nov  6 02:39:55 doom kernel: ip_conntrack: table full, dropping packet. 

/proc/net/ip_conntrack has lots of connections like these:

tcp      6 430665 ESTABLISHED src=213.76.191.129 dst=217.227.148.85 sport=3881 dport=80 src=217.227.148.85 dst=213.76.191.129 sport=80 dport=388 1 [ASSURED] use=1 

that is, connections to port 80. a grep dport=80 in ip_conntrack gives me
3768 lines, where netstat -t only shows 159 connections, so it seems that
conntrack has a problems with time-outs (or something similar).

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
