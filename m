Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264384AbUDSMT2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 08:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbUDSMT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 08:19:28 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:56734 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264384AbUDSMT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 08:19:26 -0400
Date: Mon, 19 Apr 2004 14:19:18 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH COW] remove struct file from readpage() and friends
Message-ID: <20040419121917.GA15276@wohnheim.fh-wedel.de>
References: <20040416122652.GA24859@wohnheim.fh-wedel.de> <m1llkuqbzh.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m1llkuqbzh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 April 2004 20:02:58 -0600, Eric W. Biederman wrote:
> Jörn Engel <joern@wohnheim.fh-wedel.de> writes:
> 
> > this could be a good idea, it could also be utterly insane.  If anyone
> > knows for sure, please tell me.
> > 
> > The point is that copyfile(), one of the ingredients to cowlinks,
> > currently has to open() the source, because sendfile() requires a
> > struct file* as one of the arguments.  Following the path down shows
> > that this struct file* is almost never used, but ultimately required
> > by readpage() and readpages().
> > 
> > Those two, again, almost never use the struct file*, except for five
> > cases.  One was trivial to fix, nfs, smbfs, cifs and blkmtd remain:
> 
> Interface wise there are per user credentials that need to remain with
> the written data.  These credentials by there very nature are per
> file.

Not really.  For nfs3, they appear to be per *user*, just accessed in
a funny way.  nfs4 looks a little more complicated, but in the end,
all data is either accessable by other means or used for locking.
Does locking work on NFS now?  If not, that can go as well.

Looks like I will keep this patch for a while and see what Linus
thinks when 2.7 opens up.

Jörn

-- 
The cheapest, fastest and most reliable components of a computer
system are those that aren't there.
-- Gordon Bell, DEC labratories
