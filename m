Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265444AbTLHQta (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265432AbTLHQrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:47:19 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:16276 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S265092AbTLHQkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:40:10 -0500
X-Sender-Authentication: net64
Date: Mon, 8 Dec 2003 17:40:08 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-ns83820@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem Report: ns83820 / 802.1Q vlan / 2.4.23
Message-Id: <20031208174008.04bf0014.skraw@ithnet.com>
In-Reply-To: <20031208145622.52d4ea11.skraw@ithnet.com>
References: <20031208145622.52d4ea11.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003 14:56:22 +0100
Stephan von Krawczynski <skraw@ithnet.com> wrote:

> Hello,
> 
> I just experienced a problem with ns83820 and 802.1Q vlan support. It seems
> that incoming packets get dropped if the device is connected to a tagged
> switch port. Reducing the mtu solves the problem but is of course not nice.
> I remember some old docs where it says there can be problems because of the
> oversized tagged packets. Intel e100 seems to work flawlessly in same setup.

Regarding this problem I just did this incredibly complex patch, which seems to
work. Maintainer please beat me...

;-)
Regards,
Stephan


--- drivers/net/ns83820.c-orig  2003-12-08 17:33:14.000000000 +0100
+++ drivers/net/ns83820.c       2003-12-08 17:33:31.000000000 +0100
@@ -141,7 +141,7 @@
 #define NR_TX_DESC     128
 
 /* not tunable */
-#define REAL_RX_BUF_SIZE (RX_BUF_SIZE + 14)    /* rx/tx mac addr + type */
+#define REAL_RX_BUF_SIZE (RX_BUF_SIZE + 14 + 4)        /* rx/tx mac addr + type + vlan*/
 
 #define MIN_TX_DESC_FREE       8
 
