Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932696AbWCVUUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbWCVUUs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 15:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWCVUUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 15:20:48 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:34541 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932696AbWCVUUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 15:20:20 -0500
To: trond.myklebust@fys.uio.no
CC: chrisw@sous-sol.org, matthew@wil.cx, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <1143058078.8929.21.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Wed, 22 Mar 2006 15:07:57 -0500)
Subject: Re: DoS with POSIX file locks?
References: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu>
	 <20060320121107.GE8980@parisc-linux.org>
	 <E1FLJLs-00085u-00@dorka.pomaz.szeredi.hu>
	 <20060320123950.GF8980@parisc-linux.org>
	 <E1FLJsF-0008A7-00@dorka.pomaz.szeredi.hu>
	 <20060320153202.GH8980@parisc-linux.org>
	 <1142878975.7991.13.camel@lade.trondhjem.org>
	 <E1FLdPd-00020d-00@dorka.pomaz.szeredi.hu>
	 <1142962083.7987.37.camel@lade.trondhjem.org>
	 <E1FLl7L-0002u9-00@dorka.pomaz.szeredi.hu>
	 <20060321191605.GB15997@sorel.sous-sol.org>
	 <E1FLwjC-0000kJ-00@dorka.pomaz.szeredi.hu>
	 <1143025967.12871.9.camel@lade.trondhjem.org>
	 <E1FM2Gi-0001LF-00@dorka.pomaz.szeredi.hu>
	 <1143042976.12871.34.camel@lade.trondhjem.org>
	 <E1FM6Hd-0001l9-00@dorka.pomaz.szeredi.hu> <1143058078.8929.21.camel@lade.trondhjem.org>
Message-Id: <E1FM9nw-00029f-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Mar 2006 21:19:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You'd have to ensure that none of the threads involved are able to grab
> new posix locks in the period between the unsharing of current->files to
> the moment when current->files->owner is swapped.
> 
> If not, one thread could in theory open a new file and grab a lock that
> can never be unlocked because its lockowner gets stolen away from it by
> another execing thread.

This race is already there.  Header comment on steal_locks() documents
it.

The patch does open this race window much wider, because pending locks
are also transfered to the task doing the exec.  The original
steal_locks() only stole already held locks.  But I don't think this
fundamentaly changes things.  It just shows more clearly how ugly the
current semantics are.

Miklos
