Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136122AbREGNsz>; Mon, 7 May 2001 09:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136106AbREGNsq>; Mon, 7 May 2001 09:48:46 -0400
Received: from mail2.bonn-fries.net ([62.140.6.78]:3336 "HELO
	mail2.bonn-fries.net") by vger.kernel.org with SMTP
	id <S136122AbREGNsh>; Mon, 7 May 2001 09:48:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Tobias Ringstrom <tori@tellus.mine.nu>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: page_launder() bug
Date: Mon, 7 May 2001 15:49:15 +0200
X-Mailer: KMail [version 1.2]
Cc: Jonathan Morton <chromi@cyberspace.org>,
        BERECZ Szabolcs <szabi@inf.elte.hu>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.33.0105070823060.24073-100000@svea.tellus>
In-Reply-To: <Pine.LNX.4.33.0105070823060.24073-100000@svea.tellus>
MIME-Version: 1.0
Message-Id: <01050715491500.08789@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 May 2001 08:26, Tobias Ringstrom wrote:
> On Sun, 6 May 2001, David S. Miller wrote:
> > It is the most straightforward way to make a '1' or '0'
> > integer from the NULL state of a pointer.
>
> But is it really specified in the C "standards" to be exctly zero or
> one, and not zero and non-zero?

Yes, and if we did not have this stupid situation where the C language 
standard is not freely available online then you would not have had to 
ask.</rant>

> IMHO, the ?: construct is way more readable and reliable.

There is no difference in reliability.  Readability is a matter of 
opinion - my opinion is that they are equally readable.  To its credit, 
gcc produces the same ia32 code in either case:

	int foo = 999;
	return 1 + !!foo;

<main+6>:	movl   $0x3e7,0xfffffffc(%ebp)
<main+13>:	cmpl   $0x0,0xfffffffc(%ebp)
<main+17>:	je     0x80483e0 <main+32>
<main+19>:	mov    $0x2,%eax
<main+24>:	jmp    0x80483e5 <main+37>
<main+26>:	lea    0x0(%esi),%esi
<main+32>:	mov    $0x1,%eax
<main+37>:	mov    %eax,%eax

	int foo = 999;
	return foo? 2: 1;

<main+6>:	movl   $0x3e7,0xfffffffc(%ebp)
<main+13>:	cmpl   $0x0,0xfffffffc(%ebp)
<main+17>:	je     0x80483e0 <main+32>
<main+19>:	mov    $0x2,%eax
<main+24>:	jmp    0x80483e5 <main+37>
<main+26>:	lea    0x0(%esi),%esi
<main+32>:	mov    $0x1,%eax
<main+37>:	mov    %eax,%eax

--
Daniel
