Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVF1Pfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVF1Pfu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 11:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVF1Pft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 11:35:49 -0400
Received: from [212.76.81.187] ([212.76.81.187]:38916 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S261793AbVF1PfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 11:35:22 -0400
Message-Id: <200506281535.SAA30164@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Nix'" <nix@esperi.org.uk>
Cc: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Kswapd flaw
Date: Tue, 28 Jun 2005 18:35:00 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <871x6m5yzd.fsf@amaterasu.srvr.nix>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcV77nSvIFqxlrBMSY+zHp6XBEh9IwABPCGg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nix wrote:{
On Tue, 28 Jun 2005, Al Boldi wrote:
> Hi Nix, how are you?
> You wrote: {
> On 28 Jun 2005, Al Boldi yowled:
>> Please do flush anytime, and do it in sync during OOMs; but don't 
>> evict procs especially not RUNNING procs, that is overkill.
> 
> Would you really like a system where once something was faulted in, it 
> could never leave? You'd run out of memory *awfully* fast.
> }
> 
> You should only fault if you have a place to fault to, as into a swap.
> Without swap faulting is overkill.
>
> Is it possible to change kswapd's default behaviour to not fault if 
> there is no swap?

I don't think so, except on a process-by-process basis via mlockall().
(/proc/sys/vm/swappiness lets you say that swapping is more or less
desirable, but under enough memory pressure paging *will* happen regardless
of the value of that variable.)

But I'm mystified as to why you might want to suppress paging. The only
effect of suppressing it is to reduce the amount of memory you can allocate
before you run completely out and start killing things.
}

Nix,
You start killing things because you overcommitted, when you were not
supposed to fault in the first place because you have no swap.

( I couldn't find /proc/sys/vm/swappiness in 2.4, although I heard about it
in 2.6.)

