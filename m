Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266217AbUFIRPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266217AbUFIRPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 13:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266219AbUFIRPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 13:15:19 -0400
Received: from cantor.suse.de ([195.135.220.2]:29344 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266217AbUFIRPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 13:15:15 -0400
Subject: Re: [STACK] >3k call path in reiserfs
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
In-Reply-To: <40C74388.20301@namesys.com>
References: <20040609122226.GE21168@wohnheim.fh-wedel.de>
	 <1086784264.10973.236.camel@watt.suse.com>
	 <1086800028.10973.258.camel@watt.suse.com>  <40C74388.20301@namesys.com>
Content-Type: text/plain
Message-Id: <1086801345.10973.263.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Jun 2004 13:15:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-09 at 13:06, Hans Reiser wrote:

> >No such luck, the real offender is having tree balance structs on the
> >stack.  We need to switch to kmalloc for those, which will be mean some
> >extra work to make sure we don't schedule at the wrong time.
> >
> >In other words, not the trivial patch I was hoping for, but I'm cooking
> >one up.

> >
> Can you give me some background on whether this is causing real problems 
> for real users?

Especially with the 4k stack option enabled, it will cause real problems
for real users.  A better change would be to cut down on the size of the
tree balance struct, but that would be more invasive.  For starters we
might be able to switch from ints to shorts for some of the arrays.

-chris


