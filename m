Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277832AbRJIQ5y>; Tue, 9 Oct 2001 12:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277840AbRJIQ5w>; Tue, 9 Oct 2001 12:57:52 -0400
Received: from smtp010.mail.yahoo.com ([216.136.173.30]:23824 "HELO
	smtp010.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277832AbRJIQ5e>; Tue, 9 Oct 2001 12:57:34 -0400
X-Apparently-From: <trever?adams@yahoo.com>
Subject: iptables in 2.4.10, 2.4.11pre6 problems
From: "Trever L. Adams" <trever_adams@yahoo.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 09 Oct 2001 12:58:24 -0400
Message-Id: <1002646705.2177.9.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing messages such as:

Oct  9 12:52:51 smeagol kernel: Firewall:IN=ppp0 OUT= MAC=
SRC=64.152.2.36 DST=MY_IP_ADDRESS LEN=52 TOS=0x00 PREC=0x00 TTL=246
ID=1093 DF PROTO=TCP SPT=80 DPT=33157 WINDOW=34752 RES=0x00 ACK FIN
URGP=0

In my firewall logs.  I see them for ACK RST as well.  These are valid
connections.  My rules follow for the most part (a few allowed
connections to the machine in question have been removed from the
list).  This often leaves open connections in a half closed state on
machines behind this firewall.  It also some times kills totally open
connections and I see packets rejected that should be allowed through.

Please, help me help.  Also, please CC me.  The account I am subscribed
to the list with is acting up and I may be killing it.

Chain INPUT (policy DROP 3 packets, 999 bytes)
 pkts bytes target     prot opt in     out     source              
destination         
   30  2880 DROP       udp  --  any    any     anywhere            
anywhere           udp spt:netbios-ns 
   33  7607 DROP       udp  --  any    any     anywhere            
anywhere           udp spt:netbios-dgm 
   37  3680 ICMP_INPUT  icmp --  any    any     anywhere            
anywhere           
16543 5783K tcprules   all  --  any    any     anywhere            
anywhere           
    0     0 firewall   all  --  any    any     anywhere            
anywhere           

Chain FORWARD (policy DROP 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source              
destination         
 1485  280K tcprules   all  --  any    any     anywhere            
anywhere           
    0     0 firewall   all  --  any    any     anywhere            
anywhere           

Chain OUTPUT (policy ACCEPT 17692 packets, 6181610 bytes)
 pkts bytes target     prot opt in     out     source              
destination         

Chain ICMP_INPUT (1 references)
 pkts bytes target     prot opt in     out     source              
destination         
   26  2184 ACCEPT     icmp --  !ppp+  any     anywhere            
anywhere           icmp echo-request 
    0     0 ACCEPT     icmp --  any    any     anywhere            
anywhere           icmp echo-reply 
   11  1496 ACCEPT     icmp --  any    any     anywhere            
anywhere           icmp destination-unreachable 
    0     0 LOGACCEPT  icmp --  any    any     anywhere            
anywhere           icmp source-quench 
    0     0 LOGACCEPT  icmp --  any    any     anywhere            
anywhere           icmp time-exceeded 
    0     0 LOGACCEPT  icmp --  any    any     anywhere            
anywhere           icmp parameter-problem 
    0     0 LOGACCEPT  icmp --  any    any     anywhere            
anywhere           icmp timestamp-request 
    0     0 LOGACCEPT  icmp --  any    any     anywhere            
anywhere           icmp timestamp-reply 
    0     0 firewall   icmp --  any    any     anywhere            
anywhere           

Chain LOGACCEPT (5 references)
 pkts bytes target     prot opt in     out     source              
destination         
    0     0 LOG        all  --  any    any     anywhere            
anywhere           LOG level info prefix `PACKET ACCEPTED:' 
    0     0 ACCEPT     all  --  any    any     anywhere            
anywhere           

Chain M_DEBUG (0 references)
 pkts bytes target     prot opt in     out     source              
destination         

Chain firewall (4 references)
 pkts bytes target     prot opt in     out     source              
destination         
  116 18258 LOG        all  --  any    any     anywhere            
anywhere           LOG level info prefix `Firewall:' 
  116 18258 DROP       all  --  any    any     anywhere            
anywhere           

Chain tcprules (2 references)
 pkts bytes target     prot opt in     out     source              
destination         
17325 6007K ACCEPT     all  --  any    any     anywhere            
anywhere           state RELATED,ESTABLISHED 
  587 37774 ACCEPT     all  --  !ppp+  any     anywhere            
anywhere           state NEW 
  116 18258 firewall   all  --  ppp+   any     anywhere            
anywhere           state INVALID,NEW 




_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

