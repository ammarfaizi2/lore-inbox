Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269907AbUJMXKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269907AbUJMXKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 19:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269906AbUJMXKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 19:10:42 -0400
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:28371 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S269907AbUJMXKJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 19:10:09 -0400
Date: Thu, 14 Oct 2004 02:10:07 +0300
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Networking Mailing List <netdev@oss.sgi.com>
Subject: 2.6.9-rc4 tcp_transmit_skb: BUG_ON(!tcp_skb_pcount(skb))
Message-ID: <20041013231006.GA14742@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking Mailing List <netdev@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First I'd like to know is it safe to call get_random_bytes
from net/ipv4/tcp_ipv4.c:tcp_v4_get_port() when I am using
that fortuna [1] patch, which uses CryptoAPI...
fortuna is calling the crypto funcs from softirq AFAICS.
I tried 2.6.9-rc2-bk7 without fortuna and it did not seem
to crash but there has also been some changes into network code...

I ran command
nmap -vvv -O -p1-65535 -T Insane -sT 127.0.0.1
and there are four services listening on that port range.
nmap -sS does not seem to cause BUG.

pencil-and-paper-in-180-seconds follows

tcp_output.c:277
Invalid operand 0
tcp_transmit_skb
tcp_send_synack
tcp_rcv_synsent_state_process
tcp_rcv_state_process
tcp_v4_do_rcv
__release_sock
inet_stream_connect
sys_connect

ohh, and I also have linux-2.6.7-voluntary-preemption.patch
from Redhat Fedora's kernel-2.6.8-1.603.
writing to disk causes max 25ms latency, however 8-|

[1] http://jlcooke.ca/random/
[2] http://safari.iki.fi/config-2.6.9-rc4-20041014-1.txt

NOTE: scripts/ver_linux is buggy, it uses gcc found on PATH instead of
CC from Makefile.  I used gcc-2.95.3 to compile the kernel.

Linux safari.finland.fbi 2.6.9-rc4 #13 Wed Oct 13 23:27:26 EEST 2004 i686 i686 i386 GNU/Linux
 
Gnu C                  3.4.2
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12
mount                  2.12
module-init-tools      3.1-pre5
e2fsprogs              1.35
jfsutils               1.0.24
reiserfsprogs          3.6.18
reiser4progs           line
xfsprogs               2.3.9
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         ip6t_LOG ip6table_filter sch_hfsc cls_fw cls_route
	sch_ingress sch_red sch_tbf sch_teql sch_prio sch_gred cls_rsvp cls_rsvp6
	cls_tcindex sch_cbq sch_dsmark ipt_ttl ipt_tos ipt_tcpmss ipt_sctp ipt_recent
	ipt_pkttype ipt_physdev ipt_nth ipt_mark ipt_mac ipt_iprange ipt_helper ipt_esp
	ipt_ecn ipt_dscp ipt_conntrack ipt_ah ipt_addrtype ipt_ULOG ipt_TTL ipt_TOS
	ipt_TCPMSS ipt_SAME ipt_REDIRECT ipt_NOTRACK ipt_NETMAP ipt_MASQUERADE ipt_MARK
	ipt_IPMARK ipt_DSCP ipt_CLASSIFY ip_queue ip_nat_tftp ip_nat_snmp_basic
	ip_nat_irc ip_nat_ftp ip_nat_amanda ip_conntrack_tftp ip_conntrack_proto_sctp
	ip_conntrack_irc ip_conntrack_ftp ip_conntrack_amanda arptable_filter
	arpt_mangle arp_tables xfs ipv6 snd_seq_midi snd_seq_oss snd_seq_midi_event
	snd_seq lp parport_pc parport w83781d i2c_sensor i2c_piix4 tuner tvaudio
	msp3400 bttv video_buf i2c_algo_bit v4l2_common btcx_risc i2c_core videodev
	ohci_hcd loop ipt_length ipt_connlimit dm_mod ipt_TARPIT ipt_ECN ipt_state
	ipt_multiport ipt_owner cls_u32 sch_sfq sch_htb uhci_hcd ipt_REJECT ipt_LOG
	ipt_limit iptable_raw iptable_mangle iptable_nat snd_ens1371 snd_rawmidi
	ip_conntrack ip6_tables snd_seq_device snd_pcm_oss iptable_filter ip_tables
	snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_ac97_codec snd soundcore
	gameport irlan irda crc_ccitt 8139too mii floppy

-- 

