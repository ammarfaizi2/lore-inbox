Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030389AbVKPQJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389AbVKPQJx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 11:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbVKPQJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 11:09:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:385 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030389AbVKPQJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 11:09:52 -0500
Date: Wed, 16 Nov 2005 08:04:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Zhu Yi <yi.zhu@intel.com>
cc: Zilvinas Valinskas <zilvinas@gemtek.lt>,
       Pekka Enberg <penberg@cs.helsinki.fi>, Andrew Morton <akpm@osdl.org>,
       Alexandre Buisse <alexandre.buisse@ens-lyon.fr>,
       linux-kernel@vger.kernel.org, jketreno@linux.intel.com
Subject: Re: Linuv 2.6.15-rc1
In-Reply-To: <1132120145.18679.12.camel@debian.sh.intel.com>
Message-ID: <Pine.LNX.4.64.0511160800570.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>  <4378980C.7060901@ens-lyon.fr>
 <20051114162942.5b163558.akpm@osdl.org>  <20051115100519.GA5567@gemtek.lt>
 <20051115115657.GA30489@gemtek.lt>  <84144f020511150451l6ef30420g5a83a147c61f34a8@mail.gmail.com>
  <20051115140023.GB9910@gemtek.lt> <1132120145.18679.12.camel@debian.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Nov 2005, Zhu Yi wrote:
> 
> Please try the patch below and see if it makes any difference.
> http://bughost.org/bugzilla/show_bug.cgi?id=821

Hmm. That patch does

+	error->log = (struct ipw_event *)((u8 *)error->elem +
 					  (sizeof(*error->elem) * elem_len));

which really can be much more cleanly written as

	error->log = (void *)(error->elem + elem_len);

since pointer addition does the "multiply by pointer element size" on it's 
own.

For future reference, you want to make just a byte add, the cleanest way 
(in kernel, where we use the gcc "void *" additions) is

	newptr = offset + (void *)oldptr;

ho humm..

		Linus
