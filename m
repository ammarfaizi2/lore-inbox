Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUDRCDZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 22:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbUDRCDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 22:03:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60072 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264097AbUDRCDX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 22:03:23 -0400
To: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH COW] remove struct file from readpage() and friends
References: <20040416122652.GA24859@wohnheim.fh-wedel.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Apr 2004 20:02:58 -0600
In-Reply-To: <20040416122652.GA24859@wohnheim.fh-wedel.de>
Message-ID: <m1llkuqbzh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> writes:

> Folks,
> 
> this could be a good idea, it could also be utterly insane.  If anyone
> knows for sure, please tell me.
> 
> The point is that copyfile(), one of the ingredients to cowlinks,
> currently has to open() the source, because sendfile() requires a
> struct file* as one of the arguments.  Following the path down shows
> that this struct file* is almost never used, but ultimately required
> by readpage() and readpages().
> 
> Those two, again, almost never use the struct file*, except for five
> cases.  One was trivial to fix, nfs, smbfs, cifs and blkmtd remain:

Interface wise there are per user credentials that need to remain with
the written data.  These credentials by there very nature are per
file.

Last I heard the current interface was only a rough approximation of
correct in that it is wrong if you are caching data and you have
multiple people writing per file.

So definitely at the top level you should have a struct file
so that the credentials needed can be computed.  As things
filter down it may be possible to change that.

Eric
