Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265794AbUFIQxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265794AbUFIQxU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 12:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265841AbUFIQxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 12:53:20 -0400
Received: from cantor.suse.de ([195.135.220.2]:13711 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265794AbUFIQxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 12:53:18 -0400
Subject: Re: [STACK] >3k call path in reiserfs
From: Chris Mason <mason@suse.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
In-Reply-To: <1086784264.10973.236.camel@watt.suse.com>
References: <20040609122226.GE21168@wohnheim.fh-wedel.de>
	 <1086784264.10973.236.camel@watt.suse.com>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1086800028.10973.258.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Jun 2004 12:53:48 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-09 at 08:31, Chris Mason wrote:
> On Wed, 2004-06-09 at 08:22, Jörn Engel wrote:
> > reiserfs has some stack-hungry functions as well.  Could you put them
> > on a diet?
> > 
> Yes, we should be able to fix things by getting rid of some of the
> inlines in a few spots (some funcs are much too large for inlining). 
> I'll send a patch out this morning.

No such luck, the real offender is having tree balance structs on the
stack.  We need to switch to kmalloc for those, which will be mean some
extra work to make sure we don't schedule at the wrong time.

In other words, not the trivial patch I was hoping for, but I'm cooking
one up.

-chris


