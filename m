Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVF1S2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVF1S2U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 14:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVF1S2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 14:28:20 -0400
Received: from peabody.ximian.com ([130.57.169.10]:4798 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262189AbVF1S2Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 14:28:16 -0400
Subject: Re: wrong madvise(MADV_DONTNEED) semantic
From: Robert Love <rml@novell.com>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050628181620.GA1423@hexapodia.org>
References: <20050628134316.GS5044@implementation.labri.fr>
	 <20050628181620.GA1423@hexapodia.org>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 14:28:20 -0400
Message-Id: <1119983300.6745.1.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 11:16 -0700, Andy Isaacson wrote:

> Besides, if you read the documentation closely, it does not say what you
> think it says.
> 
>        MADV_DONTNEED
> 	      Do not expect access in the near future.  (For the time
> 	      being, the application is finished with the given range,
> 	      so the kernel can free resources associated with it.)
> 	      Subsequent accesses of pages in this range will succeed,
> 	      but will result either in reloading of the memory contents
> 	      from the underlying mapped file (see mmap) or
> 	      zero-fill-on-demand pages for mappings without an
> 	      underlying file.
> 
> You seem to think that "reloading ... from the underlying mapped file"
> means that changes are lost, but that's not implied.

This wording _does_ imply that changes are lost if the file is mapped
writable and not mysnc'ed or if the memory mapping is anonymous.

In the former, changes are dropped and the file is reread from the stale
on-disk copy.  In the latter case, the data is dropped and the pages are
zero-filled on access.

	Robert Love


