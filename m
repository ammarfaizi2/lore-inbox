Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278592AbRKFHto>; Tue, 6 Nov 2001 02:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278617AbRKFHtf>; Tue, 6 Nov 2001 02:49:35 -0500
Received: from zero.tech9.net ([209.61.188.187]:33039 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S278592AbRKFHt2>;
	Tue, 6 Nov 2001 02:49:28 -0500
Subject: Re: floppy driver multithreaded!!
From: Robert Love <rml@tech9.net>
To: Rajiv Malik <rmalik@noida.hcltech.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E04CF3F88ACBD5119EFE00508BBB212154F513@exch-01.noida.hcltech.com>
In-Reply-To: <E04CF3F88ACBD5119EFE00508BBB212154F513@exch-01.noida.hcltech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100+cvs.2001.11.05.15.31 (Preview Release)
Date: 06 Nov 2001 02:48:51 -0500
Message-Id: <1005032932.812.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-06 at 02:31, Rajiv Malik wrote:
> i was looking at the code of Floppy Driver by Linus, i was wondering the way
> it has been coded !! even Linus has accepted that it can be further improved
> a lot. i am thinking of making it more multithreaded, trying to find out the
> details. any help on it would be highly appreciated.

Uhm, it already is multithreaded.  Kind Of.  That is how a monolithic
kernel ends up working -- the exported floppy interface is threaded to
each running process that uses it.  So each user space thread runs the
the kernel code in its context and you get a result of the floppy driver
being multithreaded.

Then you have the backend...the block and VM layers that obviously
aren't all in the context of a user space application.  The system will
scale fine to your one floppy drive and multiple CPUs.

	Robert Love

