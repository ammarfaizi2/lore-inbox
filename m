Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbULRUsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbULRUsB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 15:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbULRUsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 15:48:01 -0500
Received: from quark.didntduck.org ([69.55.226.66]:48046 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261151AbULRUr7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 15:47:59 -0500
Message-ID: <41C4977C.2070906@didntduck.org>
Date: Sat, 18 Dec 2004 15:47:56 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041027
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joseph Seigh <jseigh_02@xemaps.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: What does atomic_read actually do?
References: <opsi7o5nqfs29e3l@grunion>
In-Reply-To: <opsi7o5nqfs29e3l@grunion>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Seigh wrote:
> It doesn't do anything that would actually guarantee that the fetch from
> memory would be atomic as far as I can see, at least in the x86 version.
> The C standard has nothing to say about atomicity w.r.t. multithreading or
> multiprocessing.  Is this a gcc compiler thing?  If so, does gcc guarantee
> that it will fetch aligned ints with a single instruction on all platforms
> or just x86?   And what's with volatile since if the C standard implies
> nothing about multithreading then it follows that volatile has no meaning
> with respect to multithreading either?  Also a gcc thing?  Are volatile
> semantics well defined enough that you can use it to make the compiler
> synchronize memory state as far as it is concerned?
> 
> Joe Seigh

For x86, the processor guarantees atomicity for simple aligned reads or 
writes.  Read-modify-write instructions need a lock prefix in order to 
become atomic.  The volatile is there so gcc doesn't miss the value 
changing from within an interrupt.

--
				Brian Gerst
