Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTGGBFP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 21:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264152AbTGGBFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 21:05:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12811 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264095AbTGGBFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 21:05:02 -0400
To: linux-kernel@vger.kernel.org
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel oops with .74 snapshot.
Date: Sun, 06 Jul 2003 18:19:29 -0700
Organization: Open Source Development Labs
Message-ID: <1057540770.215922@palladium.transmeta.com>
References: <87n0frp4v1.fsf@enki.rimspace.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1102352.1rsrL49xfO"
Content-Transfer-Encoding: 7Bit
X-Trace: palladium.transmeta.com 1057540770 21815 127.0.0.1 (7 Jul 2003 01:19:30 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 7 Jul 2003 01:19:30 GMT
User-Agent: KNode/0.7.2
Cache-Post-Path: palladium.transmeta.com!unknown@torvalds-home.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1102352.1rsrL49xfO
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit

Daniel Pittman wrote:
>
> I got the following series of oops reports when booting a .74 snapshot.
> Following is information on the latest changeset in the CVS export
> server, and the reports.

Just out of interest, does this fix it for you? It looks sane, but since
David is off for the weekend, I don't want to apply it without some serious
feedback that "yes, it fixes the problem".

                Linus

--nextPart1102352.1rsrL49xfO
Content-Type: text/x-diff; name="network-bug"
Content-Transfer-Encoding: 8Bit
Content-Disposition: attachment; filename="network-bug"

Index: linux-2.5/net/ipv4/igmp.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv4/igmp.c,v
retrieving revision 1.29
diff -u -r1.29 igmp.c
--- linux-2.5/net/ipv4/igmp.c	1 Jul 2003 16:42:06 -0000	1.29
+++ linux-2.5/net/ipv4/igmp.c	3 Jul 2003 05:06:18 -0000
@@ -2099,7 +2099,7 @@
 	struct in_device *in_dev;
 };
 
-#define	igmp_mc_seq_private(seq)	((struct igmp_mc_iter_state *)&seq->private)
+#define	igmp_mc_seq_private(seq)	((struct igmp_mc_iter_state *)(seq)->private)
 
 static inline struct ip_mc_list *igmp_mc_get_first(struct seq_file *seq)
 {
@@ -2254,7 +2254,7 @@
 	struct ip_mc_list *im;
 };
 
-#define igmp_mcf_seq_private(seq)	((struct igmp_mcf_iter_state *)&seq->private)
+#define igmp_mcf_seq_private(seq)	((struct igmp_mcf_iter_state *)(seq)->private)
 
 static inline struct ip_sf_list *igmp_mcf_get_first(struct seq_file *seq)
 {
Index: linux-2.5/net/ipv4/raw.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv4/raw.c,v
retrieving revision 1.32
diff -u -r1.32 raw.c
--- linux-2.5/net/ipv4/raw.c	1 Jul 2003 16:42:06 -0000	1.32
+++ linux-2.5/net/ipv4/raw.c	3 Jul 2003 05:06:18 -0000
@@ -687,7 +687,7 @@
 	int bucket;
 };
 
-#define raw_seq_private(seq) ((struct raw_iter_state *)&seq->private)
+#define raw_seq_private(seq) ((struct raw_iter_state *)(seq)->private)
 
 static struct sock *raw_get_first(struct seq_file *seq)
 {
Index: linux-2.5/net/ipv6/anycast.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv6/anycast.c,v
retrieving revision 1.4
diff -u -r1.4 anycast.c
--- linux-2.5/net/ipv6/anycast.c	1 Jul 2003 16:42:06 -0000	1.4
+++ linux-2.5/net/ipv6/anycast.c	3 Jul 2003 05:06:18 -0000
@@ -441,7 +441,7 @@
 	struct inet6_dev *idev;
 };
 
-#define ac6_seq_private(seq)	((struct ac6_iter_state *)&seq->private)
+#define ac6_seq_private(seq)	((struct ac6_iter_state *)(seq)->private)
 
 static inline struct ifacaddr6 *ac6_get_first(struct seq_file *seq)
 {
Index: linux-2.5/net/ipv6/ip6_flowlabel.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv6/ip6_flowlabel.c,v
retrieving revision 1.5
diff -u -r1.5 ip6_flowlabel.c
--- linux-2.5/net/ipv6/ip6_flowlabel.c	1 Jul 2003 16:42:06 -0000	1.5
+++ linux-2.5/net/ipv6/ip6_flowlabel.c	3 Jul 2003 05:06:18 -0000
@@ -559,7 +559,7 @@
 	int bucket;
 };
 
-#define ip6fl_seq_private(seq)	((struct ip6fl_iter_state *)&(seq)->private)
+#define ip6fl_seq_private(seq)	((struct ip6fl_iter_state *)(seq)->private)
 
 static struct ip6_flowlabel *ip6fl_get_first(struct seq_file *seq)
 {
Index: linux-2.5/net/ipv6/mcast.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv6/mcast.c,v
retrieving revision 1.25
diff -u -r1.25 mcast.c
--- linux-2.5/net/ipv6/mcast.c	1 Jul 2003 16:42:06 -0000	1.25
+++ linux-2.5/net/ipv6/mcast.c	3 Jul 2003 05:06:18 -0000
@@ -2045,7 +2045,7 @@
 	struct inet6_dev *idev;
 };
 
-#define igmp6_mc_seq_private(seq)	((struct igmp6_mc_iter_state *)&seq->private)
+#define igmp6_mc_seq_private(seq)	((struct igmp6_mc_iter_state *)(seq)->private)
 
 static inline struct ifmcaddr6 *igmp6_mc_get_first(struct seq_file *seq)
 {
@@ -2185,7 +2185,7 @@
 	struct ifmcaddr6 *im;
 };
 
-#define igmp6_mcf_seq_private(seq)	((struct igmp6_mcf_iter_state *)&seq->private)
+#define igmp6_mcf_seq_private(seq)	((struct igmp6_mcf_iter_state *)(seq)->private)
 
 static inline struct ip6_sf_list *igmp6_mcf_get_first(struct seq_file *seq)
 {
Index: linux-2.5/net/ipv6/raw.c
===================================================================
RCS file: /home/cvs/linux-2.5/net/ipv6/raw.c,v
retrieving revision 1.31
diff -u -r1.31 raw.c
--- linux-2.5/net/ipv6/raw.c	1 Jul 2003 16:42:06 -0000	1.31
+++ linux-2.5/net/ipv6/raw.c	3 Jul 2003 05:06:18 -0000
@@ -913,7 +913,7 @@
 	int bucket;
 };
 
-#define raw6_seq_private(seq) ((struct raw6_iter_state *)&seq->private)
+#define raw6_seq_private(seq) ((struct raw6_iter_state *)(seq)->private)
 
 static struct sock *raw6_get_first(struct seq_file *seq)
 {

--nextPart1102352.1rsrL49xfO--
