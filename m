Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262711AbVHDVVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbVHDVVs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbVHDVVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:21:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50101 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262711AbVHDVVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:21:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
X-Fcc: ~/Mail/linus
Cc: Gerd Knorr <kraxel@suse.de>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: Fw: 2.6.12: itimer_real timers don't survive execve() any more
In-Reply-To: George Anzinger's message of  Thursday, 4 August 2005 13:59:06 -0700 <42F2819A.7030109@mvista.com>
X-Windows: graphics hacking :: Roman numerals : sqrt (pi)
Date: Thu,  4 Aug 2005 14:12:37 -0700 (PDT)
Message-Id: <20050804212105.98602180980@magilla.sf.frob.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This change is bad.  Noone passed it by me that I recall.  exit_itimers is
also used for exec, which has to clear timer_create timers but not
setitimer timers.  Perhaps the comment on exit_itimers should get adjusted
not to give the impression that it's only used at exit time.


Thanks,
Roland


commit caf2857ac6e0ba2651e722f05d5f7d3ec8ef2615
tree cb8e51e7c17c0964bdfd29635d51da0124d0dfe8
parent 
author Ingo Molnar <mingo@elte.hu> Fri, 17 Jun 2005 11:36:36 +0200
committer Linus Torvalds <torvalds@ppc970.osdl.org> Sat, 18 Jun 2005 00:03:50 -0700

[PATCH] timer exit cleanup

Do all timer zapping in exit_itimers.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
