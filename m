Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264719AbUFCXiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264719AbUFCXiF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 19:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264790AbUFCXiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 19:38:05 -0400
Received: from holomorphy.com ([207.189.100.168]:55713 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264719AbUFCXiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 19:38:03 -0400
Date: Thu, 3 Jun 2004 16:37:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, len.brown@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [APIC] Avoid change apic_id failure panic
Message-ID: <20040603233748.GN21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, len.brown@intel.com,
	linux-kernel@vger.kernel.org
References: <20040603101313.GB6578@gondor.apana.org.au> <20040603162045.7a335350.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603162045.7a335350.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:
>> I've received two reports at http://bugs.debian.org/251207 where
>> ioapic caused machines to lock up during booting due to the
>> change apic_id panic in arch/i386/kernel/io_apic.c.
>> Since it appears that we can avoid panicking at all, I think we
>> should replace the panic calls with the following patch which
>> attempts to continue after the failure.
>> I've also done the same thing to the other panic() call in the
>> same function.

On Thu, Jun 03, 2004 at 04:20:45PM -0700, Andrew Morton wrote:
> Well.  Question is, why are we getting insame APIC ID's in there in the
> first place?

They're usually not insane. xAPIC's have 8-bit physical ID's, not 4-bit,
but no one's bothered tracking whether the APIC's found were serial APIC
or xAPIC, and then dispatching on that in the IO-APIC physid check to
avoid unnecessarily renumbering the things or panicking.

This is my longstanding complaint regarding APIC_BROADCAST_ID being wrong.


-- wli
