Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287002AbSBGPsC>; Thu, 7 Feb 2002 10:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287348AbSBGPrw>; Thu, 7 Feb 2002 10:47:52 -0500
Received: from trained-monkey.org ([209.217.122.11]:55559 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S287002AbSBGPrm>; Thu, 7 Feb 2002 10:47:42 -0500
From: Jes Sorensen <jes@trained-monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15458.41366.1639.628598@trained-monkey.org>
Date: Thu, 7 Feb 2002 10:47:33 -0500
To: Christian Hildner <christian.hildner@hob.de>
Cc: davidm@hpl.hp.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-ia64] kmalloc() size-limitation
In-Reply-To: <3C5F80F2.54AF98E3@hob.de>
In-Reply-To: <3C3D6A89.27EAA4C7@hob.de>
	<15421.61910.163437.45726@napali.hpl.hp.com>
	<3C3ED5E7.8BA479B7@hob.de>
	<15423.5404.65155.924018@napali.hpl.hp.com>
	<3C43D6EC.74B4EC85@hob.de>
	<d31yg1lzgm.fsf@lxplus052.cern.ch>
	<3C5F80F2.54AF98E3@hob.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christian" == Christian Hildner <christian.hildner@hob.de> writes:

Christian> Jes Sorensen schrieb:
>> Because drivers needs to work on all architectures and relying on
>> different hahavior from kmalloc() is bad.

Christian> sorry for being unclear. I mean from increasing the kmalloc()
Christian> size-limit all platforms would benefit.

Thats not really a good idea, and definately not something you want to
rely on. A lot of architectures are still stuck with 4KB pages and
trying to allocate 128KB on larger in one chunk is likely to fail after
the system has been running for a while. On an ia64 with 16KB or 64KB
pages it's fairly likely it will work, but this is not necessarily a
good idea to do for other archs. If you need such a large block of
memory, vmalloc() is the real way to go.

Jes
