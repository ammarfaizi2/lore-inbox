Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263844AbTDXUJz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 16:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbTDXUJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 16:09:55 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:22249 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263844AbTDXUJw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 16:09:52 -0400
Subject: Re: [PATCH] Small bug fix for aio
From: Mingming Cao <cmm@us.ibm.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, linux-aio@kvack.org
In-Reply-To: <20030423231427.A9036@redhat.com>
References: <1051062904.2808.37.camel@w-ming.beaverton.ibm.com> 
	<20030423231427.A9036@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Apr 2003 13:21:04 -0700
Message-Id: <1051215676.2808.236.camel@w-ming.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 20:14, Benjamin LaHaise wrote:
> On Tue, Apr 22, 2003 at 06:54:51PM -0700, Mingming Cao wrote:
> > Here is a trivial patch fixed a bug in ioctx_alloc(). If
> > aio_setup_ring() failed, ioctx_alloc() should pass the return error from
> > aio_setup_ring() back to sys_io_setup().
> 
> This particular case was intentional: -ENOMEM really is the right return 
> code when the ring cannot be allocated.  Mixing it up with the potential 
> return codes from do_mmap or other functions might result in a very 
> nonsensical return.  Perhaps someone can provide an arguement in favour 
> of propagating the value, but I think it really can only mean "you asked 
> the kernel to allocate too much memory or did something stupidly buggy with 
> threads".  Cheers,
> 
> 		-ben

Ok, then I think -ENOMEM makes more sense. Thanks for clarifying.


Mingming

