Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUDCSkc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 13:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbUDCSkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 13:40:32 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30635 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261857AbUDCSka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 13:40:30 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
References: <20040320152328.GA8089@wohnheim.fh-wedel.de>
	<20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net>
	<20040329231635.GA374@elf.ucw.cz>
	<20040402165440.GB24861@wohnheim.fh-wedel.de>
	<20040402180128.GA363@elf.ucw.cz>
	<20040402181707.GA28112@wohnheim.fh-wedel.de>
	<20040402182357.GB410@elf.ucw.cz>
	<20040402200921.GC653@mail.shareable.org>
	<20040402213933.GB246@elf.ucw.cz>
	<20040403010425.GJ653@mail.shareable.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Apr 2004 11:39:53 -0700
In-Reply-To: <20040403010425.GJ653@mail.shareable.org>
Message-ID: <m1n05soqh2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Here's a tricky situation:
> 
>    1. A file is cowlinked.  Then each cowlink is mmap()'d, one per process.
> 
>    2. At this point both mappings share the same pages in RAM.

Why they have different inodes?  
 
>    3. Then one of the cowlinks is written to...

I would not worry about sharing page cache entries unless this becomes
a common case.  If you want to avoid the hit of rereading the file when
you have a cow copy it should be simple enough to walk through the list
of cow copies and see if anyone else has it open.

Eric
