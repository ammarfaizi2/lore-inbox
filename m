Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVCWWhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVCWWhC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 17:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262950AbVCWWhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 17:37:01 -0500
Received: from fire.osdl.org ([65.172.181.4]:44494 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262433AbVCWWei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 17:34:38 -0500
Date: Wed, 23 Mar 2005 14:34:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, mahalcro@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Keys: Pass session keyring to call_usermodehelper()
Message-Id: <20050323143405.502c1c84.akpm@osdl.org>
In-Reply-To: <30327.1111613194@redhat.com>
References: <20050323130628.3a230dec.akpm@osdl.org>
	<29204.1111608899@redhat.com>
	<30327.1111613194@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> 
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > > The attached patch makes it possible to pass a session keyring through to
> > >  the process spawned by call_usermodehelper().
> > 
> > hm.  Seems likely to attract angry emails due to breakage of out-of-tree
> > stuff.  Did you consider
> > 
> > static inline int
> > call_usermodehelper(char *path, char **argv, char **envp, int wait)
> > {
> > 	return call_usermodehelper_keys(path, argv, envp, NULL, wait);
> > }
> 
> No. I can do that if you want. It seems a bit excessive though.
> 

Well one question is "does it make sense to make a keyring session a part
of the call_usermodehelper() API?".  As it appears that only one caller
will ever want to do that then I'd say no, and that it should be some
specialised thing private to the key code and the call_usermodehelper()
implementation.

So unless you think that a significant number of callers will appear who
are actually using the new capability then it would be better to keep the
existing call_usermodehelper() API.

