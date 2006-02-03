Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWBCFDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWBCFDq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 00:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWBCFDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 00:03:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56765 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751161AbWBCFDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 00:03:45 -0500
Date: Fri, 3 Feb 2006 00:03:30 -0500
From: Dave Jones <davej@redhat.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Avi Kivity <avi@argo.co.il>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: discriminate single bit error hardware failure from slab corruption.
Message-ID: <20060203050330.GA3171@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Roland Dreier <rdreier@cisco.com>, Avi Kivity <avi@argo.co.il>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060202192414.GA22074@redhat.com> <43E2A784.2070809@argo.co.il> <20060203014645.GD10209@redhat.com> <43E2BA63.5050505@argo.co.il> <20060203042035.GF10209@redhat.com> <ada3bj1xde1.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada3bj1xde1.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 08:41:26PM -0800, Roland Dreier wrote:
 >     Dave> Hmm, I made a mistake in my maths somewhere, and some of
 >     Dave> those values are incorrect, so having the compiler do the
 >     Dave> work would have stopped me screwing up, but once the correct
 >     Dave> values are used, I doubt there's ever a really compelling
 >     Dave> reason to change the slab poison pattern.
 > 
 > But Avi is still correct about false positives.  For example, if
 > something stomps on the slab poison and leaves it as
 > 
 >     e0 08 03 00
 > 
 > then that will add up to eb and still trigger your message, even
 > though it's far from a single bit error.

Ah, now I see the point Avi was making.

 > Maybe making the loop be something like
 > 
 > 	unsigned char total = 0, bad_count = 0;
 > 	printk(KERN_ERR "%03x:", offset);
 > 	for (i = 0; i < limit; i++) {
 > 		if (data[offset+i] != POISON_FREE) {
 > 			total += data[offset+i];
 > 			++bad_count;
 > 		}
 > 		printk(" %02x", (unsigned char)data[offset + i]);
 > 	}
 > 
 > and then you can put
 > 
 > 	if (bad_count == 1)
 > 
 > before the switch statement.
 > 
 > I have to admit that Avi's code seems clearer to me too, though.

I'm easily persuaded either way really, as long as
we arrive at a desirable end-result ;)

		Dave
