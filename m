Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWCVUIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWCVUIW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 15:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWCVUIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 15:08:21 -0500
Received: from pat.uio.no ([129.240.130.16]:19383 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750969AbWCVUIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 15:08:19 -0500
Subject: Re: DoS with POSIX file locks?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: chrisw@sous-sol.org, matthew@wil.cx, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1FM6Hd-0001l9-00@dorka.pomaz.szeredi.hu>
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
	 <E1FM6Hd-0001l9-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 15:07:57 -0500
Message-Id: <1143058078.8929.21.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.913, required 12,
	autolearn=disabled, HELO_DYNAMIC_DHCP 0.09,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 17:34 +0100, Miklos Szeredi wrote:

> You mean the "local lockowner being stable" is irrelevant.
> 
> Yes that is true, but the patch not only makes the local lockowner
> stable, it makes the "owner" stable.  And that is the important part
> for NFS, etc.
> 
> The remote lockowner has to be derived from the owner, which used to
> be current->files, but is changed to current->file->owner.
> 
> The fact that current->file->owner will remain stable across the exec
> will mean that locking will behave consistently for local _and_ remote
> filesystems.
> 
> Now I'm not saying I want to keep this weird semantics of always
> inheriting locks on exec.  All I'm saying that it's _possible_.

You'd have to ensure that none of the threads involved are able to grab
new posix locks in the period between the unsharing of current->files to
the moment when current->files->owner is swapped.

If not, one thread could in theory open a new file and grab a lock that
can never be unlocked because its lockowner gets stolen away from it by
another execing thread.

Cheers,
  Trond

