Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbULTHyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbULTHyX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 02:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbULTHxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 02:53:36 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:12980 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261482AbULTGvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 01:51:14 -0500
Message-ID: <1329986.1103525472726.JavaMail.tomcat@pne-ps1-sn1>
Date: Mon, 20 Dec 2004 07:51:12 +0100 (MET)
From: Voluspa <lista4@comhem.se>
Reply-To: lista4@comhem.se
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, mr@ramendik.ru, kernel@kolivas.org,
       riel@redhat.com
Mime-Version: 1.0
Content-Type: text/plain;charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: CP Presentation Server
X-clientstamp: [213.64.150.229]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bingo.

[PATCH] token based thrashing control
http://marc.theaimsgroup.com/?l=bk-commits-head&m=109330925227996&w=2

Backing that one out 2.6.9-rc1 behaves just like 2.6.8.1-bk2, ie no freezes and 
swapping done in 1 minute in my testcase. Tested both with and without lapic=lapic 
(due to my own mind demons ;-)

If someone doubt my ability to back out a patch, here's how it looked:

root:loke:/usr/src/debug/1-mydebug/linux-2.6.9-rc1-debug-notoken# patch -
Rp1 -i
../token.patch
patching file include/linux/sched.h
patching file include/linux/swap.h
patching file kernel/fork.c
patching file mm/Makefile
patching file mm/filemap.c
Hunk #1 succeeded at 1246 (offset 51 lines).
patching file mm/memory.c
patching file mm/rmap.c
patching file mm/thrash.c

Then I diffed the original tree and this notoken-tree and eyeball-compared it 
with the patch (had to first delete a mm/filemap.c~ backup left by the patch 
program). Was all OK.

Would be nice though if someone else could verify...

This is also that time of the year when no strict timetables can be made. I'll 
be available on and off for the next 48 hours if some testing needs to be 
done.

Mvh
Mats Johannesson

