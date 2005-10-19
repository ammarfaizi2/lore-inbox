Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbVJSSwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVJSSwe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 14:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVJSSwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 14:52:34 -0400
Received: from mail.fortunecookiestudios.com ([209.208.122.204]:63762 "EHLO
	momo.creolmail.org") by vger.kernel.org with ESMTP id S1751216AbVJSSwd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 14:52:33 -0400
Message-ID: <435695EE.4090704@cfl.rr.com>
Date: Wed, 19 Oct 2005 14:52:30 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
Cc: Jeff Bailey <jbailey@ubuntu.com>, linux-kernel@vger.kernel.org,
       ubuntu-devel <ubuntu-devel@lists.ubuntu.com>
Subject: Re: Keep initrd tasks running?
References: <4355494C.5090707@comcast.net> <1129663759.18784.98.camel@localhost.localdomain> <4355BEF4.8000800@cfl.rr.com> <4355C9F3.40004@comcast.net>
In-Reply-To: <4355C9F3.40004@comcast.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought that the key difference between initrd and initramfs is that 
initrd uses pivot_root, initramfs does not.  From what I have read, some 
consider pivit_root to be an ugly hack, so initramfs was made in such a 
way that you don't pivot.  Is this incorrect?

The whole reason that pivot was made was to allow the initrd filesystem 
to be moved and the real root mounted, all while processes ( at least 
init, because it can't exit ) continued to execute, maintaining their 
open files on the initrd filesystem.  Just instead of those files being 
in / they got moved to /initrd.

Under that system it is possible to leave things running, but I thought 
that with initramfs, init actually exited and the kernel unmounted the 
initramfs, and mounted the real root and ran the real init.

John Richard Moser wrote:
> 
> AFAIK it's pivoted and then umounted, which frees it.  This doesn't mean
> it has to be freed..  . .
> 
> 
