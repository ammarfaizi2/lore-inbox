Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267157AbSLQVal>; Tue, 17 Dec 2002 16:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267160AbSLQVal>; Tue, 17 Dec 2002 16:30:41 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:28657 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S267157AbSLQVak>; Tue, 17 Dec 2002 16:30:40 -0500
Date: Tue, 17 Dec 2002 16:38:38 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021217163838.C10781@redhat.com>
References: <Pine.LNX.4.44.0212170948380.2702-100000@home.transmeta.com> <3DFF6D4B.3060107@redhat.com> <1040153186.20780.11.camel@irongate.swansea.linux.org.uk> <3DFF7399.40708@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DFF7399.40708@redhat.com>; from drepper@redhat.com on Tue, Dec 17, 2002 at 10:57:29AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 10:57:29AM -0800, Ulrich Drepper wrote:
> But this is exactly what I expect to happen.  If you want to implement
> gettimeofday() at user-level you need to modify the page.  Some of the
> information the kernel has to keep for the thread group can be stored in
> this place and eventually be used by some uerlevel code  executed by
> jumping to 0xfffff000 or whatever the address is.

You don't actually need to modify the page, rather the data for the user 
level gettimeofday needs to be in a shared page and some register (like 
%tr) must expose the current cpu number to index into the data.  Either 
way, it's an internal implementation detail for the kernel to take care 
of, with multiple potential solutions.

		-ben
-- 
"Do you seek knowledge in time travel?"
