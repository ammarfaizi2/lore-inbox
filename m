Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289901AbSBFBfz>; Tue, 5 Feb 2002 20:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289917AbSBFBfp>; Tue, 5 Feb 2002 20:35:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45583 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289901AbSBFBfd>; Tue, 5 Feb 2002 20:35:33 -0500
Date: Tue, 5 Feb 2002 17:33:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave McCracken <dmccr@us.ibm.com>
cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.5.3] Changes to signal to better support thread groups
In-Reply-To: <94810000.1012597690@baldur>
Message-ID: <Pine.LNX.4.33.0202051730400.23078-100000@athlon.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oh, btw - another thing:
 when you re-send with a non-broken mailer, could you please also change
all the duplication of the

+                               /*
+                                 *  If this task is in a thread group, make sure
+                                 *  this signal kills all tasks in the group.
+                                 */
+                                if (info.si_code != SI_TKILL) {
+                                        struct task_struct *task;
+
+                                       for_each_thread(task) {
+                                                force_sig_info(signr, &info, task);
+                                        }
+                                }
+
                                do_exit(exit_code);

to use some common routine instead of being duplicated for each
architecture. It should be easy enough to do all of this in a

	do_signal_exit(signr, &info, exit_code);

and not have the same logic duplicated N times.

		Linus

