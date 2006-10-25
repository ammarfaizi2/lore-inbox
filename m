Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422815AbWJYXgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422815AbWJYXgH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 19:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbWJYXgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 19:36:07 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29345 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751322AbWJYXgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 19:36:04 -0400
Subject: Re: Security issues with local filesystem caching
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: sds@tycho.nsa.gov, jmorris@namei.org, chrisw@sous-sol.org,
       selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <16969.1161771256@redhat.com>
References: <16969.1161771256@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Oct 2006 00:37:39 +0100
Message-Id: <1161819459.7615.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-25 am 11:14 +0100, ysgrifennodd David Howells:
> Currently, CacheFiles temporarily changes fsuid and fsgid to 0 whilst doing its
> own pathwalk through the cache and whilst creating files and directories in the
> cache.  This allows it to deal with DAC security directly.  All the directories
> it creates are given permissions mask 0700 and all files 0000.

That seems sensible and fine. It is precisely why we added a separate
fsuid in the first place so that the user space nfsd could take on an fs
identity without breaking signal and other security based forms.

>  (1) Do all the cache operations in their own thread (sort of like knfsd).

Slow it down to keep Christoph happy seems iffy

>  (2) Add further security ops for the caching code to call.  These might be of
>      use elsewhere in the kernel.  These would set cache-specific security
>      labels and check for them.

I can see good arguments for this in some cases where you want strict
divisons in extremely secure computing cases but not usually.

> Thoughts anyone?

I'd like to know more about why Christoph is objecting, whether he has
actual real world examples of races/problems it introduces by altering
fsuid or what his concern is.


