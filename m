Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268447AbUI2PNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268447AbUI2PNt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 11:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268589AbUI2OxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:53:09 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:3042 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S268527AbUI2Osy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:48:54 -0400
Message-ID: <415ACACE.1020008@ammasso.com>
Date: Wed, 29 Sep 2004 09:46:38 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernelnewbies@nl.linux.org
Subject: Re: get_user_pages() still broken in 2.6
References: <4159E85A.6080806@ammasso.com>	 <20040929000325.A6758@infradead.org> <1096413678.16198.16.camel@localhost>
In-Reply-To: <1096413678.16198.16.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

> You probably want mlock(2) to keep the kernel from messing with the ptes
> at all.

mlock() can only be called via sys_mlock(), which is a user-space call. 
  Not only that, but only root can call sys_mlock().  This is not 
compatible with our needs.

 >  But, you should probably really be thinking about why you're
> accessing the page tables at all.  I count *ONE* instance in drivers/
> where page tables are accessed directly.

I access PTEs to get the physical addresses of a user-space buffer, so 
that we can DMA to/from it directly.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com
