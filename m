Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUBPLmb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 06:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbUBPLmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 06:42:31 -0500
Received: from gate.corvil.net ([213.94.219.177]:20741 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261605AbUBPLm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 06:42:29 -0500
Message-ID: <4030ACA3.6020009@draigBrady.com>
Date: Mon, 16 Feb 2004 11:42:27 +0000
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: IDE and locking
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm working on an embedded system here that
basically counts ethernet packets. I'm using
2.4.20 and I'm noticing that when files are
read from the compact flash (ext2), ethernet
packets are being dropped.

So to work around the problem, I'm precaching
all the files (12MB) at boot like:
find / -type f | while read file; do dd if=$file of=/dev/null; done

So questions.

1. Is this due to the BKL around the IDE subsystem?
2. Are writes as susceptible as reads to the problem?
    I'm guessing if the compact flash had a write cache
    buffer I would be OK as I only write max 2MB at a time?
3. There was talk about removing the BKL in 2.6 with
    reference to:
    http://sourceforge.net/project/showfiles.php?group_id=8875
    Has this work been included?
4. Is there a max number of files that can be cached by linux?
5. Will the files be removed at any stage from the cache
    if there is no memory pressure?
6. Can I reserve memory for the file cache?

cheers.
-- 
Pádraig Brady - http://www.pixelbeat.org

