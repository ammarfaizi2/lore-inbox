Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267297AbTGHM4z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 08:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267298AbTGHM4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 08:56:55 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:21400 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S267297AbTGHM4b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 08:56:31 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16138.49898.424148.525523@laputa.namesys.com>
Date: Tue, 8 Jul 2003 17:11:06 +0400
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] parallel directory operations
In-Reply-To: <877k6tuh5g.fsf@gw.home.net>
References: <87wuetukpa.fsf@gw.home.net.suse.lists.linux.kernel>
	<p73brw5qmxk.fsf@oldwotan.suse.de>
	<87of05ujfo.fsf@gw.home.net>
	<20030708134601.7992e64a.ak@suse.de>
	<87fzlhuif0.fsf@gw.home.net>
	<20030708141136.18e0034f.ak@suse.de>
	<877k6tuh5g.fsf@gw.home.net>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas writes:
 > >>>>> Andi Kleen (AK) writes:
 > 
 >  AK> On Tue, 08 Jul 2003 15:50:27 +0000
 >  AK> bzzz@tmi.comex.ru wrote:
 > 
 >  >> well, it makes sense. AFAIU, only problem with this solution is that we need
 >  >> very well-tuned hash function.
 > 
 >  AK> A small rbtree or similar would work too. Linux already has the utility code for this.
 >  AK> And a fast path to avoid the overhead when it isn't needed (e.g. first locker uses a 
 >  AK> preallocated lock node, which is cheap to queue)
 > 
 > hmm. interesting! thanks for review.
 > 

By taking this approach one step further you may just add a semaphore
into struct dentry and take it instead of directory ->i_sem. I think
Alexander Viro tried something similar in the past, but it slowed down
common case when there is no concurrent access to the directory.

 > 

Nikita.
