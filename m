Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUC2Mja (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbUC2MiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:38:16 -0500
Received: from mail.shareable.org ([81.29.64.88]:19347 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262923AbUC2MhE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:37:04 -0500
Date: Mon, 29 Mar 2004 13:36:58 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040329123658.GA4984@mail.shareable.org>
References: <m1ptb0zjki.fsf@ebiederm.dsl.xmission.com> <20040327102828.GA21884@mail.shareable.org> <m1vfkq80oy.fsf@ebiederm.dsl.xmission.com> <20040327214238.GA23893@mail.shareable.org> <m1ptax97m6.fsf@ebiederm.dsl.xmission.com> <m1brmhvm1s.fsf@ebiederm.dsl.xmission.com> <20040328122242.GB32296@mail.shareable.org> <m14qs8vipz.fsf@ebiederm.dsl.xmission.com> <20040328235528.GA2693@mail.shareable.org> <m1zna0tp55.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1zna0tp55.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> The file will become a cow file only after it is modified or it's
> containing directory is modified.

Eh?  The file (or directory) must be labelled as a cowlinked file the
moment you make the cowlink, not when the data is modified.  It's
_breaking_ the cowlink that happens when the data (or directory
contents) are modified.

> Thus you can have data in the
> file that was written after the snapshot operation finished, but
> before the individual file itself is marked cow.

The creation of a cowlink should be atomic w.r.t. writing.

Specifically, the operation which moves the contents of a non-cowlink
inode to a newly created shared inode, and converts the original
non-cowlink inode to a cowlink inode, should be atomic.

Is there an unavoidable race condition?  I don't see one.

-- Jamie
