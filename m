Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWC3DuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWC3DuY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 22:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWC3DuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 22:50:24 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:51632 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750953AbWC3DuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 22:50:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=gRYOjyCZ70NXS1fyR8p4Bw4otnqpkHbR2+Ax5oPZMG/8dSQDdnyLCO/nYCHk3q+uKOw3AOCub83uu5y7DgBbfVnVut5mC0d038dzsW9FwN4gds1YCMvUrnrd/hV00I0RuFZh2LE8YIuOboNafYTuf6vBHylQkHXMJetaNI4Rt6k=  ;
Message-ID: <442B3AE9.7090102@yahoo.com.au>
Date: Thu, 30 Mar 2006 12:56:57 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Christoph Lameter'" <clameter@sgi.com>,
       Zoltan Menyhart <Zoltan.Menyhart@free.fr>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Fix unlock_buffer() to work the same way as bit_unlock()
References: <200603290139.k2T1d1g00702@unix-os.sc.intel.com> <442A7AA6.7080206@bull.net>
In-Reply-To: <442A7AA6.7080206@bull.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan Menyhart wrote:

>
> 4. Bit-lock operations:
>
> I summarized the ordering requirements here:
> http://marc.theaimsgroup.com/?l=linux-ia64&m=114362989421046&w=2
>
> In order to let the architectures implement these bit-lock
> operations efficiently, the usage has to indicate the _minimal_
> required ordering semantics, e.g.:
>
>     test_and_set_bit_N_acquire()
> or   ordered_test_and_set_bit(acquire, ...)
>     release_N_clear_bit()
> etc.
>

The problem is simply that we don't expose acquire or release
ordering operations to AI kernel code (outside of locking, which
is a great wrapper). The reason is to avoid proliferation of all
these semantics.

If you do this then the powerpc guys will say they want all
their weird crap in there too. If you remove seperate read
and write barriers, then x86 and sparc64 folks will get upset
etc etc.

Changing semantics would probably require some fairly hefty
discussions. Can you first fix ia64, then (perhaps) introduce
lock semantics for the couple of bitops that can use it, then
can we see some performance justification for proposed
changes to the API?

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
