Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUHVCVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUHVCVV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 22:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbUHVCVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 22:21:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:39061 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265395AbUHVCVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 22:21:17 -0400
Date: Sat, 21 Aug 2004 19:10:50 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Josan Kadett" <corporate@superonline.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Not to suppress NET kernel messages
Message-Id: <20040821191050.43467df6.rddunlap@osdl.org>
In-Reply-To: <S265222AbUHVCKk/20040822021040Z+1376@vger.kernel.org>
References: <S265222AbUHVCKk/20040822021040Z+1376@vger.kernel.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2004 05:10:36 +0200 Josan Kadett wrote:

| I think the messages are rate limited by some code in network subsytem that
| disallows a message from being sent to console for more than once. I am
| trying to add some source debugging functions with printk, and I just wish
| to disable this protection. 

Yes, net/core/utils.c, net_ratelimit() function is used to determine
if messages should be printed or suppressed.  It returns 1 if the
message should be printed, 0 to suppress a message.  Usage is like this:

	if (net_ratelimit())	/* print if non-0 */
		printk(KERN_DEBUG "printing some message\n");

If you want to print all messages (!) and you aren't worried about
DoS or overflowing logs etc., just change the net_ratelimit() function
to return 1 always... and stand back.  Warning, caveat emptor, user beware,
etc.  Void where prohibited.

--
~Randy
