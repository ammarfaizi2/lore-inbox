Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWJXJil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWJXJil (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 05:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWJXJil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 05:38:41 -0400
Received: from mx1.cs.washington.edu ([128.208.5.52]:46984 "EHLO
	mx1.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1030250AbWJXJik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 05:38:40 -0400
Date: Tue, 24 Oct 2006 02:38:24 -0700 (PDT)
From: David Rientjes <rientjes@cs.washington.edu>
To: Akinobu Mita <akinobu.mita@gmail.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [PATCH] appletalk: prevent unregister_sysctl_table() with a NULL
 argument
In-Reply-To: <20061024085357.GB7703@localhost>
Message-ID: <Pine.LNX.4.64N.0610240229140.10760@attu4.cs.washington.edu>
References: <20061024085357.GB7703@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2006, Akinobu Mita wrote:

> If register_sysctl_table() fails during module initalization,
> NULL pointer dereference will happen in the module cleanup.
> 

The only way this would happen at atalk_unregister_sysctl is if the 
kmalloc failed on register_sysctl_table during init.  In that case there 
is no need to unregister atalk in the first place since it never came up, 
so this doesn't appear to be the correct fix.  Even if it were possible, 
this check should be done at atalk_exit instead of 
atalk_unregister_sysctl.

		David
