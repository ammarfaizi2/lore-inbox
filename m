Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263505AbUCYRty (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 12:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbUCYRtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 12:49:53 -0500
Received: from mail.shareable.org ([81.29.64.88]:24977 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263505AbUCYRtu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 12:49:50 -0500
Date: Thu, 25 Mar 2004 17:49:42 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040325174942.GC11236@mail.shareable.org>
References: <20040321125730.GB21844@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0403210944310.12359-100000@bigblue.dev.mdolabs.com> <20040321181430.GB29440@wohnheim.fh-wedel.de> <m1y8ptu42m.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1y8ptu42m.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Actually there is...  You don't do the copy until an actual write occurs.
> Some files are opened read/write when there is simply the chance they might
> be written to so delaying the copy is generally a win.

Programs depend on the inode number returned by fstat() not changing,
and maybe in some other circumstances, even if they subsequently write
to the file.

(It's ok for open() to change the inode number, because that's
equivalent to another program changing the filesystem in parallel).

How do you handle that if COW occurs later than open()?
You could also force COW when fstat() is called, I suppose.

-- Jamie
