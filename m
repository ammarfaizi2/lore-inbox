Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264482AbUEaAhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbUEaAhJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 20:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbUEaAhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 20:37:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:16819 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264482AbUEaAhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 20:37:06 -0400
Subject: Re: [PATCH] Fix typo in pmac_zilog
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       rmk+serial@arm.linux.org.uk
In-Reply-To: <20040530173252.4a040e99.davem@redhat.com>
References: <1085715655.6320.138.camel@gaston>
	 <20040529234258.42a2dc64.davem@redhat.com>
	 <1085901218.10399.11.camel@gaston>
	 <20040530173252.4a040e99.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1085963459.2248.29.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 31 May 2004 10:30:59 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-31 at 10:32, David S. Miller wrote:
> On Sun, 30 May 2004 17:13:38 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > There is a deadlock issue. I triggered once when I had a bug where the
> > driver was flooding the input with zero's. All serial drivers seem to be
> > affected. Apparently, tty_flip_* may call back into your write() routine
> 
> Yes indeed, one code path is:
>
> .../...

Yup, another one is when echo is enabled, you may call back into write.

> It seems lots of serial drivers have this bug, even 8250.c :-)

Yes, I told Russell about it.

> I'll fix up the Sparc drivers meanwhile.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

