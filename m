Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWBJRme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWBJRme (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 12:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWBJRme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 12:42:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65513 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932158AbWBJRmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 12:42:33 -0500
Date: Fri, 10 Feb 2006 09:42:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: linux@horizon.com
cc: nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
In-Reply-To: <20060210172929.27423.qmail@science.horizon.com>
Message-ID: <Pine.LNX.4.64.0602100935350.19172@g5.osdl.org>
References: <20060210172929.27423.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Feb 2006, linux@horizon.com wrote:
> 
> No.  MS_ASYNC says "I need the data written now.".

Says you.

I say (and I have a decade of Linux historical behaviour to back it up) 
that is says "I'm done, start flushing this out asynchronously like all 
the other data I have written".

And yes, there are performance implications. But your claim that "start IO 
now" performs better is bogus. It _sometimes_ performs better, but 
sometimes performs much worse.

Take an example. You have a 200MB dirty area in a 1GB machine. You do 
MS_ASYNC. What do you want to happen?

Do you want IO to be started on all of it? That's going to take quite a 
while, and be really nasty for the system. Or do you want it to be 
gracefully buffered out, the way we do all normal background writes?

"Performance" is very much not just about how fast it hits the platter. 

			Linus
