Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWH2K5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWH2K5M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 06:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWH2K5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 06:57:12 -0400
Received: from ns2.suse.de ([195.135.220.15]:59020 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932284AbWH2K5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 06:57:10 -0400
From: Andi Kleen <ak@suse.de>
To: David Howells <dhowells@redhat.com>
Subject: Re: Why Semaphore Hardware-Dependent?
Date: Tue, 29 Aug 2006 12:56:54 +0200
User-Agent: KMail/1.9.3
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>,
       Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <44F395DE.10804@yahoo.com.au> <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com>
In-Reply-To: <11861.1156845927@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608291256.54665.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 August 2006 12:05, David Howells wrote:

>Because i386 (and x86_64) can do better by using XADDL/XADDQ.

x86-64 has always used the spinlock based version.

> On i386, CMPXCHG also ties you to what registers you may use for what to some
> extent. 

We've completely given up these kinds of micro optimization for spinlocks,
which are 1000x as critical as rwsems.  And nobody was able to benchmark
a difference.

It is very very likely nobody could benchmark a difference on rwsems either.

While I'm sure it's an interesting intellectual exercise to do these
advanced rwsems it would be better for everybody else to go for a single 
maintainable C implementation.

-Andi
