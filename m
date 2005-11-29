Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbVK2Pxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbVK2Pxx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 10:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbVK2Pxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 10:53:53 -0500
Received: from nevyn.them.org ([66.93.172.17]:37609 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1751385AbVK2Pxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 10:53:52 -0500
Date: Tue, 29 Nov 2005 10:53:46 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>,
       linux-kernel@vger.kernel.org, drepper@redhat.com,
       linuxppc-dev@ozlabs.org, akpm@osdl.org
Subject: Re: [PATCH] 3/3 Generic sys_rt_sigsuspend
Message-ID: <20051129155346.GA25431@nevyn.them.org>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, akpm@osdl.org
References: <1133225007.31573.86.camel@baythorne.infradead.org> <1133225852.31573.115.camel@baythorne.infradead.org> <438BE48B.9060908@kolumbus.fi> <1133260923.31573.131.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133260923.31573.131.camel@baythorne.infradead.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 10:42:03AM +0000, David Woodhouse wrote:
> I believe not. The previous versions would loop until do_signal()
> returned non-zero; i.e. until a signal was actually delivered.
> By returning -ERESTARTNOHAND we achieve the same effect. If there's a
> signal delivered, that gets magically converted to -EINTR, but if
> there's no signal delivered, the syscall gets restarted.

And, crazy coincidence, I think this will fix the recently reported
ptrace attach bug.  Right now if you ptrace a process stuck in
sigsuspend, you can't easily force it to return to userspace.
I'll test that if these patches are merged.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
