Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315971AbSG3SEm>; Tue, 30 Jul 2002 14:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSG3SEl>; Tue, 30 Jul 2002 14:04:41 -0400
Received: from mnh-1-19.mv.com ([207.22.10.51]:21253 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S315971AbSG3SEl>;
	Tue, 30 Jul 2002 14:04:41 -0400
Message-Id: <200207301910.OAA03142@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: async-io API registration for 2.5.29 
In-Reply-To: Your message of "Tue, 30 Jul 2002 12:59:43 -0400."
             <20020730125943.B10315@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 30 Jul 2002 14:10:35 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bcrl@redhat.com said:
> This is something  that x86-64 gets wrong by not requiring the
> vsyscall page to need an  mmap into the user's address space: UML
> cannot emulate vsyscalls by  faking the mmap.

Andrea and I talked about this a bit at KS.

IIRC, he wants vsyscall addresses to be hardcoded constants in libc.  He
doesn't want the overhead of doing an indirect call through whatever
address you get from the vsyscall_mmap() syscall.

At first glance, that breaks any hope of UML being able to virtualize that.
Any vsyscall executed by a UML process will go straight into the host kernel,
completely bypassing UML.

We did come up with a scheme that sounded to me like it would work.

/me tries to remember what it was :-)

I think it was that we provide a syscall to move the vsyscall page.  UML
will use that to relocate the host vsyscalls and map its own page there.
The final piece is that UML would be linked with a different vsyscall address.

Andrea, does that sound right?

I don't particularly like this scheme - the get-the-address-at-runtime
approach is far cleaner, but it does satisfy Andrea's need for speed.

				Jeff

