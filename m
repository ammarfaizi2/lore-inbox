Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbTJNQT6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 12:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbTJNQT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 12:19:58 -0400
Received: from ginger.lcs.mit.edu ([18.26.0.82]:26884 "EHLO ginger.lcs.mit.edu")
	by vger.kernel.org with ESMTP id S262405AbTJNQTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 12:19:53 -0400
Message-Id: <200310141619.h9EGJWWB013461@ginger.lcs.mit.edu>
From: Tim Shepard <shep@alum.mit.edu>
To: davem@redhat.com, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@redhat.com, yoshfuji@linux-ipv6.org, netdev@oss.sgi.com
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix numbering of lines in /proc/net/tcp (linux-2.6.0-test7)
Date: Tue, 14 Oct 2003 12:19:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



While debugging another problem, I noticed that the first number on
each line read from /proc/net/tcp (and from /proc/net/tcp6) was
meaningless.  The netstat program ignores this number, and I know of
no other readers of /proc/net/tcp{,6}.  So perhaps this is only a
cosmetic bug.  Nevertheless, in debugging another problem with the
lines produced by /proc/net/tcp, these meaningless numbers caused
confusion.

On a linux-2.6.0-test7 system, it looks like this:

$ cat /proc/net/tcp
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   1: 0100007F:2260 00000000:0000 0A 00000000:00000000 00:00000000 00000000  1000        0 2253 1 cdb27440 3000 0 0 2 -1                             
   1: 00000000:1F40 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 1862 1 cf1e5060 3000 0 0 2 -1                             
   1: 0100007F:0A43 00000000:0000 0A 00000000:00000000 00:00000000 00000000  1000        0 2259 1 cc949460 3000 0 0 2 -1                             
   1: 00000000:0203 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 1256 1 cf1e53e0 3000 0 0 2 -1                             
   1: 0100007F:2266 00000000:0000 0A 00000000:00000000 00:00000000 00000000  1000        0 2255 1 cc949b60 3000 0 0 2 -1                             
   1: 0100007F:2B48 00000000:0000 0A 00000000:00000000 00:00000000 00000000  1000        0 2257 1 cc9497e0 3000 0 0 2 -1                             
   2: 0100007F:16E9 00000000:0000 0A 00000000:00000000 00:00000000 00000000   103        0 1250 1 cf1e5760 3000 0 0 2 -1                             
   2: 0100007F:2B6F 00000000:0000 0A 00000000:00000000 00:00000000 00000000  1000        0 2261 1 cc9490e0 3000 0 0 2 -1                             
   2: 0100007F:0035 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 1141 1 c13443c0 3000 0 0 2 -1                             
   2: 0100007F:0C38 00000000:0000 0A 00000000:00000000 00:00000000 00000000  1000        0 2265 1 cc927800 3000 0 0 2 -1                             
   2: 0100007F:09DD 00000000:0000 0A 00000000:00000000 00:00000000 00000000  1000        0 2263 1 cc927b80 3000 0 0 2 -1                             
   2: B8425C42:8001 0C00000A:0016 01 00000000:00000000 02:006B7C78 00000000  1000        0 2273 2 cc927100 205 40 0 3 -1                             
   2: B8425C42:8000 52001A12:0016 01 00000000:00000000 02:006B4970 00000000  1000        0 2249 2 cdb270c0 262 40 0 3 -1                             


On a linux-2.4.21 system, this first number just counts up like this:

$ cat /proc/net/tcp                
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:1F40 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 580 1 c702f820 300 0 0 2 -1                               
   1: 00000000:16E9 00000000:0000 0A 00000000:00000000 00:00000000 00000000   101        0 297102 1 c718dba0 300 0 0 2 -1                            
   2: 00000000:006F 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 145 1 c77e5420 300 0 0 2 -1                               
   3: 00000000:1770 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 840 1 c6cf94c0 300 0 0 2 -1                               
   4: 0C00000A:0035 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 2627 1 c5fd2b60 300 0 0 2 -1                              
   5: 92425C42:0035 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 2625 1 c5fd2080 300 0 0 2 -1                              
   6: 0100007F:0035 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 332 1 c718d0c0 300 0 0 2 -1                               
   7: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 76922 1 c2eac880 300 0 0 2 -1                             
   8: 00000000:0019 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 403 1 c718d800 300 0 0 2 -1                               
   9: 0100007F:177A 00000000:0000 0A 00000000:00000000 00:00000000 00000000  1000        0 314391 1 c2eacc20 300 0 0 2 -1                            


However, on a linux-2.4.21 system with ipv6 listeners, the numbers are
shared between ipv4 and ipv6:

$ cat /proc/net/tcp
  sl  local_address rem_address   st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                                     
   0: 00000000:1F40 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 580 1 c702f820 300 0 0 2 -1                               
   1: 00000000:16E9 00000000:0000 0A 00000000:00000000 00:00000000 00000000   101        0 297102 1 c718dba0 300 0 0 2 -1                            
   2: 00000000:006F 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 145 1 c77e5420 300 0 0 2 -1                               
   4: 00000000:1770 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 840 1 c6cf94c0 300 0 0 2 -1                               
   5: 0C00000A:0035 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 2627 1 c5fd2b60 300 0 0 2 -1                              
   6: 92425C42:0035 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 2625 1 c5fd2080 300 0 0 2 -1                              
   7: 0100007F:0035 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 332 1 c718d0c0 300 0 0 2 -1                               
   8: 00000000:0016 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 76922 1 c2eac880 300 0 0 2 -1                             
   9: 00000000:0019 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 403 1 c718d800 300 0 0 2 -1                               
  10: 0100007F:177A 00000000:0000 0A 00000000:00000000 00:00000000 00000000  1000        0 314391 1 c2eacc20 300 0 0 2 -1                            
$ cat /proc/net/tcp6 
  sl  local_address                         remote_address                        st tx_queue rx_queue tr tm->when retrnsmt   uid  timeout inode                                              
   3: 00000000000000000000000000000000:0050 00000000000000000000000000000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 6630 1 c702fbc0 300 0 0 2 -1                       



I am not sure what the behavior is supposed to be.  Is there a spec
anywhere for the interface with /proc/net/tcp?

The patch below changes it to always count up from zero, without
sharing the numbers between ipv4 and ipv6.  This is an improvement
over linux-2.6.0-test7 behavior, but without a spec I cannot be sure
what the correct behavior would be.

This patch can be applied before, after, alone, or with the other patch I
submitted earlier today.   This patch is the less important of the two.

I welcome comments.

			-Tim Shepard
			 shep@alum.mit.edu



--- ../pristine/linux-2.6.0-test7/net/ipv4/tcp_ipv4.c	2003-10-08 15:24:03.000000000 -0400
+++ net/ipv4/tcp_ipv4.c	2003-10-13 22:33:10.000000000 -0400
@@ -2145,7 +2145,6 @@
 
 		if (!sk)
 			continue;
-		++st->num;
 		if (sk->sk_family == st->family) {
 			rc = sk;
 			goto out;
@@ -2159,7 +2158,7 @@
 			for (st->sbucket = 0; st->sbucket < TCP_SYNQ_HSIZE;
 			     ++st->sbucket) {
 				for (req = tp->listen_opt->syn_table[st->sbucket];
-				     req; req = req->dl_next, ++st->num) {
+				     req; req = req->dl_next) {
 					if (req->class->family != st->family)
 						continue;
 					rc = req;
@@ -2181,6 +2180,8 @@
 	struct sock *sk = cur;
 	struct tcp_iter_state* st = seq->private;
 
+	++st->num;
+
 	if (st->state == TCP_SEQ_STATE_OPENREQ) {
 		struct open_request *req = cur;
 
@@ -2188,7 +2189,6 @@
 		req = req->dl_next;
 		while (1) {
 			while (req) {
-				++st->num;
 				if (req->class->family == st->family) {
 					cur = req;
 					goto out;
@@ -2254,7 +2254,6 @@
 		read_lock(&tcp_ehash[st->bucket].lock);
 		sk_for_each(sk, node, &tcp_ehash[st->bucket].chain) {
 			if (sk->sk_family != st->family) {
-				++st->num;
 				continue;
 			}
 			rc = sk;
@@ -2264,7 +2263,6 @@
 		tw_for_each(tw, node,
 			    &tcp_ehash[st->bucket + tcp_ehash_size].chain) {
 			if (tw->tw_family != st->family) {
-				++st->num;
 				continue;
 			}
 			rc = tw;
@@ -2284,12 +2282,13 @@
 	struct hlist_node *node;
 	struct tcp_iter_state* st = seq->private;
 
+	++st->num;
+
 	if (st->state == TCP_SEQ_STATE_TIME_WAIT) {
 		tw = cur;
 		tw = tw_next(tw);
 get_tw:
 		while (tw && tw->tw_family != st->family) {
-			++st->num;
 			tw = tw_next(tw);
 		}
 		if (tw) {
@@ -2311,7 +2310,6 @@
 	sk_for_each_from(sk, node) {
 		if (sk->sk_family == st->family)
 			goto found;
-		++st->num;
 	}
 
 	st->state = TCP_SEQ_STATE_TIME_WAIT;
@@ -2354,6 +2352,8 @@
 
 static void *tcp_seq_start(struct seq_file *seq, loff_t *pos)
 {
+	struct tcp_iter_state* st = seq->private;
+	st->num = 0;
 	return *pos ? tcp_get_idx(seq, *pos - 1) : SEQ_START_TOKEN;
 }
 
