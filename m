Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbWBGTNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbWBGTNP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 14:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWBGTNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 14:13:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41927 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965006AbWBGTNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 14:13:14 -0500
Date: Tue, 7 Feb 2006 11:11:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dipankar Sarma <dipankar@in.ibm.com>, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Andrew Morton <akpm@osdl.org>, dada1@cosmosbay.com,
       heiko.carstens@de.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>, James.Bottomley@steeleye.com,
       Ingo Molnar <mingo@elte.hu>, axboe@suse.de, anton@samba.org,
       wli@holomorphy.com, ak@muc.de
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
In-Reply-To: <20060207185355.GC5771@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0602071107200.3854@g5.osdl.org>
References: <200602051959.k15JxoHK001630@hera.kernel.org>
 <20060207151541.GA32139@osiris.boeblingen.de.ibm.com> <43E8CA10.5070501@cosmosbay.com>
 <Pine.LNX.4.64.0602070833590.3854@g5.osdl.org> <20060207093458.176ac271.akpm@osdl.org>
 <Pine.LNX.4.64.0602070946190.3854@g5.osdl.org> <20060207183018.GA29056@in.ibm.com>
 <Pine.LNX.4.64.0602071036050.3854@g5.osdl.org> <20060207185355.GC5771@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Feb 2006, Dipankar Sarma wrote:
> 
> I am looking at 2.6.16-rc1 and I don't see cpu_possible_map
> being set in setup_smp()

You're right, my bad.  I looked at setup_smp() and how it walked through 
every CPU in the firmware, but it doesn't actually ever set the possible 
map, it fills in just hwrpb_cpu_present_mask (which is then then only used 
_later_ to set cpu_possible_map for some silly reason).

As far as I can tell, "hwrpb_cpu_present_mask" is just wrong, and the code 
_should_ be using cpu_possible_map.

rth? Ivan?

		Linus
