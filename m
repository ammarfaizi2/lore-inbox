Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbWIEQF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbWIEQF1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 12:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbWIEQF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 12:05:27 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:60387 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S965064AbWIEQF0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 12:05:26 -0400
Message-ID: <44FDA024.7030700@in.ibm.com>
Date: Tue, 05 Sep 2006 21:34:52 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hugh Dickins <hugh@veritas.com>, Matt Helsley <matthltc@us.ibm.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org, Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [PATCH 5/13] BC: user interface (syscalls)
References: <44FD918A.7050501@sw.ru> <44FD9699.705@sw.ru>
In-Reply-To: <44FD9699.705@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +asmlinkage long sys_set_bcid(bcid_t id)
> +{
> +	int error;
> +	struct beancounter *bc;
> +	struct task_beancounter *task_bc;
> +
> +	task_bc = &current->task_bc;

I was playing around with the bc patches and found that to make
use of bc's, I had to actually call set_bcid() and then exec() a
task/shell so that the id would stick around. Would you consider
changing sys_set_bcid to sys_set_task_bcid() or adding a new
system call sys_set_task_bcid()? We could pass the pid that we
intend to associate with the new id. This also means we'll need
locking around to protect task->task_bc.


-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
