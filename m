Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUEJWJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUEJWJy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbUEJWJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:09:54 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:38292 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261638AbUEJWJq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:09:46 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 May 2004 15:09:45 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Andre Ben Hamou <andre@bluetheta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Multithread select() bug
In-Reply-To: <409FFAA0.4000301@bluetheta.com>
Message-ID: <Pine.LNX.4.58.0405101457340.1156@bigblue.dev.mdolabs.com>
References: <409FF38C.7080902@bluetheta.com> <Pine.LNX.4.58.0405101446570.1156@bigblue.dev.mdolabs.com>
 <409FFAA0.4000301@bluetheta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004, Andre Ben Hamou wrote:

> Davide Libenzi wrote:
> > Try:
> > 
> > 	select (socket + 1, &fds, &fds, &fds, &timeout);
> >                                  ^^^^^
> 
> That does work, but only as a workaround (and not a universally 
> applicable one). Select *should* return upon the closure of either end 
> of a socket connection that is in the read-FD-set only (unless I've 
> completely misunderstood the various references).

The standard says that select should return when the operation against the 
fd would not block *or* would return an error different from 
would-have-blocked. The following operation on a closed fd would be an 
EBADF, that fits the standard description. OTOH, MT is messy. Consider a 
thread that closes the fd and immediately after open another one having 
the same fd#. Bottom line is, don't do it.



- Davide

