Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbUKOIGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbUKOIGL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 03:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbUKOIGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 03:06:11 -0500
Received: from [62.206.217.67] ([62.206.217.67]:62186 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261545AbUKOIFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 03:05:48 -0500
Message-ID: <41986353.1020800@trash.net>
Date: Mon, 15 Nov 2004 09:05:39 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041008 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: David Ford <david+challenge-response@blue-labs.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>, sri@us.ibm.com,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: iptables OOPS (all recent kernels on x86_64)
References: <41984CCC.9040800@blue-labs.org>
In-Reply-To: <41984CCC.9040800@blue-labs.org>
Content-Type: multipart/mixed;
 boundary="------------080304030000090608080807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080304030000090608080807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David Ford wrote:

> Up until 2.6.9, when I changed link status after the initial 
> configuration, I would get a kernel OOPS.  Now with 2.6.9, I get a 
> crash immediately on boot with network device configuration.   
> Attached is my boot log.

Apparently SCTP corrupted the inetaddr notifier chain by registering
the same notifier_block for IPv4 and IPv6, so masq_inet_event got a
struct inet6_ifaddr instead of a struct in_ifaddr. This patch should
fix it.

Regards
Patrick

>
>
> general protection fault: 0000 [1] PREEMPT
> CPU 0
> Modules linked in: ipt_TCPMSS ipt_REJECT iptable_filter iptable_mangle 
> ipt_MASQUERADE ipt_REDIRECT ipta
> Pid: 841, comm: ip Not tainted 2.6.9
> RIP: 0010:[<ffffffffa00494a8>] 
> <ffffffffa00494a8>{:ipt_MASQUERADE:device_cmp+152}
> RSP: 0018:000001003a883c08  EFLAGS: 00010202
> RAX: 82f363feffa60e02 RBX: 0000010006260d90 RCX: ffffff000032c000
> RDX: ffffff000032cc40 RSI: 0000010006260d90 RDI: 0000010038077658
> RBP: 0000010038077658 R08: 0000000000000000 R09: 000001003ae4ea88
> R10: 0000000000000000 R11: 000001003c4aa3c0 R12: 0000000000000000
> R13: ffffffffa0049410 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000002a959a6d40(0000) GS:ffffffff808f0d00(0000) 
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 0000002a9582f6d0 CR3: 0000000000101000 CR4: 00000000000006e0
> Process ip (pid: 841, threadinfo 000001003a882000, task 0000010037864cf0)
> Stack: 0000010038077820 000001003a883c34 0000010006260d90 
> ffffffffa002e7ef
>       0000000000000001 000000c4805da6c9 ffffffffa004a400 0000010006260d90
>       0000000000000001 000001003ae2a4d8
> Call Trace:<ffffffffa002e7ef>{:ip_conntrack:ip_ct_selective_cleanup+271}
>       <ffffffffa0049559>{:ipt_MASQUERADE:masq_inet_event+25}
>       <ffffffff801535f0>{notifier_call_chain+32} 
> <ffffffff8058af01>{ipv6_add_addr+1361}
>       <ffffffff8058e466>{addrconf_add_linklocal+22} 
> <ffffffff8059226f>{addrconf_notify+2383}
>       <ffffffff80530cf5>{rt_cache_flush+581} 
> <ffffffff801535f0>{notifier_call_chain+32}
>       <ffffffff804fc36c>{dev_open+124} 
> <ffffffff804fde18>{dev_change_flags+104}
>       <ffffffff80562755>{devinet_ioctl+773} 
> <ffffffff80563e6c>{inet_ioctl+92}
>       <ffffffff804f1353>{sock_ioctl+867} 
> <ffffffff801b586d>{sys_ioctl+1117}
>       <ffffffff80110f4a>{system_call+126}
>
> Code: 48 8b 00 8b 40 50 39 85 98 01 00 00 75 12 8b 43 24 39 85 e0
> RIP <ffffffffa00494a8>{:ipt_MASQUERADE:device_cmp+152} RSP 
> <000001003a883c08>
> <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
> <0>Rebooting in 20 seconds..cable
>


--------------080304030000090608080807
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/11/15 08:58:09+01:00 kaber@coreworks.de 
#   [SCTP]: Fix inetaddr notifier chain corruption
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
# 
# net/sctp/protocol.c
#   2004/11/15 08:58:03+01:00 kaber@coreworks.de +3 -3
#   [SCTP]: Fix inetaddr notifier chain corruption
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
# 
# net/sctp/ipv6.c
#   2004/11/15 08:58:03+01:00 kaber@coreworks.de +6 -3
#   [SCTP]: Fix inetaddr notifier chain corruption
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
# 
diff -Nru a/net/sctp/ipv6.c b/net/sctp/ipv6.c
--- a/net/sctp/ipv6.c	2004-11-15 08:58:42 +01:00
+++ b/net/sctp/ipv6.c	2004-11-15 08:58:42 +01:00
@@ -78,7 +78,10 @@
 
 #include <asm/uaccess.h>
 
-extern struct notifier_block sctp_inetaddr_notifier;
+extern int sctp_inetaddr_event(struct notifier_block *, unsigned long, void *);
+static struct notifier_block sctp_inet6addr_notifier = {
+	.notifier_call = sctp_inetaddr_event,
+};
 
 /* ICMP error handler. */
 void sctp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
@@ -983,7 +986,7 @@
 	sctp_register_af(&sctp_ipv6_specific);
 
 	/* Register notifier for inet6 address additions/deletions. */
-	register_inet6addr_notifier(&sctp_inetaddr_notifier);
+	register_inet6addr_notifier(&sctp_inet6addr_notifier);
 	rc = 0;
 out:
 	return rc;
@@ -999,6 +1002,6 @@
 	inet6_del_protocol(&sctpv6_protocol, IPPROTO_SCTP);
 	inet6_unregister_protosw(&sctpv6_seqpacket_protosw);
 	inet6_unregister_protosw(&sctpv6_stream_protosw);
-	unregister_inet6addr_notifier(&sctp_inetaddr_notifier);
+	unregister_inet6addr_notifier(&sctp_inet6addr_notifier);
 	sk_free_slab(&sctpv6_prot);
 }
diff -Nru a/net/sctp/protocol.c b/net/sctp/protocol.c
--- a/net/sctp/protocol.c	2004-11-15 08:58:42 +01:00
+++ b/net/sctp/protocol.c	2004-11-15 08:58:42 +01:00
@@ -622,8 +622,8 @@
 /* Event handler for inet address addition/deletion events.
  * Basically, whenever there is an event, we re-build our local address list.
  */
-static int sctp_inetaddr_event(struct notifier_block *this, unsigned long ev,
-			       void *ptr)
+int sctp_inetaddr_event(struct notifier_block *this, unsigned long ev,
+                        void *ptr)
 {
 	unsigned long flags;
 
@@ -824,7 +824,7 @@
 };
 
 /* Notifier for inetaddr addition/deletion events.  */
-struct notifier_block sctp_inetaddr_notifier = {
+static struct notifier_block sctp_inetaddr_notifier = {
 	.notifier_call = sctp_inetaddr_event,
 };
 

--------------080304030000090608080807--
