Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWIFI3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWIFI3z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 04:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWIFI3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 04:29:54 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:56944 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932662AbWIFI3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 04:29:33 -0400
Message-ID: <44FE86EF.3050101@openvz.org>
Date: Wed, 06 Sep 2006 12:29:35 +0400
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hugh Dickins <hugh@veritas.com>, Matt Helsley <matthltc@us.ibm.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Oleg Nesterov <oleg@tv-sign.ru>,
       devel@openvz.org, Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [PATCH 5/13] BC: user interface (syscalls)
References: <44FD918A.7050501@sw.ru> <44FD9699.705@sw.ru> <44FDA024.7030700@in.ibm.com>
In-Reply-To: <44FDA024.7030700@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
>> +
>> +asmlinkage long sys_set_bcid(bcid_t id)
>> +{
>> +    int error;
>> +    struct beancounter *bc;
>> +    struct task_beancounter *task_bc;
>> +
>> +    task_bc = &current->task_bc;
>
> I was playing around with the bc patches and found that to make
> use of bc's, I had to actually call set_bcid() and then exec() a
> task/shell so that the id would stick around. Would you consider
That sounds very strange as sys_set_bcid() actually changes current's
exec_bc.
One note is about mm's bc - mm obtains new bc only after fork or exec -
that's
true. But kmemsize starts charging right after the sys_set_bcid.
> changing sys_set_bcid to sys_set_task_bcid() or adding a new
> system call sys_set_task_bcid()? We could pass the pid that we
> intend to associate with the new id. This also means we'll need
> locking around to protect task->task_bc.

