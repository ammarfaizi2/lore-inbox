Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030745AbWJDIZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030745AbWJDIZq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 04:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030760AbWJDIZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 04:25:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:3284 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030745AbWJDIZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 04:25:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=CiSaNa0/4wFO1z0iPqv8CkALhaAwPvUd8tj+cPxYXtDPShDzMrfnY4e5bQQq9ZVKeDMRfIPRFYCbZai0waRu+K5WU7l9lqXQOE3Ngx79SAyZHK9SfA8kiV5BK5DizdJidpgnf5SdFCp9hPgVldpmIYKzGod/S4y1yHcKmrHa5oY=
Message-ID: <45237044.8090805@innova-card.com>
Date: Wed, 04 Oct 2006 10:26:44 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: vgoyal@in.ibm.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/12] i386: define __pa_symbol()
References: <20061003170032.GA30036@in.ibm.com> <20061003171055.GD3164@in.ibm.com>
In-Reply-To: <20061003171055.GD3164@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

Sorry for the late feedback...

Vivek Goyal wrote:
> 
> On x86_64 we have to be careful with calculating the physical
> address of kernel symbols.  Both because of compiler odditities
> and because the symbols live in a different range of the virtual
> address space.
> 

[snip]

> +#define __pa_symbol(x)          \
> +	({unsigned long v;  \
> +	  asm("" : "=r" (v) : "0" (x)); \
> +	  __pa(v); })

Why not simply reusing RELOC_HIDE  like this ?

	#define __pa_symbol(x)	__pa(RELOC_HIDE(x,0))

thanks
		Franck
