Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbUKRXld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbUKRXld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 18:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbUKRUtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 15:49:39 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:13034 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S262904AbUKRUrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 15:47:41 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
To: Werner Almesberger <wa@almesberger.net>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@nurfuerspam.de
Date: Thu, 18 Nov 2004 21:48:01 +0100
References: <fa.ev73q5c.ejcnom@ifi.uio.no> <fa.es1mdq5.76ib8j@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1CUtCE-0000us-00@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:

> A process could declare itself as usual suspect. This would then be
> recorded as a per-task flag, to be inherited by children. Now, one
> could write a launcher like this:

You'll have some precompiled binaries causing trouble, while other
precompiled binaries will be killed while you want them to stay alife.
Sometimes you'll have the same binary (e.g. perl or java) running a
"notme"-task like watching the log for intrusion while at the same time
processing a very large image.

The best solution I can think of is attaching a kill priority (similar to
the nice value). Before killing, this value would be added to lg_2(memsize),
and the least desirable process would "win", even if it's sshd running wild.



For the trashing problem: I like the idea of sending a signal to stop the
process, but it should rather be a request to stop that can be caught by
the process. A SETI-like task could save its workset and free the memory
instead, a browser would discard it's memory cache and pause loading
Images for the sites etc.
-- 
The newest and least experienced soldier will usually win the Congressional
Medal Of Honor.

Friﬂ, Spammer: abuse@online-loanz.com cxePdomFs@suncoastrewards.com
