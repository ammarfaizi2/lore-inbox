Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUDEMSY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 08:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbUDEMSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 08:18:24 -0400
Received: from mail.shareable.org ([81.29.64.88]:54423 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262129AbUDEMSV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 08:18:21 -0400
Date: Mon, 5 Apr 2004 13:17:53 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@suse.cz>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040405121753.GA19842@mail.shareable.org>
References: <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org> <20040402213933.GB246@elf.ucw.cz> <20040403010425.GJ653@mail.shareable.org> <m1n05soqh2.fsf@ebiederm.dsl.xmission.com> <20040403194344.GA5477@mail.shareable.org> <20040405083549.GD28924@wohnheim.fh-wedel.de> <m1hdvyn5uy.fsf@ebiederm.dsl.xmission.com> <20040405114312.GA31036@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405114312.GA31036@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > I know a writable mmap needs to trigger a copy in that case.
> > And then are fun cases with MAP_FIXED which may mean invalidation
> > is not allowed.
> 
> How is "invalidation not allowed" for MAP_FIXED? Application will
> never see the fault...

I think Eric secretly meant MAP_LOCKED and/or mlock().

Even if the file isn't copied, when you have two different mappings of
different cowlinks both mapped with MAP_LOCKED, the pages need to be
different in RAM or we break locked page expectations.

-- Jamie
