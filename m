Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263021AbVAFUPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263021AbVAFUPh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbVAFUPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:15:37 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:41964 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263021AbVAFUFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:05:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=O5wDU685yrLYwzPh3/WG7HpQyb/BrbUPdqicxi9SQaC2dTFe/K5mE7KduZ9zr8FI6JioM1a4ffcYnGk0k+Q/7Tz3EecijE/YrvzuLWUm2Tn/oY+rCSchjovxxr8ANUTaJmB0BscGrKq53Qu6RR7qHsZNHwSIYq2Wfqet/sd0/ko=
Message-ID: <9e4733910501061205354c9508@mail.gmail.com>
Date: Thu, 6 Jan 2005 15:05:49 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Andi Kleen <ak@muc.de>
Subject: Re: chasing the four level page table
Cc: linux-kernel@vger.kernel.org, DRI Devel <dri-devel@lists.sourceforge.net>
In-Reply-To: <20050106193826.GC47320@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105010609175dabc381@mail.gmail.com> <m1vfaav340.fsf@muc.de>
	 <9e47339105010610362fd7fffe@mail.gmail.com>
	 <20050106193826.GC47320@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Jan 2005 20:38:27 +0100, Andi Kleen <ak@muc.de> wrote:
> You can't use get_user_pages in this case because the AGP aperture
> can be above mem_map.  If none of the callers take page_table_lock
> already you would need to add that too. I guess from the context the lock
> is not taken, but better double check.
> 
> Perhaps we should add a get_user_phys() or somesuch for this.

No where in DRM is page_table_lock being taken.  Also, no other device
driver takes page_table_lock either, so that probably implies that DRM
shouldn't start doing it to. Best solution would probably be add an mm
function for get_user_phys() that takes the lock internally. If you
add the function I'll convert DRM to use it.

-- 
Jon Smirl
jonsmirl@gmail.com
