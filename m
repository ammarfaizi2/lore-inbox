Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263887AbTKZBFI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 20:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263890AbTKZBFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 20:05:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:50669 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263887AbTKZBFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 20:05:05 -0500
Date: Tue, 25 Nov 2003 17:05:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test10 O_DIRECT memory leak fix
Message-Id: <20031125170538.33bfc4a2.akpm@osdl.org>
In-Reply-To: <200311251449.50397.pbadari@us.ibm.com>
References: <200311251449.50397.pbadari@us.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> Hi Andrew,
> 
> I found the problem with O_DIRECT memory leak.
> 
> The problem is, when we are doing DIO read and crossed the end of file -
> we don't release referencess on all the pages we got from get_user_pages().
> (since it is a sucess case).
> 
> The fix is to call dio_cleanup() even for sucess cases. Can you please
> review this ? I tested the patch with fsstress and there are no memory leak 
> problems now.

Thanks, it looks OK.  Those pages haven't even been put into BIOs so I see
no problem releasing them here even if there is still async I/O in flight.

