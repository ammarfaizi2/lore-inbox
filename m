Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265537AbRFVV6p>; Fri, 22 Jun 2001 17:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265538AbRFVV6f>; Fri, 22 Jun 2001 17:58:35 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:12295 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S265537AbRFVV60>; Fri, 22 Jun 2001 17:58:26 -0400
X-mailer: xrn 8.03-beta-26
From: Paul Menage <pmenage@ensim.com>
Subject: Re: signal dequeue ...
To: george anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org, pmenage@ensim.com
In-Reply-To: <0C01A29FBAE24448A792F5C68F5EA47D120354@nasdaq.ms.ensim.com>
Message-Id: <E15DYwE-00023t-00@pmenage-dt.ensim.com>
Date: Fri, 22 Jun 2001 14:58:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <0C01A29FBAE24448A792F5C68F5EA47D120354@nasdaq.ms.ensim.com>,
you write:
>
>Right, but the remaining signals are still pending.  In your method, the
>kernel doesn't know which were and which were not actually delivered.
>

You could add an SA_MULTIPLE flag to the sigaction() sa_flags, which
permit the kernel to stack multiple signals up in this way for apps
that guarantee not to misbehave. In do_signal()/handle_signal(), only
allow a signal to be stacked on another signal if its handler has
SA_MULTIPLE set. So non-stackable signals will always be the last
signal frame of the stack to be entered, and it won't matter if they
longjmp() out.

Would the performance improvement from this be worthwhile? I imagine if
you're handling a lot of SIGIO signals, the ability to batch up several
signals in a single user/kernel crossing might be of noticeable benefit.

Paul
