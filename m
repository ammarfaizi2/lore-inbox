Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265494AbUFCESE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265494AbUFCESE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 00:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265495AbUFCESE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 00:18:04 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:313 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265494AbUFCESB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 00:18:01 -0400
Date: Wed, 2 Jun 2004 21:25:47 -0700
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de, greg@kroah.com
Subject: Re: [PATCH] fix sys cpumap for > 352 NR_CPUS
Message-Id: <20040602212547.448c7cc7.pj@sgi.com>
In-Reply-To: <1086222156.29391.337.camel@bach>
References: <20040602161115.1340f698.pj@sgi.com>
	<1086222156.29391.337.camel@bach>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty wrote:
> Then just use -1UL as the arg to scnprintf, if you don't have a real
> number.  That way the overflow will at least have a chance of detection
> in the sysfs code, which I think it should check in
> file.c:fill_read_buffer().  Greg?

That doesn't make sense.

My node_read_cpumap() routine is being passed a finite length buffer
into which it is supposed to put some characters.  Unless by contract
or passed value it knows the length of that buffer, it cannot safely
know how far it can write.

Apparently, from Andrews comments and from the line:

  buffer->page = (char *) get_zeroed_page(GFP_KERNEL);

in file.c:fill_read_buffer(), the length is PAGE_SIZE, by contract.

Greg - perhaps a comment in include/linux/sysdev.h, near the declarations
for the show() and store() routines, specifying the buffer sizing,
would be appropriate?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
