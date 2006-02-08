Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422664AbWBHXzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbWBHXzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 18:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422663AbWBHXzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 18:55:39 -0500
Received: from minus.inr.ac.ru ([194.67.69.97]:48285 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1422664AbWBHXzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 18:55:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=D/obPCAvP94qoqwjebHy6ZEMK2fOZgMvZIQqB/WEDIcbFt7/nYMi/cPi6SkBzUDWuH51RsaMtwD3J7pC2ibo/iW7+/sl7J3hqIqJvNEGSvIlSIkzFrehol4ufQ3hiZCsB9kzB08W7YgDzi4s5QXxSYZhPmLZojlIMxzMrrnFkqw=;
Date: Thu, 9 Feb 2006 02:53:48 +0300
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kirill Korotaev <dev@sw.ru>, Kirill Korotaev <dev@openvz.org>,
       serue@us.ibm.com, arjan@infradead.org, frankeh@watson.ibm.com,
       clg@fr.ibm.com, haveblue@us.ibm.com, mrmacman_g4@mac.com,
       alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [RFC][PATCH 2/7] VPIDs: pid/vpid conversions
Message-ID: <20060208235348.GC26035@ms2.inr.ac.ru>
References: <43E22B2D.1040607@openvz.org> <43E23179.5010009@sw.ru> <m1irrpsifp.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1irrpsifp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Do you know how incomplete this patch is?

The question is for me. It handles all the subsystems which are allowed
to be used inside openvz containers. And _nothing_ more, it would be pure S&M.


> You missed get_xpid() on alpha.

And probably something similar on all the archs except for i386/x86_64/ia64.


> Is there a plan to catch all of the in-kernel use of pids

grep for ->pid,->tgid,->pgid,->session and look. What could be better? :-)


> You missed cap_set_all.

No doubts, something is missing. Please, could you show how to fix it
or to point directly at the place. Thank you.


Actually, you cycled on this pid problem. If you think private pid spaces
are really necessary, it is prefectly OK. openvz (and, maybe, all VPS-oriented
solutions) do _not_ need this (well, look, virtuozzo is a mature product
for 5 years already, and vpids were added very recently for one specific
purpose), but can live within private spaces or just in peace with them.
We can even apply vpids on top on pid spaces to preserve global process tree.
Provided you leave a chance not to enforce use of private pid spaces
inside containers, of course.

Alexey
