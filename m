Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265954AbUBKTFq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 14:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUBKTFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 14:05:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13793 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265954AbUBKTFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 14:05:32 -0500
Date: Wed, 11 Feb 2004 11:04:39 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Ping Cheng <pingc@wacom.com>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: Wacom USB driver patch
Message-Id: <20040211110439.1a64fe9b.zaitcev@redhat.com>
In-Reply-To: <mailman.1076463721.27289.linux-kernel2news@redhat.com>
References: <mailman.1076463721.27289.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004 17:23:11 -0800
Ping Cheng <pingc@wacom.com> wrote:

>  <<linuxwacom.patch>> 

This looks much better, it's not line-wrapped.

I have one question though, about this part:

@@ -152,15 +150,103 @@ static void wacom_pl_irq(struct urb *urb

+                       /* was entered with stylus2 pressed */
+                       if (wacom->tool[1] == BTN_TOOL_RUBBER && !(data[4] & 0x20) ) {
+                               /* report out proximity for previous tool */
+                               input_report_key(dev, wacom->tool[1], 0);
+                               input_sync(dev);
+                               wacom->tool[1] = BTN_TOOL_PEN;
+                               return;
+                       }

Is it safe to just return without resubmitting the urb here?

@@ -231,8 +317,12 @@ static void wacom_graphire_irq(struct ur
+       /* check if we can handle the data */
+       if (data[0] == 99)
+               return;
+
        if (data[0] != 2)

Same here.

Also, please add the path to the patch, e.g. always use recursive diff.

-- Pete
