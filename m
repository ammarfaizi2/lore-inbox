Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbUE3HTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUE3HTh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 03:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUE3HTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 03:19:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:7342 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261925AbUE3HTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 03:19:35 -0400
Subject: Re: [PATCH] Fix typo in pmac_zilog
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040529234258.42a2dc64.davem@redhat.com>
References: <1085715655.6320.138.camel@gaston>
	 <20040529234258.42a2dc64.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1085901218.10399.11.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 30 May 2004 17:13:38 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-05-30 at 16:42, David S. Miller wrote:
> On Fri, 28 May 2004 13:40:55 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > This patch fixes a typo preventing channel B from working on the Rx
> > path of pmac zilog (never calling tty_flip_*). I think I never tested
> > channel B :)
> 
> Ben, why do you do the tty_flip_buffer_push() outside of
> the port lock?  Just because it's expensive and therefore
> this decreases the lock hold time, or is there some deadlock
> issue?
> 
> Sounds like I should make the change to sunzilog :-)

There is a deadlock issue. I triggered once when I had a bug where the
driver was flooding the input with zero's. All serial drivers seem to be
affected. Apparently, tty_flip_* may call back into your write() routine

Ben.


