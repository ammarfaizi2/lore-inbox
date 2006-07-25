Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbWGYTLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbWGYTLB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWGYTLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:11:01 -0400
Received: from terminus.zytor.com ([192.83.249.54]:21657 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964821AbWGYTLA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:11:00 -0400
Message-ID: <44C66C91.8090700@zytor.com>
Date: Tue, 25 Jul 2006 12:10:09 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Neil Horman <nhorman@tuxdriver.com>
CC: Segher Boessenkool <segher@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, a.zummo@towertech.it, jg@freedesktop.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
References: <20060725174100.GA4608@hmsreliant.homelinux.net> <03BCDC7F-13D9-42FC-86FC-30C76FD3B3B8@kernel.crashing.org> <20060725182833.GE4608@hmsreliant.homelinux.net>
In-Reply-To: <20060725182833.GE4608@hmsreliant.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman wrote:
>
> In general I agree, but that only works if you operate on a platform that
> supports virtual syscalls, and has vdso configured.  I'm not overly familiar
> with vdso, but I didn't think vdso could be supported on all platforms/arches.
> This seems like it might be a nice addition in those cases.
> 

Not really.  This introduces a potentially very difficult support 
user-visible interface.  Consider a tickless kernel -- you might end up 
taking tick interrupts ONLY to update this page, since you don't have 
any way of knowing when userspace wants to look at it.

	-hpa
