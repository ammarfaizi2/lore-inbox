Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVHYAFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVHYAFF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 20:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVHYAFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 20:05:05 -0400
Received: from baythorne.infradead.org ([81.187.2.161]:62161 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S932395AbVHYAFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 20:05:04 -0400
Subject: Re: Add pselect, ppoll system calls.
From: David Woodhouse <dwmw2@infradead.org>
To: Michael Kerrisk <mtk-lkml@gmx.net>
Cc: drepper@redhat.com, jakub@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, michael.kerrisk@gmx.net
In-Reply-To: <25911.1123246168@www3.gmx.net>
References: <11156.1123243084@www3.gmx.net>  <25911.1123246168@www3.gmx.net>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 01:04:49 +0100
Message-Id: <1124928289.7316.92.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry for delayed response)

On Fri, 2005-08-05 at 14:49 +0200, Michael Kerrisk wrote:
> If I change your program to do something like the above, I also
> do not see a message from the handler -- i.e., it is not being
> called, and I'm pretty sure it should be.

Hm, yes. What happens is we come back out of the select() immediately
because of the pending signal, but on the way back to userspace we put
the old signal mask back... so by the time we check for it, there _is_
no (unblocked) signal pending. 

If it's mandatory that we actually call the signal handler, then we need
to play tricks like sigsuspend() does to leave the old signal mask on
the stack frame. That's a bit painful atm because do_signal is different
between architectures. 

-- 
dwmw2


