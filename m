Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWDUSjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWDUSjb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 14:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWDUSjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 14:39:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52614 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932193AbWDUSja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 14:39:30 -0400
Date: Fri, 21 Apr 2006 11:38:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, torvalds@osdl.org, steved@redhat.com, sct@redhat.com,
       aviro@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] FS-Cache: Generic filesystem caching facility
Message-Id: <20060421113805.2ec6fd74.akpm@osdl.org>
In-Reply-To: <18005.1145628949@warthog.cambridge.redhat.com>
References: <20060420174622.6d7390d6.akpm@osdl.org>
	<20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com>
	<20060420165937.9968.57149.stgit@warthog.cambridge.redhat.com>
	<18005.1145628949@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> > That's your fourth implementation of kenter().  Maybe we
> > need <linux/dhowells.h>?
> 
> :-)
> 
> Maybe I should move my debugging macros into include/linux, but then everyone
> else would complain if their own versions weren't put in there, or would
> complain if they were forced to use mine.

The number of home-made debugging macro implementations we have is quite
demented.  Developing (and maintaining) a common set would be a good idea,
IMO.

> It doesn't actually produce very much code.
> 
> > Defining symbols which are owned by the Kconfig system isn't very nice.
> 
> Kconfig is still broken:
> 
> 	warthog>grep -r CONFIG_FSCACHE include/linux/autoconf.h 
> 	#define CONFIG_FSCACHE_MODULE 1
> 	warthog>
> 
> Modules that might depend on fscache need to know that it's there,

In theory, module A isn't supposed to care whether module B was configured,
because module B might be compiled separately, or dowloaded from elsewhere
or whatever.

> and having
> to double up every #if to detect both is stupid.
> 
> Would you suggest then:
> 
> 	#if defined(CONFIG_FSCACHE) || defined(CONFIG_FSCACHE_MODULE)
> 	#define FSCACHE_AVAILABLE 1
> 	#endif

yup.

