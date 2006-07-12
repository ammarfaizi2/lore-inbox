Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWGLWuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWGLWuW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWGLWuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:50:22 -0400
Received: from [81.2.110.250] ([81.2.110.250]:36552 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932403AbWGLWuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:50:21 -0400
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>,
       Jakub Jelinek <jakub@redhat.com>, Ulrich Drepper <drepper@redhat.com>,
       Roland McGrath <roland@redhat.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
In-Reply-To: <m1zmfe794e.fsf@ebiederm.dsl.xmission.com>
References: <20060712184412.2BD57180061@magilla.sf.frob.com>
	 <44B54EA4.5060506@redhat.com> <20060712195349.GW3823@sunsite.mff.cuni.cz>
	 <44B556E5.5000702@zytor.com> <m1k66i8ql5.fsf@ebiederm.dsl.xmission.com>
	 <1152739766.3217.83.camel@laptopd505.fenrus.org>
	 <m1bqru8p36.fsf@ebiederm.dsl.xmission.com>
	 <1152741665.3217.85.camel@laptopd505.fenrus.org>
	 <44B57191.5000802@zytor.com>  <m1zmfe794e.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Jul 2006 00:07:44 +0100
Message-Id: <1152745664.22943.115.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-07-12 am 16:26 -0600, ysgrifennodd Eric W. Biederman:
> If the lock is not short lived then the release is like to be a long
> ways off.  If the lock is not highly contended then you are not likely
> to hit the window when someone else as the contended lock.
> 
> How frequent are highly contended short lived locks in user space?

I'm not sure it matters.

If you want to do the job right then do this

- Stick an indicator of how much else wants to run on this CPU in the
vsyscall page or similar location

In your locks you can now do

              while(try_and_grab_lock() == FAILED) {
                       if (kernelpage->waiting > 0)
                              sys_somelockwaitthing()
              }

Furthermore the kernel can be intelligent about the waiting indicator
for power or other global scheduling reasons

[Disclaimer: There is a patent issue around this technique but its not
one that will impact GPL code as permissions are given for GPL use.]

Alan

