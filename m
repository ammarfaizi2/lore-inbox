Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265252AbUAPBtW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 20:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbUAPBtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 20:49:22 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:16411 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265252AbUAPBtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 20:49:19 -0500
Date: Thu, 15 Jan 2004 17:48:58 -0800
From: Paul Jackson <pj@sgi.com>
To: joe.korty@ccur.com
Cc: akpm@osdl.org, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040115174858.053b6569.pj@sgi.com>
In-Reply-To: <20040116004807.GA32289@tsunami.ccur.com>
References: <20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
	<20040108225929.GA24089@tsunami.ccur.com>
	<16381.61618.275775.487768@cargo.ozlabs.ibm.com>
	<20040114150331.02220d4d.pj@sgi.com>
	<20040115002703.GA20971@tsunami.ccur.com>
	<20040114204009.3dc4c225.pj@sgi.com>
	<20040115081533.63c61d7f.akpm@osdl.org>
	<20040115181525.GA31086@tsunami.ccur.com>
	<20040115161732.458159f5.pj@sgi.com>
	<20040116004807.GA32289@tsunami.ccur.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe wrote:
> I would prefer that we provoke each other until Andrew finds something
> that he likes:)

Drat ;).  Perhaps Andrew will elaborate on his "gad", and I will have
some clue of whether it is worth responding with another variant.
Clearly something in my last patch looked ugly to him.


> I would prefer that the commas on input be optional, and when present
> silently skipped over.

This wasn't an option before, in my variations that didn't zero-fill each
chunk.  But with your zero-fill, which I agree is better, this is possible.

Not a bad idea.  Another instance of Postel's Prescription:

   Be liberal in what you accept, and conservative in what you send.
     http://www.postel.org/postel.html
   Referenced in: Basics of the Unix Philosophy
     http://www.faqs.org/docs/artu/ch01s06.html

Though possibly a violation of the Rule of Composition:

   Design programs to be connected to other programs.

If commas are optional on input, then a user level program that
generates such masks could not always feed them to another user level
program that reads them.  The reader might require exact comma placement
that the producer didn't provide.

Since the primary "documentation" for this format will be what is
displayed when someone does "cat /proc/irq/prof_cpu_mask", I rather
think that the design format should be exactly what displays here,
including exact comma separation, both displaying and parsing.


> I think it important that we display exactly what the bitmask represents,
> no more and no less.  This is a philosophical point, to be sure.

Purely philosophical, as best as I can tell.  All the other bitmask
stuff works on objects that are some number of words in size.  I see no
use whatsoever for this additional complexity.

Unless you can show me a need for this, I think it is overdesign.


> In any case I think we should not have the display change from one
> machine to the next, simply because the size of the underlying
> 'unsigned long' changed underneath us.

Huh?  I am unware that my code displays differently depending on whether
the underling "unsigned long" is 4 or 8 bytes.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
