Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWDUSX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWDUSX6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 14:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWDUSX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 14:23:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25986 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932114AbWDUSX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 14:23:57 -0400
Date: Fri, 21 Apr 2006 11:22:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, torvalds@osdl.org, steved@redhat.com, sct@redhat.com,
       aviro@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] FS-Cache: Avoid ENFILE checking for kernel-specific
 open files
Message-Id: <20060421112243.4b435bc7.akpm@osdl.org>
In-Reply-To: <4816.1145622827@warthog.cambridge.redhat.com>
References: <20060420170754.39294603.akpm@osdl.org>
	<20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com>
	<20060420165932.9968.40376.stgit@warthog.cambridge.redhat.com>
	<4816.1145622827@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> > > +struct file *get_empty_filp(int kernel)
> > 
> > I'd suggest a new get_empty_kernel_filp(void) rather than providing a magic
> > argument.  (we can still have the magic argument in the new
> > __get_empty_filp(int), but it shouldn't be part of the caller-visible API).
> > ...
> > It would be more flexible to make the caller pass in the flags directly.
> 
> So:
> 
> 	struct file *get_empty_kernel_filp(unsigned short flags);
> 
> which devolves to get_empty_filp() if flags == 0?
> 

argh, I forgot about the flag.  Oh well.  I'd suggest:

static inline struct file *get_empty_filp(void)
{
	return __get_empty_filp(0);
}

static inline struct file *get_empty_kernel_filp(void)
{
	return __get_empty_filp(0);
}

