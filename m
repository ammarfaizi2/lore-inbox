Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVHGD2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVHGD2X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 23:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVHGD2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 23:28:23 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:34392 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750796AbVHGD2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 23:28:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding;
  b=hKggHQ1wLdbdOnGLl85+ZPpJnzeH8lqbETz+dh+8dqBgoFqg/Z7sdeS7t2xn/sCXQBj7YIurcP8MnIn21X/2yOJhhWuMdrB8kpekKB0NqpzXjXYgjJJCOBM6MTVPTIsjnqo1CvniByM2dVJ5sJDl4itvfzQIgcJmcMJV0zN6LR0=  ;
Message-ID: <42F57FCA.9040805@yahoo.com.au>
Date: Sun, 07 Aug 2005 13:28:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC][patch 0/2] mm: remove PageReserved
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'll be looking to send these off to Andrew after 2.6.14 opens,
with the aim of having them merged by 2.6.15 hopefully.

It doesn't look like they'll be able to easily free up a page
flag for 2 reasons. First, PageReserved will probably be kept
around for at least one release. Second, swsusp and some arch
code (ioremap) wants to know about struct pages that don't point
to valid RAM - currently they use PageReserved, but we'll probably
just introduce a PageValidRAM or something when PageReserved goes.

I believe this makes memory management cleaner and easier to
understand. My other reason behind this is that the lockless
pagecache patches needs it for sane page refcounting.

If anyone has an issue with the patches or my merge plan, let's
get some discussion going.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
