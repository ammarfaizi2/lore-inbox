Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWCaM37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWCaM37 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 07:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWCaM36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 07:29:58 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:2714 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751354AbWCaM36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 07:29:58 -0500
Date: Fri, 31 Mar 2006 14:27:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] splice support #2
Message-ID: <20060331122731.GA13814@elte.hu>
References: <20060330100630.GT13476@suse.de> <20060330120055.GA10402@elte.hu> <20060330120512.GX13476@suse.de> <Pine.LNX.4.64.0603300853190.27203@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603300853190.27203@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> The reason it goes through a pipe is two-fold:
> 
>  - the pipe _is_ the buffer. The reason sendfile() sucks is that sendfile 
>    cannot work with <n> different buffer representations. sendfile() only 
>    works with _one_ buffer representation, namely the "page cache of the 
>    file".

The main problem of sendfile() is that it exposes an incoming-fd 
'offset', which pretty much hardcodes the assumption that the incoming 
file is a pagecache-backed object. I believe the flush_fd solution to 
sys_splice() would solve that range of problems, and thus slice could be 
used for offset-less file objects too.

all the remaining problems of sendfile() just derive from this basic 
pagecache assumption that is hardcoded in the ABI. Once this one is 
overcome (and i believe fd_flush overcomes it), there's no reason why we 
couldnt implement the complete range of sys_splice() transfers.

	Ingo
