Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbVIMO2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVIMO2m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbVIMO2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:28:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37387 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932648AbVIMO2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:28:41 -0400
Date: Tue, 13 Sep 2005 15:28:31 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Josh Boyer <jdub@us.ibm.com>
Cc: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Missing #include <config.h>
Message-ID: <20050913152831.B23643@flint.arm.linux.org.uk>
Mail-Followup-To: Josh Boyer <jdub@us.ibm.com>,
	=?iso-8859-1?Q?J=F6rn_Engel?= <joern@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20050913135622.GA30675@phoenix.infradead.org> <1126620753.3209.3.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1126620753.3209.3.camel@windu.rchland.ibm.com>; from jdub@us.ibm.com on Tue, Sep 13, 2005 at 09:12:33AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 09:12:33AM -0500, Josh Boyer wrote:
> On Tue, 2005-09-13 at 14:56 +0100, Jörn Engel wrote:
> > After spending some hours last night and this morning hunting a bug,
> > I've found that a different include order made a difference.  Some
> > files don't work correctly, unless config.h is included before.
> > 
> > Here is a very stupid bug checker for the problem class:
> > $ rgrep CONFIG include/ | cut -d: -f1 | sort -u > g1
> > $ rgrep CONFIG include/ | cut -d: -f1 | sort -u | xargs grep "config.h" | cut -d: -f1 | sort -u > g2
> > $ diff -u g1 g2 | grep ^- > g3
> 
> Your checker doesn't quite test for nested includes.  E.g. if foo.h
> includes bar.h, and bar.h includes config.h, then foo.h doesn't need to
> include config.h explicitly.

Unfortunately, we don't operate like that.  If a file makes use of
CONFIG_xxx then it must include <linux/config.h>.

We have "make configcheck" to help us find <linux/config.h> screwups.
Unfortunately, it seems from the output that no one runs it anymore.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
