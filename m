Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276021AbRJ2Pkz>; Mon, 29 Oct 2001 10:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276032AbRJ2Pkf>; Mon, 29 Oct 2001 10:40:35 -0500
Received: from pl038.nas921.ichikawa.nttpc.ne.jp ([210.165.234.38]:13329 "EHLO
	mbr.sphere.ne.jp") by vger.kernel.org with ESMTP id <S275990AbRJ2PkZ>;
	Mon, 29 Oct 2001 10:40:25 -0500
Date: Tue, 30 Oct 2001 00:39:09 +0900
From: Bruce Harada <bruce@ask.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: 2.2.0-preXX compile errors solved
Message-Id: <20011030003909.5f60fbd9.bruce@ask.ne.jp>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was getting compile errors for 2.2.20-pre11 on a Slackware 3.6 box. Since the
errors involved undefined symbols and unmatched struct definitions, I made the
silly assumption that I was missing a header file somewhere.

After looking at it a bit more carefully and repatching, I finally noticed that
patch was failing partway through... :(

The problem goes back to 2.2.20-pre4, where the following appears in the section
of the patch relating to arch/ppc/kernel/openpic.c:

-#endif /* CONFIG_PMAC_PBOOK */
\ No newline at end of file    
+#endif /* CONFIG_PMAC_PBOOK */

It would appear that later versions of diff output the "\ No newline..." line
when they find a file that has, surprise surprise, no newline at the end.
What I failed to realise was that older versions of patch (in my case, 2.1b)
choke on this kind of thing with a malformed patch error. I tried a later
version (2.5), which copes with it quite happily.

While I realise that the answer will most likely be "Upgrade your userland!", it
might be a good idea to consider filtering these lines out for the 2.2 series,
since it's more likely to be run on older boxes.

Bruce
