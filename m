Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpIirf0FrMVU7TkWccSgmCao40A==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 20:46:10 +0000
Message-ID: <023e01c415a4$88abd940$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Date: Mon, 29 Mar 2004 16:43:08 +0100
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
From: "Linus Torvalds" <torvalds@osdl.org>
To: <Administrator@smtp.paston.co.uk>
Cc: "Srivatsa Vaddagiri" <vatsa@in.ibm.com>,
        "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <manfred@colorfullife.com>, <rusty@au1.ibm.com>,
        "Andrew Morton" <akpm@osdl.org>
Subject: Re: BUG in x86 do_page_fault?  [was Re: in_atomic doesn't count local_irq_disable?]
In-Reply-To: <20040104145736.GA11198@elf.ucw.cz>
References: <3FF044A2.3050503@colorfullife.com> <20031230185615.A9292@in.ibm.com> <20031231185959.A9041@in.ibm.com> <Pine.LNX.4.58.0312311104180.2065@home.osdl.org> <20040104145736.GA11198@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN;
	charset="US-ASCII"
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:43:11.0078 (UTC) FILETIME=[8A353860:01C415A4]



On Sun, 4 Jan 2004, Pavel Machek wrote:
> > 
> > Please don't do this, it will result in some _really_ nasty problems with 
> > X and other programs that potentially disable interrupts in user
> > space.
> 
> If user program causes page fault with interrupts disabled, it is
> certainly buggy, right?

No.

It may do a best-effort thing. It may also do a best-_performance_ thing, 
in leaving interrupts disabled over a piece of code that doesn't care, 
knowing that disabling interrupts is expensive.  Or it may just be a 
simple case of simplicity: disable interrupts over the whole region, 
knowing that only a part of it matters.

It by no means is automatically a bug. And it unquestionably _does_ 
happen. We used to warn about it. We stopped.

		Linus
