Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268263AbUIWENw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268263AbUIWENw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 00:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268255AbUIWENA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 00:13:00 -0400
Received: from [62.206.217.67] ([62.206.217.67]:12166 "EHLO gw.localnet")
	by vger.kernel.org with ESMTP id S268263AbUIWELe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 00:11:34 -0400
Message-ID: <41524CEE.2020508@trash.net>
Date: Thu, 23 Sep 2004 06:11:26 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Mathieu_B=E9rard?= <Mathieu.Berard@crans.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops with racoon and linux-2.6.9-rc2-mm1
References: <41520074.3080706@crans.org>
In-Reply-To: <41520074.3080706@crans.org>
Content-Type: multipart/mixed;
 boundary="------------030700000108060609050100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030700000108060609050100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Should be fixed by this patch.

Regards
Patrick

Mathieu Bérard wrote:

> Hi,
>
> I get this Oops using racoon and linux 2.6.9-rc2-mm1,
> though everything run smoothly with a 2.6.8 kernel.
>
> Here the oops (copied by hand):
>
> Warning: kfree_skb on hard IRQ 000000c0
> scheduling while atomic: racoon/0xffffff00/1680
> [<c027c7bb>] schedule+0x32b/0x480
> [<c0114a4a>] sys_sched_yield+0x1a/0x20
> [<c0153e3b>] coredump_wait+0x2b/0x90
> [<c0153f6a>] do_coredump+0xca/0x1a1
> [<c0132d1d>] buffered_rmqueue+0xdd/0x1b0
> [<c0128290>] autoremove_wake_function+0x0/0x50
> [<c011f365>] __dequeue_signal+0xe5/0x150
> [<c011f3f3>] dequeue_signal+0x23/0x90
> [<c0120b8d>] get_signal_to_deliver+0x24d/0x300
> [<c0103c6f>] do_signal+0x8f/0x160
> [<c015a2e0>] __pollwait+0x0/0xc0
> [<c0227687>] sys_recv+0x37/0x40
> [<c010618c>] do_IRQ+0xec/0x190
> [<c0112a90>] do_page_fault+0x0/0x575
> [<c0103d77>] do_notify_resume+0x37/0x3c
> [<c0103f1a>] work_notifysig+0x13/0x15
> Kernel panic - not syncing: Aiee, killing interrupt handler!
>


--------------030700000108060609050100
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/23 06:05:52+02:00 kaber@coreworks.de 
#   [XFRM]: Fix unbalanced spin_unlock_bh
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
# 
# net/xfrm/xfrm_state.c
#   2004/09/23 06:05:25+02:00 kaber@coreworks.de +0 -1
#   [XFRM]: Fix unbalanced spin_unlock_bh
#   
#   Signed-off-by: Patrick McHardy <kaber@trash.net>
# 
diff -Nru a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
--- a/net/xfrm/xfrm_state.c	2004-09-23 06:07:23 +02:00
+++ b/net/xfrm/xfrm_state.c	2004-09-23 06:07:23 +02:00
@@ -592,7 +592,6 @@
 		list_for_each_entry(x, xfrm_state_bydst+i, bydst) {
 			if (x->km.seq == seq) {
 				xfrm_state_hold(x);
-				spin_unlock_bh(&xfrm_state_lock);
 				return x;
 			}
 		}

--------------030700000108060609050100--
