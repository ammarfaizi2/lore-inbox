Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270032AbTHGRhs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 13:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270040AbTHGRhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 13:37:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:13495 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270032AbTHGRhq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 13:37:46 -0400
Date: Thu, 7 Aug 2003 10:39:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: suparna@in.ibm.com, linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [PATCH][2.6-mm] Readahead issues and AIO read speedup
Message-Id: <20030807103930.69e497a7.akpm@osdl.org>
In-Reply-To: <200308071021.39816.pbadari@us.ibm.com>
References: <20030807100120.GA5170@in.ibm.com>
	<200308070901.01119.pbadari@us.ibm.com>
	<20030807092800.58335e84.akpm@osdl.org>
	<200308071021.39816.pbadari@us.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> We should do readahead of actual pages required by the current 
> read would be correct solution. (like Suparna suggested).

I repeat: what will be the effect of this if all those pages are already in
pagecache?

> When readahead window is closed,  slow read code will be submitting IO in 4k 
> chunks. Infact, it will wait for the IO to finish, before reading next page. 
> Isn't it?

Yes.

> How would you ensure atleast 16k worth of pages are submitted
> in a sinle chunk here ?

Need to work out why the window got itself shrunk, fix that, then constrain each
readahead chunk to the size of the application's read() if the application
just seeked, I think.

> I am hoping that forcing readhead code to read pages needed by current read 
> would address this problem.

You'll have Martin and Anton coming after you with SDET regressions.


