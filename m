Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbVIMOkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbVIMOkW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbVIMOkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:40:22 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:35283 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964802AbVIMOkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:40:20 -0400
Subject: Re: Missing #include <config.h>
From: Josh Boyer <jdub@us.ibm.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@infradead.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050913152831.B23643@flint.arm.linux.org.uk>
References: <20050913135622.GA30675@phoenix.infradead.org>
	 <1126620753.3209.3.camel@windu.rchland.ibm.com>
	 <20050913152831.B23643@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Sep 2005 09:40:11 -0500
Message-Id: <1126622411.3209.7.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-13 at 15:28 +0100, Russell King wrote:
> On Tue, Sep 13, 2005 at 09:12:33AM -0500, Josh Boyer wrote:
> > On Tue, 2005-09-13 at 14:56 +0100, JÃ¶rn Engel wrote:
> > > After spending some hours last night and this morning hunting a bug,
> > > I've found that a different include order made a difference.  Some
> > > files don't work correctly, unless config.h is included before.
> > > 
> > > Here is a very stupid bug checker for the problem class:
> > > $ rgrep CONFIG include/ | cut -d: -f1 | sort -u > g1
> > > $ rgrep CONFIG include/ | cut -d: -f1 | sort -u | xargs grep "config.h" | cut -d: -f1 | sort -u > g2
> > > $ diff -u g1 g2 | grep ^- > g3
> > 
> > Your checker doesn't quite test for nested includes.  E.g. if foo.h
> > includes bar.h, and bar.h includes config.h, then foo.h doesn't need to
> > include config.h explicitly.
> 
> Unfortunately, we don't operate like that.  If a file makes use of
> CONFIG_xxx then it must include <linux/config.h>.

Well, that rule makes things easier then, so Jörn's list would be pretty
complete.

Your proposal of using -imacros is even better though.

josh

