Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752166AbWCOXhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbWCOXhO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752170AbWCOXhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:37:14 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52401 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752166AbWCOXhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:37:12 -0500
Date: Thu, 16 Mar 2006 00:37:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Zachary Amsden <zach@vmware.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VMI Interface Proposal Documentation for I386, Part 4
Message-ID: <20060315233703.GE1919@elf.ucw.cz>
References: <4415CE1C.1060608@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4415CE1C.1060608@vmware.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>     6) Interrupts must always be enabled when running code in userspace.

I'd say this breaks userspace.

This code used to work when ran as root:

void
main(void)
{
        int i;
        iopl(3);
        while (1) {
                asm volatile("cli");
                //              for (i=0; i<20000000; i++)
                for (i=0; i<1000000000; i++)
                        asm volatile("");
                asm volatile("sti");
                sleep(1);
        }
}

...and was actually useful.

>     7) IOPL semantics for userspace are changed; although userspace may be
>        granted port access, it can not affect the interrupt flag.

I'm not sure how will X like this.

								Pavel

-- 
57:        MD5CryptoServiceProvider MD5 = new MD5CryptoServiceProvider();
