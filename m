Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265060AbUGMNR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbUGMNR4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 09:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUGMNR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 09:17:56 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:15511 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265060AbUGMNRy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 09:17:54 -0400
Date: Tue, 13 Jul 2004 08:17:15 -0500
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: "Jose R. Santos" <jrsantos@austin.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, slprat@us.ibm.com
Subject: Re: [PATCH] Making i/dhash_entries cmdline work as it use to.
Message-ID: <20040713131715.GE9149@rx8.austin.ibm.com>
References: <20040712175605.GA1735@rx8.austin.ibm.com> <2443.1089714553@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <2443.1089714553@redhat.com> (from dhowells@redhat.com on Tue, Jul 13, 2004 at 05:29:13 -0500)
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/04 05:29:13, David Howells wrote:
> 
> Jose R. Santos <jrsantos@austin.ibm.com> wrote:
> > Also, any particular reason why MAX_SYS_HASH_TABLE_ORDER was set to 14?
> > I am already seeing the need to go higher on my 64GB setup and was 
> > wondering if this could be bumped up to 19.
> 
> Yes. IBM did some testing and found that was about optimal. No significant
> gain was found with anything greater.

On a single setup.  What about people that want to use Linux on a 128way with
over a terabyte of memory.  Certainly ORDER 14 might be to small for them.

> > I'm sending a patch that get the cmdline options working as the did before
> > where the could override the kernel calculations and increases 
> > MAX_SYS_HASH_TABLE_ORDER to 19.  Only tested on PPC64 at the moment.
> 
> You need to be careful increasing the maximum order - you have to remember
> that this affects several tables (well, at least two at the moment), and so
> the effect is multiplied.

Only if I use the cmdline option.  With no command line arguments this allocate
the kernels sain calculated defaults.
 
> It may be reasonable to let the kernel cmdline override the maximum number of
> buckets calculated on the scaling factor provided to the function (effectively
> number of buckets per unit memory), but consider that the number of objects
> that can be allocated and linked into the table is in effect governed by such
> a factor.

It seems easier to specify a the number of buckets you want than specifying a 
scaling factor, which some people may have problems figuring out.

-JRS
