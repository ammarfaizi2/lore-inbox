Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263022AbSJGNVW>; Mon, 7 Oct 2002 09:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263024AbSJGNVW>; Mon, 7 Oct 2002 09:21:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19205 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263022AbSJGNVW>;
	Mon, 7 Oct 2002 09:21:22 -0400
Date: Mon, 7 Oct 2002 14:27:00 +0100
From: Matthew Wilcox <willy@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: 2.5.40 sane minimum proc count
Message-ID: <20021007142700.I18545@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 8;
 
- init_task.rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
- init_task.rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
+ /*
+ * we need to allow at least 10 threads to boot a system
+ */
+ init_task.rlim[RLIMIT_NPROC].rlim_cur = max(10, max_threads/2);
+ init_task.rlim[RLIMIT_NPROC].rlim_max = max(10, max_threads/2);

why not simply:

	max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 8;

+	/* we need to allow at least 20 threads to boot a system */
+	if (max_threads < 20)
+		max_threads = 20;
+
	init_task.rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
	init_task.rlim[RLIMIT_NPROC].rlim_max = max_threads/2;

i think we're going to see more kernel threads with 2.5 than we did with 2.4;
let's be safer.

-- 
Revolutions do not require corporate support.
