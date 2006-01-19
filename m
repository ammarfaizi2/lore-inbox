Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161004AbWASJz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbWASJz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161298AbWASJz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:55:59 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:6575 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1161004AbWASJz6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:55:58 -0500
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       Chandra Seetharaman <sekharan@us.ibm.com>, Keith Owens <kaos@sgi.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] Notifier chain update
References: <20060118181955.GF16285@kvack.org>
	<Pine.LNX.4.44L0.0601181517060.4974-100000@iolanthe.rowland.org>
	<20060118214204.GG16285@kvack.org>
From: Jes Sorensen <jes@sgi.com>
Date: 19 Jan 2006 04:55:57 -0500
In-Reply-To: <20060118214204.GG16285@kvack.org>
Message-ID: <yq0r7747d8y.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Benjamin" == Benjamin LaHaise <bcrl@kvack.org> writes:

Benjamin> On Wed, Jan 18, 2006 at 03:23:20PM -0500, Alan Stern wrote:
>> You can't use RCU protection around code that may sleep.  Whether
>> the code remains loaded in the kernel or is part of a removable
>> module doesn't enter into it.

Benjamin> A notifier callee should not be sleeping, if anything it
Benjamin> should be putting its work onto a workqueue and completing
Benjamin> it when it gets scheduled if it has to do something that
Benjamin> blocks.

There are cases where all the notifier client would want to do is
kmalloc(); sum_up_some_data(); copy_to_user(); kfree(); 
very often in the exit() path - doing that via a workqueue seems
overly complex.

Cheers,
Jes
