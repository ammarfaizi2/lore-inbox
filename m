Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266894AbUIAPjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266894AbUIAPjU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 11:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUIAPjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:39:18 -0400
Received: from holomorphy.com ([207.189.100.168]:19398 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266925AbUIAPi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:38:26 -0400
Date: Wed, 1 Sep 2004 08:38:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kirill Korotaev <kksx@mail.ru>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] obscure pid implementation fix (v2)
Message-ID: <20040901153822.GB5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kirill Korotaev <kksx@mail.ru>, akpm@osdl.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <E1C2TZ1-000JZr-00.kksx-mail-ru@f7.mail.ru> <20040901153624.GA5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901153624.GA5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 03:46:07PM +0400, Kirill Korotaev wrote:
>> I remade the previous patch against the latest Linus tree, please apply.
>> This patch fixes strange and obscure pid implementation in current kernels:
>> - it removes calling of put_task_struct() from detach_pid()
>>   under tasklist_lock. This allows to use blocking calls
>>   in security_task_free() hooks (in __put_task_struct()).
>> - it saves some space = 5*5 ints = 100 bytes in task_struct
>> - it's smaller and tidy, more straigthforward and doesn't use
>>   any knowledge about pids using and assignment.
>> - it removes pid_links and pid_struct doesn't hold reference counters
>>   on task_struct. instead, new pid_structs and linked altogether and
>>   only one of them is inserted in hash_list.
>> Signed-off-by: Kirill Korotaev (kksx@mail.ru)

On Wed, Sep 01, 2004 at 08:36:24AM -0700, William Lee Irwin III wrote:
> Could you not rename struct pid and not rename for_each_task_pid()?

And not rename ->hash_chain.

Thanks.


-- wli
