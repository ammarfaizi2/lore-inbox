Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274676AbRITWZa>; Thu, 20 Sep 2001 18:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274678AbRITWZU>; Thu, 20 Sep 2001 18:25:20 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:19744 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274677AbRITWZL> convert rfc822-to-8bit; Thu, 20 Sep 2001 18:25:11 -0400
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems
From: Robert Love <rml@tech9.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Andrew Morton <akpm@zip.com.au>, Chris Mason <mason@suse.com>,
        Beau Kuiper <kuib-kl@ljbc.wa.edu.au>,
        Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <200109202112.f8KLCXG16849@zero.tech9.net>
In-Reply-To: <20010920170812.CCCACE641B@ns1.suse.com>
	<3BAA29C2.A9718F49@zip.com.au> <1001019170.6090.134.camel@phantasy> 
	<200109202112.f8KLCXG16849@zero.tech9.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.19.21.54 (Preview Release)
Date: 20 Sep 2001 18:24:48 -0400
Message-Id: <1001024694.6048.246.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-09-20 at 17:11, Dieter Nützel wrote:
> > I am putting together a conditional scheduling patch to fix some of the
> > worst cases, for use in conjunction with the preemption patch, and this
> > might be useful.
> 
> The conditional_schedule() function hampered me from running it already.

hrm, i didnt notice that conditional_schedule wasnt defined in that
patch.  you will need to do it, but do something more like

if (current->need_resched && current->lock_depth == 0) {
	unlock_kernel();
	lock_kernel();
}

like Andrew wrote.

If you don't jump on the idea of trying this :) I will send work out a
patch that does some other low-latency thigns and send it out.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

