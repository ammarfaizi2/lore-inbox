Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161381AbWJYUtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161381AbWJYUtl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 16:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161154AbWJYUtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 16:49:41 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:50836
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161381AbWJYUtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 16:49:40 -0400
Date: Wed, 25 Oct 2006 13:49:32 -0700 (PDT)
Message-Id: <20061025.134932.63125874.davem@davemloft.net>
To: suzuki@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Behaviour of compat_msgsnd/compat_msgrcv calls
From: David Miller <davem@davemloft.net>
In-Reply-To: <453FB3F9.9080704@in.ibm.com>
References: <453FB3F9.9080704@in.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K P <suzuki@in.ibm.com>
Date: Wed, 25 Oct 2006 11:59:05 -0700

> Is there any specific reason behind this ? Can't we just use the user 
> buffer directly instead of doing an additional copy_in_user ?
> ie,
> 	err = sys_msgrcv(first, uptr, second, msgtyp, third);

It's the cleanest way to deal with the difference in
"struct msgbuf" layout between native and compat userspace.

I guess we could make some common do_sys_msgrcv() function
that passed in a pointer to the "msgbuf" and the buffer
seperately.
