Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbVBVXPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbVBVXPo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 18:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVBVXPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 18:15:44 -0500
Received: from fire.osdl.org ([65.172.181.4]:9431 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261335AbVBVXP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 18:15:26 -0500
Date: Tue, 22 Feb 2005 15:20:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: olof@austin.ibm.com (Olof Johansson)
Cc: jamie@shareable.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
Message-Id: <20050222152027.7ace52e8.akpm@osdl.org>
In-Reply-To: <20050222224256.GA31341@austin.ibm.com>
References: <20050222190646.GA7079@austin.ibm.com>
	<20050222115503.729cd17b.akpm@osdl.org>
	<20050222210752.GG22555@mail.shareable.org>
	<Pine.LNX.4.58.0502221317270.2378@ppc970.osdl.org>
	<20050222223457.GK22555@mail.shareable.org>
	<20050222224256.GA31341@austin.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

olof@austin.ibm.com (Olof Johansson) wrote:
>
> +		inc_preempt_count();
> +		ret = get_user(curval, (int __user *)uaddr1);
> +		dec_preempt_count();

That _should_ generate a might_sleep() warning, except it looks like we
forgot to add a check to get_user().

It would be better to use __copy_from_user_inatomic() here, I think.
