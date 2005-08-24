Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbVHXQSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVHXQSn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVHXQSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:18:43 -0400
Received: from cantor.suse.de ([195.135.220.2]:64996 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751107AbVHXQSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:18:42 -0400
To: Hiro Yoshioka <hyoshiok@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
References: <20050818.201138.607962419.hyoshiok@miraclelinux.com.suse.lists.linux.kernel>
	<98df96d30508181629d85edb5@mail.gmail.com.suse.lists.linux.kernel>
	<20050823.081246.846946371.hyoshiok@miraclelinux.com.suse.lists.linux.kernel>
	<20050824.231156.278740508.hyoshiok@miraclelinux.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 24 Aug 2005 18:18:36 +0200
In-Reply-To: <20050824.231156.278740508.hyoshiok@miraclelinux.com.suse.lists.linux.kernel>
Message-ID: <p73ll2rfgv7.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiro Yoshioka <hyoshiok@miraclelinux.com> writes:

> Hi,
> 
> The following patch does not use MMX regsiters so that we don't have
> to worry about save/restore the FPU/MMX states.
> 
> What do you think?

Performance will probably be bad on K7 Athlons - those have a microcoded
movnti which is quite slow.

Also BTW I don't see any code anywhere that tests the CPUID bits,
so your code will fail spectacularly on a PII that didn't do SSE
(intel user copy used to be enabled on those) 

One way to solve this might be to use different code using
alternative()

-Andi
