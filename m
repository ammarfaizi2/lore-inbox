Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVAYCuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVAYCuS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 21:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVAYCuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 21:50:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:965 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261780AbVAYCuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 21:50:12 -0500
Date: Mon, 24 Jan 2005 18:49:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: george@mvista.com
Cc: roland@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       clameter@sgi.com, drepper@redhat.com
Subject: Re: [PATCH 1/7] posix-timers: tidy up clock interfaces and
 consolidate dispatch logic
Message-Id: <20050124184925.19a1ea75.akpm@osdl.org>
In-Reply-To: <41F5ABB8.8070308@mvista.com>
References: <200501232322.j0NNMcxe006476@magilla.sf.frob.com>
	<41F5ABB8.8070308@mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger <george@mvista.com> wrote:
>
>  >  /*
>   > + * Define this to initialize every k_clock function table so all its
>   > + * function pointers are non-null, and always do indirect calls through the
>   > + * table.  Leave it undefined to instead leave null function pointers and
>   > + * decide at the call sites between a direct call (maybe inlined) to the
>   > + * default function and an indirect call through the table when it's filled
>   > + * in.  Which style is preferable is whichever performs better in the
>   > + * common case of using the default functions.
> 
>   > +#define CLOCK_DISPATCH_DIRECT
> 
>  As I understand it modern machines, the indirect call does really bad things to 
>  the pipeline.  The default call, even preceeded by the if, will be much faster 
>  by this reasoning.  I would, therefor, prefer not defining CLOCK_DISPATCH_DIRECT.

We do need to do one or the other.  I assume the current indecision is
pending some benchmarking work?
