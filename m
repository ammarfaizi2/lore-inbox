Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263552AbTDXDCU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 23:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTDXDCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 23:02:20 -0400
Received: from to-telus.redhat.com ([207.219.125.105]:63986 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id S263552AbTDXDCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 23:02:19 -0400
Date: Wed, 23 Apr 2003 23:14:27 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [PATCH] Small bug fix for aio
Message-ID: <20030423231427.A9036@redhat.com>
References: <1051062904.2808.37.camel@w-ming.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1051062904.2808.37.camel@w-ming.beaverton.ibm.com>; from cmm@us.ibm.com on Tue, Apr 22, 2003 at 06:54:51PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 06:54:51PM -0700, Mingming Cao wrote:
> Here is a trivial patch fixed a bug in ioctx_alloc(). If
> aio_setup_ring() failed, ioctx_alloc() should pass the return error from
> aio_setup_ring() back to sys_io_setup().

This particular case was intentional: -ENOMEM really is the right return 
code when the ring cannot be allocated.  Mixing it up with the potential 
return codes from do_mmap or other functions might result in a very 
nonsensical return.  Perhaps someone can provide an arguement in favour 
of propagating the value, but I think it really can only mean "you asked 
the kernel to allocate too much memory or did something stupidly buggy with 
threads".  Cheers,

		-ben
-- 
Junk email?  <a href="mailto:aart@kvack.org">aart@kvack.org</a>
