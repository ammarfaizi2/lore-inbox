Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVo/umUdGaWflQSkufmoDn/PvnaA==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Fri, 02 Jan 2004 20:34:06 +0000
Message-ID: <005c01c415a3$fba67820$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Mar 2004 16:39:11 +0100
From: "Linus Torvalds" <torvalds@osdl.org>
X-Mailer: Microsoft CDO for Exchange 2000
To: <Administrator@smtp.paston.co.uk>
Cc: <akpm@osdl.org>, <ak@suse.de>, <linux-kernel@vger.kernel.org>,
        <albert.cahalan@ccur.com>, <jim.houston@ccur.com>
Subject: Re: siginfo_t fracturing, especially for 64/32-bit compatibility mode
In-Reply-To: <20040102194909.GA2990@rudolph.ccur.com>
Content-Class: urn:content-classes:message
References: <20040102194909.GA2990@rudolph.ccur.com>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
MIME-Version: 1.0
Content-Type: TEXT/PLAIN;
	charset="US-ASCII"
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:39:12.0421 (UTC) FILETIME=[FBF50D50:01C415A3]



On Fri, 2 Jan 2004, Joe Korty wrote:
>
> siginfo_t processing is fragile when in 32 bit compatibility mode on
> a 64 bit processor.

It shouldn't be.

Inside the kernel, we should always use the "native" format (ie 64-bit). 
The fact that 64-bit architectures are broken is their bug, and the proper 
way to fix it is to make sure that everything always uses the native 
format.

We should _not_ play games with si_code etc. There is no reason to do so, 
since every entrypointe knows _statically_ whether it is given a 32-bit or 
64-bit version. That's a lot less fragile than depending on a field that 
is filled in by the user.

		Linus
