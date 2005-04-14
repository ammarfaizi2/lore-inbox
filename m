Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVDNJg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVDNJg5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 05:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVDNJg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 05:36:57 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:47069 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261462AbVDNJgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 05:36:55 -0400
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Further copy_from_user() discussion.
References: <Pine.LNX.4.58.0504131342530.14888@shell4.speakeasy.net>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 14 Apr 2005 10:36:47 +0100
Message-ID: <tnxzmw1d7io.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vadim Lobanov <vlobanov@speakeasy.net> wrote:
> 2. Would it be possible to eliminate the might_sleep() call in
> copy_from_user()? It seems that, very soon after, the __copy_from_user()
> macro does another might_sleep(), with very few instructions in between.
> But there might be some trick here that I'm missing.

might_sleep() is used for debugging the possible sleep while in an
atomic operation. I think it is safe to check this for all the calls
to copy_from_user(), no matter if the access is OK or not (memset
being used in the latter case). The same is for
__copy_from_user(). Anyway, if you don't enable
CONFIG_DEBUG_SPINLOCK_SLEEP, the might_sleep() macro is empty.

-- 
Catalin

