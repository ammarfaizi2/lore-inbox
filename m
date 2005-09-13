Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbVIMIRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbVIMIRE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 04:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVIMIRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 04:17:04 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:15902 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932445AbVIMIRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 04:17:01 -0400
Message-ID: <43268C21.9090704@sw.ru>
Date: Tue, 13 Sep 2005 12:21:53 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org, xemul@sw.ru,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] error path in setup_arg_pages() misses vm_unacct_memory()
References: <4325B188.10404@sw.ru> <20050912132352.6d3a0e3a.akpm@osdl.org>
In-Reply-To: <20050912132352.6d3a0e3a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This patch fixes error path in setup_arg_pages() functions, since it 
>> misses vm_unacct_memory() after successful call of 
>> security_vm_enough_memory(). Also it cleans up error path.
>
> Ugh.  The identifier `security_vm_enough_memory()' sounds like some
> predicate which has no side-effects.  Except it performs accounting.  Hence
> bugs like this.
yup, this is really done in a leading-to-bugs way... :(
maybe it is worth moving vm_acct_memory() out of 
security_vm_enough_memory()? what do you think?

> It's a shame that you mixed a largeish cleanup along with a bugfix - please
> don't do that in future.
not a problem :) thanks for your time and looking at the patches I sent.

Kirill

