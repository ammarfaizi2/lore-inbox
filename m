Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264190AbTDPJVc (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 05:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264191AbTDPJVc 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 05:21:32 -0400
Received: from mail.ithnet.com ([217.64.64.8]:21767 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S264190AbTDPJVa 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 05:21:30 -0400
Date: Wed, 16 Apr 2003 11:33:02 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Arno Wilhelm <a.wilhelm@phion.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel 2.4.20 crashes when a second isdn channel is
 opened by ibod
Message-Id: <20030416113302.1fef0dcc.skraw@ithnet.com>
In-Reply-To: <3E9D1A2D.1020109@phion.com>
References: <3E9D1A2D.1020109@phion.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is known and fixed by Patrick McHardy <kaber@trash.net>.
Please use patch attached and confirm it works. Thank you.


See Changelog

On Wed, 16 Apr 2003 10:54:05 +0200
Arno Wilhelm <a.wilhelm@phion.com> wrote:

> Hello,
> 
> I guess we have detected a kernel bug in the isdn subsystem ( isdn_ppp.c ).
> I have enclosed the bug report in this mail in the format that is asked by
> the file "REPORTING-BUGS" in the kernel source directory.
> If you need further assistance please mail to: a.wilhelm@phion.com
> 
> 
> 
> Regards,
> 
> 			Arno Wilhelm

-- 
Regards,
Stephan

diff -Nru a/drivers/isdn/isdn_net.c b/drivers/isdn/isdn_net.c
--- a/drivers/isdn/isdn_net.c   Thu Mar 27 02:00:21 2003
+++ b/drivers/isdn/isdn_net.c   Thu Mar 27 02:00:21 2003
@@ -2831,6 +2831,7 @@
 
                        /* If binding is exclusive, try to grab the channel */
                        save_flags(flags);
+                       cli();
                        if ((i = isdn_get_free_channel(ISDN_USAGE_NET,
                                lp->l2_proto, lp->l3_proto, drvidx,
                                chidx, lp->msn)) < 0) {
diff -Nru a/drivers/isdn/isdn_ppp.c b/drivers/isdn/isdn_ppp.c
--- a/drivers/isdn/isdn_ppp.c   Thu Mar 27 02:00:21 2003
+++ b/drivers/isdn/isdn_ppp.c   Thu Mar 27 02:00:21 2003
@@ -1176,7 +1176,7 @@
        if (!lp) {
                printk(KERN_WARNING "%s: all channels busy - requeuing!\n", netdev->name);
                retval = 1;
-               goto unlock;
+               goto out;
        }
        /* we have our lp locked from now on */
 


