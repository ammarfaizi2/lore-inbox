Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265882AbUAEF3G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 00:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265883AbUAEF3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 00:29:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:19393 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265882AbUAEF3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 00:29:02 -0500
Date: Sun, 4 Jan 2004 21:28:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: daniel@osdl.org, janetmor@us.ibm.com, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.1-rc1-mm1] aiodio_fallback_bio_count.patch
Message-Id: <20040104212855.0462b75d.akpm@osdl.org>
In-Reply-To: <20040105052846.GA3810@in.ibm.com>
References: <20031231025309.6bc8ca20.akpm@osdl.org>
	<20031231025410.699a3317.akpm@osdl.org>
	<20031231031736.0416808f.akpm@osdl.org>
	<1072910061.712.67.camel@ibm-c.pdx.osdl.net>
	<1072910475.712.74.camel@ibm-c.pdx.osdl.net>
	<20031231154648.2af81331.akpm@osdl.org>
	<20040102051422.GB3311@in.ibm.com>
	<20040101234634.53b69a3b.akpm@osdl.org>
	<20040105035518.GA3302@in.ibm.com>
	<20040104210642.2b94038f.akpm@osdl.org>
	<20040105052846.GA3810@in.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> wrote:
>
> > Sure.  But the generic_file_aio_write_nolock() code is doing this:
>  > 
>  > 		if (written >= count && !is_sync_kiocb(iocb))
>  > 			written = -EIOCBQUEUED;
>  > 		if (written < 0 || written >= count)
>  > 			goto out_status;
>  > 
>  > 
>  > Under what circumstances can `written' (the amount which was written) be
>  > greater than `count' (the amount to write)?
> 
>  None. The '>' situation should never occur.
> 
>  This is just being explicit about covering the "not less than" case
>  as a whole, and making sure we do not fall through to buffered i/o in
>  that case, i.e its the same as:
>  if (!(written < count) && !is_sync_kiocb(iocb))
>
>  Is that any less confusing ? Or would you rather just replace the '>=" by
>  "=='.

Well the original confused the heck out of me!  yes, `if (written == count)'
should be fine: it says exactly what we want it to say.

