Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpAfvtQ0GTzRbSMKk4agvZYJ1yw==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sat, 03 Jan 2004 01:10:01 +0000
Message-ID: <007a01c415a4$07ef2730$d100000a@sbs2003.local>
Date: Mon, 29 Mar 2004 16:39:32 +0100
From: "Andi Kleen" <ak@suse.de>
To: <Administrator@osdl.org>
Cc: <joe.korty@ccur.com>, <akpm@osdl.org>, <torvalds@osdl.org>,
        <linux-kernel@vger.kernel.org>, <albert.cahalan@ccur.com>,
        <jim.houston@ccur.com>
Subject: Re: siginfo_t fracturing, especially for 64/32-bit compatibility mode
In-Reply-To: <20040103004406.GA24876@devserv.devel.redhat.com>
References: <20040102194909.GA2990@rudolph.ccur.com><20040103012433.6aa4cafb.ak@suse.de><20040103004406.GA24876@devserv.devel.redhat.com>
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:39:32.0718 (UTC) FILETIME=[080E20E0:01C415A4]

On Fri, 2 Jan 2004 19:44:06 -0500
Jakub Jelinek <jakub@redhat.com> wrote:

> On Sat, Jan 03, 2004 at 01:24:33AM +0100, Andi Kleen wrote:
> > > rt_sigqueueinfo(2) subverts this by reserving a range of si_code
> > > values for users, and there is nothing about them to indicate to the
> > > kernel which fields of siginfo_t are actually in use.  This is not a
> > 
> > My understanding was that the syscall always only supports si_int/si_ptr.
> 
> No, why?

Because otherwise it cannot be supported in the 32bit emulation. Or rather you
won't get any conversion.

> 
> > > 
> > > The current conflicts are:
> > 
> > [...SI_TKILL, SI_ASYNCIO...] that's broken. We just cannot support that. This aspect of 
> > SuS just cannot be emulated in user space, glibc was misguided about attempting
> > it.
> 
> SI_ASYNCNL is -60, not -6.
> Negative si_code values are reserved for userspace, while positive ones are for
> kernel space.

Ok, if the kernel generates that that's broken too then.

-Andi
