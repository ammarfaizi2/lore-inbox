Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWJXKTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWJXKTp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 06:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWJXKTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 06:19:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:38137 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030254AbWJXKTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 06:19:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Gi2Hu2Ru0MhXRIJRmHreeZgLPEg6oDLBRUrrGpJehJVATc1vDqAJdEzfROQ5BOKdsUAI/t1cmhDAcH3P0n6eTrAyt8XDWb7zFTw7aGsZO7ypVZgsCrwxr3iUsj982Cg81p6OIR1Aq34JY8JA93fg1FLw799wIoZZ1JaxrPn9Eiw=
Date: Tue, 24 Oct 2006 19:19:40 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: David Rientjes <rientjes@cs.washington.edu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: [PATCH] appletalk: prevent unregister_sysctl_table() with a NULL argument
Message-ID: <20061024101940.GA10575@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	David Rientjes <rientjes@cs.washington.edu>,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>
References: <20061024085357.GB7703@localhost> <Pine.LNX.4.64N.0610240229140.10760@attu4.cs.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0610240229140.10760@attu4.cs.washington.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 02:38:24AM -0700, David Rientjes wrote:

> The only way this would happen at atalk_unregister_sysctl is if the 
> kmalloc failed on register_sysctl_table during init.  In that case there 
> is no need to unregister atalk in the first place since it never came up, 

Yes. this patch doesn't cause failure if sysctl registration failed.
It aims to avoid that minor possible NULL pointer dereference.

> so this doesn't appear to be the correct fix.  Even if it were possible, 
> this check should be done at atalk_exit instead of 
> atalk_unregister_sysctl.

Are there any difference?
Because atalk_unregister_sysctl() is only called from atalk_exit(). And
atalk_table_header is static variable. So there is no way to know
whether sysclt registration was succeeded or not. Or is it better to
export atalk_table_header for that check from atalk_exit()?

