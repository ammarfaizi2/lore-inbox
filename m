Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290715AbSBOTe2>; Fri, 15 Feb 2002 14:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290688AbSBOTdh>; Fri, 15 Feb 2002 14:33:37 -0500
Received: from gateway2.ensim.com ([65.164.64.250]:29188 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S290721AbSBOTd0>; Fri, 15 Feb 2002 14:33:26 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: Hanna Linder <hannal@us.ibm.com>
cc: Paul Menage <pmenage@ensim.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.4.17] Your suggestions for fast path walk 
In-Reply-To: Your message of "Thu, 14 Feb 2002 18:13:35 PST."
             <16270000.1013739215@w-hlinder.des> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 15 Feb 2002 11:33:19 -0800
Message-Id: <E16bo6h-0003si-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>	Thank you for taking the time to look over my patch and sending
>your comments. In response, Yes, there is a reason why I can't implement 
>path_lookup by calling path_init. path_init calls dget which increments 
>the d_count. The function I wrote holds the dcache_lock instead of 
>incrementing d_count at that point.

OK, I see what you're doing now.

One obvious problem with it is that __emul_lookup_dentry()[1] calls
path_walk() internally, and the nd passed has uncounted references and
no LOOKUP_LOCKED flag - I suspect that this will cause reference counts
to get mucked up.

Also:

1) you really need to fix the patch whitespace/formatting

2) Please again consider calling it path_lookup() rather than 
path_init_walk() - the fact that since 2.3.x programmers have had to be 
aware of the separate path_init()/path_walk() stages is an 
implementation wrinkle that it would be nice to get rid of.

Paul

[1] Actually, __emul_lookup_dentry() probably ought to be simplified
somewhat - it seems to be duplicating a fair chunk of code from
path_init().


