Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWCaQUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWCaQUe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 11:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWCaQUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 11:20:34 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:11399 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751397AbWCaQUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 11:20:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=LyhpuaknFDy4z9TNbz07E6eibeS8yRsv1UfI9fJdP7SGrMhNmxakx7fpRM/7DY0kkpAOcJaclm9p8DAh+l8RQN+kbJn0BlXpEwUa1WNN/Ey5I42Ycc3OIO77vKBHaHCsomdlb8M+sGsFijQDtV3PsJyRaMHTxQS+rNgBmybS0Hw=  ;
Message-ID: <442CDB98.80803@yahoo.com.au>
Date: Fri, 31 Mar 2006 17:34:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Christoph Lameter'" <clameter@sgi.com>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Synchronizing Bit operations V2
References: <200603310614.k2V6Ehg30012@unix-os.sc.intel.com>
In-Reply-To: <200603310614.k2V6Ehg30012@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Nick Piggin wrote on Thursday, March 30, 2006 6:53 PM

>>The memory ordering that above combination should produce is a
>>Linux style smp_mb before the clear_bit. Not a release.
> 
> 
> Whoever designed the smp_mb_before/after_* clearly understand the
> difference between a bidirectional smp_mb() and a one-way memory
> ordering.  If smp_mb_before/after are equivalent to smp_mb, what's
> the point of introducing another interface?
> 

They are not. They provide equivalent barrier when performed
before/after a clear_bit, there is a big difference.

You guys (ia64) are the ones who want to introduce a new
interface, because you think conforming to the kernel's current
interfaces will be too costly. I simply suggested a way you
could do this that would have a chance of being merged.

If you want to change the semantics of smp_mb__*, then good
luck auditing all that well documented code that uses it.
I just happen to think your best bet is to stick with the
obvious full barrier semantics (which is what other
architectures, eg powerpc do), and introduce something new
if you want more performance.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
