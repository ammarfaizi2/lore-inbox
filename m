Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbUKPQDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUKPQDC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 11:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbUKPQDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 11:03:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:11456 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262008AbUKPQC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 11:02:58 -0500
Date: Tue, 16 Nov 2004 08:02:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: fork pagesize patch
In-Reply-To: <20968.1100619491@redhat.com>
Message-ID: <Pine.LNX.4.58.0411160800060.2222@ppc970.osdl.org>
References: <20968.1100619491@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Nov 2004, David Howells wrote:
> 
> You seem to have turned:

No, Andrew probably did.

> 
> 	+#if THREAD_SIZE >= PAGE_SIZE
> 		max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 8;
> 	+#else
> 	+	max_threads = mempages / 8;
> 	+#endif
> 	+
> 
> Into:
> 
> 	if (THREAD_SIZE >= PAGE_SIZE)
> 		max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 8;
> 	else
> 		max_threads = mempages / 8;
> 
> Please don't do that. What you've done causes a divide-by-zero error to be
> emitted by the compiler if PAGE_SIZE > THREAD_SIZE. That's why I used the
> preprocessor in the first place.

What kind of broken compiler are _you_ using? Fix your compiler.

If THREAD_SIZE is smaller than PAGE_SIZE, then the compiler IS NOT ALLOWED 
to do the divide-by-zero. Your compiler is so incredibly broken that this 
is not even worth fixing. Complain to the gcc guys.

		Linus
