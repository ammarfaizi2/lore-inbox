Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136739AbREAWLR>; Tue, 1 May 2001 18:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136740AbREAWLH>; Tue, 1 May 2001 18:11:07 -0400
Received: from colorfullife.com ([216.156.138.34]:16905 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S136739AbREAWLD>;
	Tue, 1 May 2001 18:11:03 -0400
Message-ID: <3AEF346D.FB01EAE9@colorfullife.com>
Date: Wed, 02 May 2001 00:10:53 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: bergsoft@home.com, linux-kernel@vger.kernel.org
Subject: Re: Followup to previous post: Atlon/VIA Instabilities
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So it seems that CONFIG_X86_USE_3DNOW is simply used to 
> enable access to the routines in mmx.c (the athlon-optimized 
> routines on CONFIG_K7 kernels), so then it appears that somehow 
> this is corrupting memory / not behaving as it should (very 
> technical, right?) :)... 

Do you use any unusual (binary only/with source) kernel modules?

mmx.c stores the current contents on the fpu registers into
current->thread.i387.f{,x}save.
If another module modifes the fpu registers and calls memmove it will
cause fpu corruptions.

I checked that a few months ago, and no module in the main kernel tree
does that.

--
	Manfred
