Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267296AbTGHNA6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 09:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267298AbTGHNA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 09:00:57 -0400
Received: from tmi.comex.ru ([217.10.33.92]:35207 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S267296AbTGHNA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 09:00:57 -0400
X-Comment-To: Nikita Danilov
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] parallel directory operations
From: bzzz@tmi.comex.ru
Date: Tue, 08 Jul 2003 17:15:26 +0000
In-Reply-To: <16138.49898.424148.525523@laputa.namesys.com> (Nikita
 Danilov's message of "Tue, 8 Jul 2003 17:11:06 +0400")
Message-ID: <874r1xuehd.fsf@gw.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <87wuetukpa.fsf@gw.home.net.suse.lists.linux.kernel>
	<p73brw5qmxk.fsf@oldwotan.suse.de> <87of05ujfo.fsf@gw.home.net>
	<20030708134601.7992e64a.ak@suse.de> <87fzlhuif0.fsf@gw.home.net>
	<20030708141136.18e0034f.ak@suse.de> <877k6tuh5g.fsf@gw.home.net>
	<16138.49898.424148.525523@laputa.namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Nikita Danilov (ND) writes:


 ND> By taking this approach one step further you may just add a semaphore
 ND> into struct dentry and take it instead of directory ->i_sem. I think
 ND> Alexander Viro tried something similar in the past, but it slowed down
 ND> common case when there is no concurrent access to the directory.

it's not semaphore. locks are created on demand to protect part of directory.
we can't have a lots of semaphores allocated statically for each part of
each directory.

BTW, all of this have to be enabled by 'pdirops' ext3's mount option. so, things
don't slow down w/o this option.

