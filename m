Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265426AbTFSErF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 00:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265431AbTFSErE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 00:47:04 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:62736 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265426AbTFSErD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 00:47:03 -0400
Date: Thu, 19 Jun 2003 06:00:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: davidm@hpl.hp.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: missing bit for thread_info-next-to-task_struct patch
Message-ID: <20030619060059.A600@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, davidm@hpl.hp.com,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <16113.2972.194003.930280@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16113.2972.194003.930280@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Wed, Jun 18, 2003 at 06:02:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 06:02:20PM -0700, David Mosberger wrote:
> +++ b/include/linux/sched.h	Wed Jun 18 18:01:04 2003
> @@ -504,9 +509,10 @@
>   */
>  extern struct exec_domain	default_exec_domain;
>  
> -#ifndef INIT_THREAD_SIZE
> -# define INIT_THREAD_SIZE	2048*sizeof(long)
> -#endif
> +#ifndef __HAVE_ARCH_TASK_STRUCT_ALLOCATOR
> +# ifndef INIT_THREAD_SIZE
> +#  define INIT_THREAD_SIZE	2048*sizeof(long)
> +# endif

This looks strange.  Either you move the ifndef INIT_THREAD_SIZE
outside the other ifdef or maybe remove it comepltly it it's
not needed otherwise..

