Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264239AbUEHWsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264239AbUEHWsi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 18:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264225AbUEHWsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 18:48:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54197 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264242AbUEHWsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 18:48:36 -0400
Date: Sun, 9 May 2004 00:48:35 +0200
From: Pavel Machek <pavel@suse.cz>
To: =?iso-8859-2?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040508224835.GE29255@atrey.karlin.mff.cuni.cz>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040506131731.GA7930@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Couldn't sleep last night and finished a first complete version of
> cowlinks, code-named MAD COW.  It is still based on the stupid old
> design with a flag to distinguish between regular hard links and
> cowlinks.  Please don't comment on that design, it's just a proof of
> concept.

> Patches are against 2.6.5 but most things should apply to other 2.6
> kernel without too much trouble.
> 
> 1 generic_sendpage	- allow sendfile with ext[23] files as target
> 2 sendfile		- introduce vfs_sendfile for in-kernel use
> 3 copyfile		- new copyfile() system call

Well, up to "3" it seems usefull on its own. You might attempt to
merge that.

namei.c: you realy don't want to #include in the middle of .c file.

vfs_unlink followed by BUG_ON(error)... that's definitely wrong. In
case of disk error, you might get error on unlink; but you should not
BUG() on that. Perhaps copyfile() should be specified as "may leave
part of copy of target on disk in case of error"?

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
