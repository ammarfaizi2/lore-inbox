Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpAfxn7ZAv+DLTT67a9vAj4RsKA==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sat, 03 Jan 2004 00:46:02 +0000
Message-ID: <007d01c415a4$07f3e220$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Mar 2004 16:39:32 +0100
From: "Jakub Jelinek" <jakub@redhat.com>
X-Mailer: Microsoft CDO for Exchange 2000
To: <Administrator@osdl.org>
Cc: "Joe Korty" <joe.korty@ccur.com>, <akpm@osdl.org>, <torvalds@osdl.org>,
        <linux-kernel@vger.kernel.org>, <albert.cahalan@ccur.com>,
        <jim.houston@ccur.com>
Subject: Re: siginfo_t fracturing, especially for 64/32-bit compatibility mode
Reply-To: "Jakub Jelinek" <jakub@redhat.com>
Content-Class: urn:content-classes:message
References: <20040102194909.GA2990@rudolph.ccur.com> <20040103012433.6aa4cafb.ak@suse.de>
Importance: normal
Priority: normal
MIME-Version: 1.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20040103012433.6aa4cafb.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:39:32.0750 (UTC) FILETIME=[081302E0:01C415A4]

On Sat, Jan 03, 2004 at 01:24:33AM +0100, Andi Kleen wrote:
> > rt_sigqueueinfo(2) subverts this by reserving a range of si_code
> > values for users, and there is nothing about them to indicate to the
> > kernel which fields of siginfo_t are actually in use.  This is not a
> 
> My understanding was that the syscall always only supports si_int/si_ptr.

No, why?

> > 
> > The current conflicts are:
> 
> [...SI_TKILL, SI_ASYNCIO...] that's broken. We just cannot support that. This aspect of 
> SuS just cannot be emulated in user space, glibc was misguided about attempting
> it.

SI_ASYNCNL is -60, not -6.
Negative si_code values are reserved for userspace, while positive ones are for
kernel space.

	Jakub
