Return-Path: <linux-kernel-owner+w=401wt.eu-S932672AbWLSIm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbWLSIm6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 03:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932676AbWLSIm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 03:42:58 -0500
Received: from mx10.go2.pl ([193.17.41.74]:35265 "EHLO poczta.o2.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932672AbWLSIm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 03:42:57 -0500
Date: Tue, 19 Dec 2006 09:43:59 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: [patch] lock debugging: fix DEBUG_LOCKS_WARN_ON() & debug_locks_silent
Message-ID: <20061219084359.GB1731@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, Matthew Wilcox <matthew@wil.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216080458.GC16116@elte.hu>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-12-2006 09:04, Ingo Molnar wrote:
> * Matthew Wilcox <matthew@wil.cx> wrote:
...
> Bug-found-by: Matthew Wilcox <matthew@wil.cx>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  include/linux/debug_locks.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux/include/linux/debug_locks.h
> ===================================================================
> --- linux.orig/include/linux/debug_locks.h
> +++ linux/include/linux/debug_locks.h
> @@ -24,7 +24,7 @@ extern int debug_locks_off(void);
>  	int __ret = 0;							\
>  									\
>  	if (unlikely(c)) {						\
> -		if (debug_locks_silent || debug_locks_off())		\
> +		if (!debug_locks_silent && debug_locks_off())		\
>  			WARN_ON(1);					\
>  		__ret = 1;						\
>  	}								\

I wonder why doing debug_locks_off depends here on
debug_lock_silent state which is only "esthetical"
flag. And debug_locks_off() takes into consideration
debug_lock_silent after all. So IMHO:

	if (unlikely(c)) {						\
		if (debug_locks_off())					\
			WARN_ON(1);					\
		__ret = 1;						\
	}								\

Jarek P.
