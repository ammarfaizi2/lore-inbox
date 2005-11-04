Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbVKDNcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbVKDNcL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 08:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbVKDNcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 08:32:11 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:3334 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751421AbVKDNcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 08:32:10 -0500
To: jblunck@suse.de
CC: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
In-reply-to: <20051104131858.GA16622@hasse.suse.de> (jblunck@suse.de)
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek() bugfix
References: <20051104113851.GA4770@hasse.suse.de> <20051104115101.GH7992@ftp.linux.org.uk> <20051104122021.GA15061@hasse.suse.de> <E1EY16w-0004HC-00@dorka.pomaz.szeredi.hu> <20051104131858.GA16622@hasse.suse.de>
Message-Id: <E1EY1fi-0004LB-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 04 Nov 2005 14:31:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As I said: "Old glibc implementations (e.g. glibc-2.2.5) are
> lseeking after every call to getdents() ..."

Hmm, why would it do that?  This seems like it's glibc being stupid.

That said, you are right that the libfs readdir implementation is not
strictly standards conforming.  But neither is your patch: this
algorithm will break if the entry at the current position is removed
and then a new entry with the same name is created.

> Precisely this is a SLES8 on s390-64bit.
> s390vm02:/# rpm -qf /bin/rm
> fileutils-4.1.11-144
> s390vm02:/# rpm -q glibc
> glibc-2.2.5-234
> 
> But you can also try my testcase.

Unfortunately I can't since I don't have such old glibc.

Miklos
