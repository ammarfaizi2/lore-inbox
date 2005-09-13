Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbVIMOMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbVIMOMu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbVIMOMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:12:50 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:56554 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964788AbVIMOMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:12:49 -0400
Subject: Re: Missing #include <config.h>
From: Josh Boyer <jdub@us.ibm.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050913135622.GA30675@phoenix.infradead.org>
References: <20050913135622.GA30675@phoenix.infradead.org>
Content-Type: text/plain; charset=utf-8
Date: Tue, 13 Sep 2005 09:12:33 -0500
Message-Id: <1126620753.3209.3.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-13 at 14:56 +0100, Jörn Engel wrote:
> After spending some hours last night and this morning hunting a bug,
> I've found that a different include order made a difference.  Some
> files don't work correctly, unless config.h is included before.
> 
> Here is a very stupid bug checker for the problem class:
> $ rgrep CONFIG include/ | cut -d: -f1 | sort -u > g1
> $ rgrep CONFIG include/ | cut -d: -f1 | sort -u | xargs grep "config.h" | cut -d: -f1 | sort -u > g2
> $ diff -u g1 g2 | grep ^- > g3

Your checker doesn't quite test for nested includes.  E.g. if foo.h
includes bar.h, and bar.h includes config.h, then foo.h doesn't need to
include config.h explicitly.

For a more concrete example, take include/asm-i386/kprobes.h from your
list.  That includes linux/types.h, which includes linux/config.h.

Making a tool that takes that into account could be interesting.

josh

