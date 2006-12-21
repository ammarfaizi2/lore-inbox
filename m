Return-Path: <linux-kernel-owner+w=401wt.eu-S1423024AbWLUStF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423024AbWLUStF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 13:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423023AbWLUStE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 13:49:04 -0500
Received: from gw.goop.org ([64.81.55.164]:33484 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423024AbWLUStE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 13:49:04 -0500
Message-ID: <458AD71D.2060508@goop.org>
Date: Thu, 21 Dec 2006 10:49:01 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] change WARN_ON back to "BUG: at ..."
References: <20061221124327.GA17190@elte.hu>
In-Reply-To: <20061221124327.GA17190@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> Subject: [patch] change WARN_ON back to "BUG: at ..."
> From: Ingo Molnar <mingo@elte.hu>
>
> WARN_ON() ever triggering is a kernel bug. Do not try to paper over this 
> fact by suggesting to the user that this is 'only' a warning, as the 
> following recent commit does:
>   
I disagree.

I think there are two issues here: intent and effect.

What's the intent of WARN_ON?  Presumably its different from BUG_ON,
otherwise you could just use BUG_ON.  Or if not, why not just have
BUG_ON?  I think in practice many WARN_ONs are clearly not intended to
be as serious as BUG_ON: they warn about unimplemented things, transient
hiccups, clarifications of errno returns, etc.  (Whether WARN_ON is a
good mechanism for all these things is a separate issue.)

Their effects are very different too.  The effect of WARN_ON is simply a
message; if I see it in a log, I know that something happened which
should be fixed, but the system is in a fairly sane state.  If I see a
BUG_ON, then I know something was killed with extreme prejudice - at
best a process got killed, but there may be stray locks held or other
damage - and the system is basically teetering if it hasn't crashed
already.  Because the effects of the two warning mechanisms are so
different, I think its important to make them clearly visually distinct
when scanning the kernel output.  My eye is trained to see "BUG: " as
meaning "something destabilizing happened"; if warnings also appear that
way, then it is just needlessly confusing.

    J
