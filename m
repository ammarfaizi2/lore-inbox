Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbVA0Gsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbVA0Gsq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 01:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbVA0Gsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 01:48:46 -0500
Received: from rain.plan9.de ([193.108.181.162]:61363 "EHLO rain.plan9.de")
	by vger.kernel.org with ESMTP id S262513AbVA0Gso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 01:48:44 -0500
Date: Thu, 27 Jan 2005 07:48:39 +0100
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: critical bugs in md raid5
Message-ID: <20050127064839.GA32165@schmorp.de>
Mail-Followup-To: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
References: <20050127035906.GA7025@schmorp.de> <m1vf9j4fsp.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1vf9j4fsp.fsf@muc.de>
X-PGP: "1024D/DA743396 1999-01-26 Marc Alexander Lehmann <schmorp@schmorp.de>
       Key fingerprint = 475A FE9B D1D4 039E 01AC  C217 A1E8 0270 DA74 3396"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 06:11:34AM +0100, Andi Kleen <ak@muc.de> wrote:
> Marc Lehmann <linux-kernel@plan9.de> writes:
> >
> > The summary seems to be that the linux raid driver only protects your data
> > as long as all disks are fine and the machine never crashes.
> 
> "as long as the machine never crashes". That's correct. If you think

Thanks for your thoughts, btw :)

I forgot to mention that even if data is known to be lost it's much better
to return, say, EIO to higher levels than to completely shut down the
device (after all, this is no differnce to what other block devices behave).

Also, it's still likely that some old error can be repaired, as the broken
non-parity block might be old. This is probably better to be handled in
userspace, though, with special tools. But for them it might be vital to
get the correct disk index, to be able to detect the stripe layout.

It's usually much faster to repair and verify, as opposed to format and
restore, of course.

-- 
                The choice of a
      -----==-     _GNU_
      ----==-- _       generation     Marc Lehmann
      ---==---(_)__  __ ____  __      pcg@goof.com
      --==---/ / _ \/ // /\ \/ /      http://schmorp.de/
      -=====/_/_//_/\_,_/ /_/\_\      XX11-RIPE
