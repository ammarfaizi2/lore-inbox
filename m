Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbUKSJk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbUKSJk7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 04:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbUKSJk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 04:40:59 -0500
Received: from [62.206.217.67] ([62.206.217.67]:40162 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261328AbUKSJkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 04:40:55 -0500
Message-ID: <419DBFA5.8080602@trash.net>
Date: Fri, 19 Nov 2004 10:40:53 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041008 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG?] dev_close() is called with locks held
References: <419DB6BA.5040901@sw.ru>
In-Reply-To: <419DB6BA.5040901@sw.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:

> Hello,
>
> looks like a bug in 2.4/2.6 kernels:
>
> 1. dev_close() function is blocking. it calls schedule() inside and 
> calls blocking dev_deactivate() function.
>
> 2. But... call chain
> dev_ioctl() -> dev_ifsioc() -> dev_change_flags() calls dev_close() 
> under read_lock(&dev_base_lock)...
>
> Bug?

dev_change_flags is only called for SIOCSIFFLAGS. dev_ioctl
takes the rtnl semaphore in this case, so no bug.

Regards
Patrick


