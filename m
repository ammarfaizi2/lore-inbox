Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965174AbWJXUSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbWJXUSP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 16:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965176AbWJXUSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 16:18:15 -0400
Received: from mx3.cs.washington.edu ([128.208.3.132]:27029 "EHLO
	mx3.cs.washington.edu") by vger.kernel.org with ESMTP
	id S965174AbWJXUSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 16:18:14 -0400
Date: Tue, 24 Oct 2006 13:18:04 -0700 (PDT)
From: David Rientjes <rientjes@cs.washington.edu>
To: Akinobu Mita <akinobu.mita@gmail.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [PATCH] appletalk: prevent unregister_sysctl_table() with a NULL
 argument
In-Reply-To: <20061024101940.GA10575@localhost>
Message-ID: <Pine.LNX.4.64N.0610241313310.8933@attu4.cs.washington.edu>
References: <20061024085357.GB7703@localhost>
 <Pine.LNX.4.64N.0610240229140.10760@attu4.cs.washington.edu>
 <20061024101940.GA10575@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2006, Akinobu Mita wrote:

> On Tue, Oct 24, 2006 at 02:38:24AM -0700, David Rientjes wrote:
> 
> > The only way this would happen at atalk_unregister_sysctl is if the 
> > kmalloc failed on register_sysctl_table during init.  In that case there 
> > is no need to unregister atalk in the first place since it never came up, 
> 
> Yes. this patch doesn't cause failure if sysctl registration failed.
> It aims to avoid that minor possible NULL pointer dereference.
> 

That dereference should never be possible.  If sysctl registration fails, 
it should not be left partially initialized so that it would ever need to 
be cleaned up later; it should just fail to register.  So the fix, if 
indeed one is required in this instance that you have witnessed, should be 
an immediate response to an -ENOMEM on register_sysctl_table.  Adding this 
to atalk_unregister_sysctl is incorrect because that function should only 
be entered given the condition that the register was successful, which in 
this case it was not.

		David
