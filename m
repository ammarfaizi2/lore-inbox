Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291780AbSBHUJ7>; Fri, 8 Feb 2002 15:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291782AbSBHUJw>; Fri, 8 Feb 2002 15:09:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10250 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291780AbSBHUJd>;
	Fri, 8 Feb 2002 15:09:33 -0500
Message-ID: <3C64304A.35BA9E47@zip.com.au>
Date: Fri, 08 Feb 2002 12:08:42 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch] larger kernel stack (8k->16k) per task
In-Reply-To: <Pine.LNX.4.33.0202081511400.1359-100000@einstein.homenet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:
> 
> ...
> +               memset((char*)tsk+sizeof(struct task_struct), 0,        \
> +                       THREAD_SIZE-sizeof(struct task_struct));        \
> +       }                                                               \

This seems to be permanently enabled?  If so, I'd suggest that it
be made conditional on CONFIG_SLAB_DEBUG, or such.

> ...
> -# define INIT_TASK_SIZE        2048*sizeof(long)
> +# define INIT_TASK_SIZE        4096*sizeof(long)

Personally, I'd rather we make the stack 4k for a while,
and fix the resulting mess.

-
