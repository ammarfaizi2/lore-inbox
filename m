Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUEAJQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUEAJQR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 05:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUEAJQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 05:16:17 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:32980 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262062AbUEAJQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 05:16:15 -0400
Date: Sat, 1 May 2004 11:15:52 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Robert M. Stockmann" <stock@stokkie.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <20040501091552.GB29089@louise.pinerecords.com>
References: <Pine.LNX.4.44.0404272317390.11727-100000@hubble.stokkie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404272317390.11727-100000@hubble.stokkie.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr-27 2004, Tue, 23:34 +0200
Robert M. Stockmann <stock@stokkie.net> wrote:

> > Hmm. At least with -sdt=c99 it should be trivial, with something like
> > 
> > #define __MODULE_INFO(tag, name, info) \
> > static struct { int len; const char value[] } \
> > __module_cat(name,__LINE__) __attribute_used__ \
> > __attribute__((section(".modinfo"),unused)) = \
> > { sizeof(__stringify(tag) "=" info), \
> > __stringify(tag) "=" info }
> > 
> > doing the job.
> > 
> > That should make it pretty easy to parse the .modinfo section too.
> > 
> > Linus
> 
> Its a joke anyway gcc3.x allows this to happen.

Why?  Initializing a char pointer to a byte stream that contains a NUL
is perfectly legal C.

> As i posted on the gcc mailinglist some time ago :
[snip]
> checking version of gcc... 2.95.3, bad
> configure: error: Please upgrade your gcc compiler to gcc-2.96+ or gcc-3+ 
> version! Earlier compiler versions will NOT work as these do not support 
> unnamed/annonymous structures and unions which are used heavily in linux-ntfs.
> [jackson:stock]:(~/src/ntfsprogs-1.8.4)$
> 
> Aha, unnamed/annonymous structures and unions .....
> 
> Well thats briljant... in 2 years time all Open Source code will be unnamed
> and anonymous in the form of propiatary .o modules, and Linus will still
> be happy to deliver his /usr/src/linux/kernel subtree of the Linux
[snip]

Well, what was the GCC folks' response?  I'd place my bet on
"Do you even know what an unnamed structure/union is?"

-- 
Tomas Szepe <szepe@pinerecords.com>
