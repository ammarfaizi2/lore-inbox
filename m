Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbVCSLJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbVCSLJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 06:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVCSLJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 06:09:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42125 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262445AbVCSLJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 06:09:46 -0500
To: Andreas Dilger <adilger@shaw.ca>
Cc: jmerkey <jmerkey@utah-nac.org>, Andrew Morton <akpm@osdl.org>,
       strombrg@dcs.nac.uci.edu, linux-kernel@vger.kernel.org
Subject: Re: huge filesystems
References: <pan.2005.03.09.18.53.47.428199@dcs.nac.uci.edu>
	<20050314164137.GC1451@schnapps.adilger.int>
	<4235C251.7000801@utah-nac.org>
	<20050314192140.1b3680da.akpm@osdl.org>
	<4236587E.5060200@utah-nac.org>
	<20050314200241.0f079062.akpm@osdl.org>
	<4236669C.7010706@utah-nac.org>
	<20050315060444.GC31960@schnapps.adilger.int>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Mar 2005 04:06:17 -0700
In-Reply-To: <20050315060444.GC31960@schnapps.adilger.int>
Message-ID: <m1fyyr28uu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@shaw.ca> writes:

> On Mar 14, 2005  21:37 -0700, jmerkey wrote:
> > 1. Scaling issues with readdir() with huge numbers of files (not even 
> > huge really. 87000 files in a dir takes a while
> > for readdir() to return results). I average 2-3 million files per 
> > directory on 2.6.9. It can take a up to a minute for
> > readdir() to return from initial reading from on of these directories 
> > with readdir() through the VFS.
> 
> Actually, unless I'm mistaken the problem is that "ls" (even when you
> ask it not to sort entries) is doing readdir on the whole directory
> before returning any results.  We see this with Lustre and very large
> directories.  Run strace on "ls" and it is doing masses of readdirs, but
> no output to stdout.  Lustre readdir works OK on directories up to 10M
> files, but ls sucks.

The classic test is does 'echo *' which does the readdir but not the
stat come back quickly?  

Anyway most of the readdir work is in the filesystem so I don't see
how the VFS would be involved....

Eric
