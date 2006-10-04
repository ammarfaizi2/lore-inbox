Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161146AbWJDR2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbWJDR2Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWJDR2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:28:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1709 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964900AbWJDR2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:28:23 -0400
Date: Wed, 4 Oct 2006 10:28:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
Cc: <tim.c.chen@linux.intel.com>, "Jeremy Fitzhardinge" <jeremy@goop.org>,
       <herbert@gondor.apana.org.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Message-Id: <20061004102812.5f3b22d2.akpm@osdl.org>
In-Reply-To: <B41635854730A14CA71C92B36EC22AAC3F3FAD@mssmsx411>
References: <B41635854730A14CA71C92B36EC22AAC3F3FAD@mssmsx411>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2006 20:57:57 +0400
"Ananiev, Leonid I" <leonid.i.ananiev@intel.com> wrote:

> >Guys.  Please.  Help us out here.  None of this makes sense, and it's
> > possible that we have an underlying problem in there which we need to
> know
> > about.
>  This is explantion:
> 
> The static variable __warn_once was "never" read (until there is no bug)
> before patch "Let WARN_ON/WARN_ON_ONCE return the condition"
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
> t;h=684f978347deb42d180373ac4c427f82ef963171
>  in WARN_ON_ONCE's line 
> - if (unlikely((condition) && __warn_once)) { \
> because 'condition' is false. There was no cache miss as a result.
> 
> Cache miss for __warn_once is happened in new lines
> + if (likely(__warn_once)) \
> + if (WARN_ON(__ret_warn_once)) \
> 

That's one cache miss.  One.  For the remainder of the benchmark,
__warn_once is in cache and there are no more misses.  That's how caches
work ;)

But it appears this isn't happening.  Why?
