Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265054AbUETOB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265054AbUETOB7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 10:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbUETOB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 10:01:59 -0400
Received: from mx2.elte.hu ([157.181.151.9]:64213 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265054AbUETOB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 10:01:58 -0400
Date: Thu, 20 May 2004 16:03:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: overlaping printk
Message-ID: <20040520140330.GA1499@elte.hu>
References: <Pine.GSO.4.58.0405191848430.10266@stekt37> <Pine.GSO.4.33.0405191153500.14297-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0405191153500.14297-100000@sweetums.bluetronic.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ricky Beam <jfbeam@bluetronic.net> wrote:

> It looks like somewhere in the path of release_console_sem() more than
> one CPU is running the log. [...]

the problem is this code in printk:

        if (oops_in_progress) {
                /* If a crash is occurring, make sure we can't deadlock */
                spin_lock_init(&logbuf_lock);
                /* And make sure that we print immediately */
                init_MUTEX(&console_sem);
        }

so two crashes on two separate CPUs can go on in parallel. The problem
is not constrained to the serial line - i've seen it on VGA too (albeit
there it's much more rare).

	Ingo
