Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbUKWEuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbUKWEuM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 23:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbUKWEtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 23:49:49 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:8776 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262235AbUKWEM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 23:12:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=bnWyhY3iSZ6yS5U2bK5kYtyUePOtubla8Tp9UKZdkMuBzYO7ye+TkfSr+U5rpxOscxrBB3T0TTxDQRqgi8KEGzE+qkL3fj55i7C77mJzGd2iOt47C/BylRGPQdSmgoF8CwRD4lq8A+g7rV1Ih3kK7Afv0/0YyAqs0oMWjqn1D6A=
Message-ID: <19f134cc04112220125461595d@mail.gmail.com>
Date: Tue, 23 Nov 2004 09:42:18 +0530
From: Pradeep Anbumani <pradeepdreams@gmail.com>
Reply-To: Pradeep Anbumani <pradeepdreams@gmail.com>
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ACK Flooding
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wanna analyse how the Linux Kernel reacts for the change I've made.
I've changed the tcp_input.c file and the function is
"__tcp_ack_snd_check()" function.........and added a loop of 100
acks.....generation .....The behavior of TCP is not as expected after
adding this piece of code....

If anybody could tell me what changes had to be made to get the
desired output..the desired output is TCP as per the conventional
behaviour has to increase the transmission rate as it gets more
duplicate acknowledgements....

static __inline__ void __tcp_ack_snd_check(struct sock *sk, int ofo_possible)
 {       int i=0;
         struct tcp_opt *tp = &(sk->tp_pinfo.af_tcp);

3009             /* More than one full frame received... */
3010         if (((tp->rcv_nxt - tp->rcv_wup) > tp->ack.rcv_mss
3011              /* ... and right edge of window advances far enough.
3012               * (tcp_recvmsg() will send ACK otherwise). Or...
3013               */
3014              && __tcp_select_window(sk) >= tp->rcv_wnd) ||
3015             /* We ACK each frame or... */
3016             tcp_in_quickack_mode(tp) ||
3017             /* We have out of order data. */
3018             (ofo_possible &&
3019              skb_peek(&tp->out_of_order_queue) != NULL)) {
3020                 /* Then ack it now */
                       for(i=0;i<100;i++){ /* My CHANGES ONLY THIS FOR LOOP
                       tcp_send_ack(sk);
                       }
3022         } else {
3023                 /* Else, send delayed ack. */
3024                 tcp_send_delayed_ack(sk);
3025         }
3026 }

Pradeep
