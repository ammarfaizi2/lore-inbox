Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbTFLUu1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 16:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264993AbTFLUu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 16:50:26 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:23989 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264991AbTFLUu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 16:50:26 -0400
Date: Thu, 12 Jun 2003 14:00:14 -0700
From: Andrew Morton <akpm@digeo.com>
To: dmccr@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix vmtruncate race and distributed filesystem race
Message-Id: <20030612140014.32b7244d.akpm@digeo.com>
In-Reply-To: <20030612134946.450e0f77.akpm@digeo.com>
References: <133430000.1055448961@baldur.austin.ibm.com>
	<20030612134946.450e0f77.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jun 2003 21:04:11.0749 (UTC) FILETIME=[2C412150:01C33126]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
>
> do_no_page()
> {
> 	int sequence = 0;
> 	...
> 
> retry:
> 	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, &sequence);
> 	....
> 	if (vma->vm_ops->revalidate && vma->vm_opa->revalidate(vma, sequence))
> 		goto retry;
> }

And this does require that ->nopage be entered with page_table_lock held,
and that it drop it.
