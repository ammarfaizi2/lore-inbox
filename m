Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbWBPOlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbWBPOlP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 09:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWBPOlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 09:41:15 -0500
Received: from [81.2.110.250] ([81.2.110.250]:12213 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932527AbWBPOlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 09:41:14 -0500
Subject: Re: [PATCH 0/2] strndup_user, v2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Davi Arnaut <davi.arnaut@gmail.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060216005609.fbc35236.davi.arnaut@gmail.com>
References: <20060215182258.03505613.davi.arnaut@gmail.com>
	 <1140053156.14831.43.camel@localhost.localdomain>
	 <20060216005609.fbc35236.davi.arnaut@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Feb 2006 14:44:30 +0000
Message-Id: <1140101070.28094.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-02-16 at 00:56 -0300, Davi Arnaut wrote:
> strlen_user returns _0_ on exception. If you don't belive me,
> kernel/module.c or arch/x86_64/lib/usercopy.c are a good starting
> point.

My fault, I forgot that someone made strnlen_user weird, the rest looks
correct.

In fact drivers/s390/char/keyboard.c like me appears to have a rather
confused understanding of the return code, but can now make good use of
your strndup_user function.

               len = strnlen_user(u_kbs->kb_string,
                                   sizeof(u_kbs->kb_string) - 1);
                if (!len)
                        return -EFAULT;
                if (len > sizeof(u_kbs->kb_string) - 1)
                        return -EINVAL;
                p = kmalloc(len + 1, GFP_KERNEL);
                if (!p)
                        return -ENOMEM;
                if (copy_from_user(p, u_kbs->kb_string, len)) {
                        kfree(p);
                        return -EFAULT;
                }
                p[len] = 0;


Alan

