Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbUGLUSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbUGLUSP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 16:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUGLUSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 16:18:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:10164 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262356AbUGLUSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 16:18:12 -0400
Date: Mon, 12 Jul 2004 13:17:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@redhat.com>
cc: Jakub Jelinek <jakub@redhat.com>, davidm@hpl.hp.com,
       suresh.b.siddha@intel.com, jun.nakajima@intel.com,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: serious performance regression due to NX patch
In-Reply-To: <Pine.LNX.4.58.0407121402160.2451@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0407121315170.1764@ppc970.osdl.org>
References: <200407100528.i6A5SF8h020094@napali.hpl.hp.com>
 <Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0407110550340.4229@devserv.devel.redhat.com>
 <20040711123803.GD21264@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0407121402160.2451@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Jul 2004, Ingo Molnar wrote:
> 
> so ... this should be #ifndef ia64?

No. Make it a CONFIG_DEFAULT_NOEXEC and make the relevant architectures do
a

	define_bool DEFAULT_NOEXEC y

in their Kconfig files.

In general, we should _never_ use an architecture-define. They just always
end up becoming more and more hairy, and less and less obvious what they 
are all about.

So instead, make a readable and explicit config define, and let each 
architecture just set it (or not) as they wish.

		Linus
