Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbVHaAHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbVHaAHF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 20:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVHaAHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 20:07:04 -0400
Received: from cantor.suse.de ([195.135.220.2]:41958 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932296AbVHaAHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 20:07:01 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH] Only process_die notifier in ia64_do_page_fault if KPROBES is configured.
Date: Wed, 31 Aug 2005 02:05:00 +0200
User-Agent: KMail/1.8
Cc: "Luck, Tony" <tony.luck@intel.com>, Rusty Lynch <rusty@linux.intel.com>,
       "Lynch, Rusty" <rusty.lynch@intel.com>, linux-mm@kvack.org,
       prasanna@in.ibm.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0443A9A1@scsmsx401.amr.corp.intel.com> <200508310138.09841.ak@suse.de> <Pine.LNX.4.62.0508301642570.20548@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0508301642570.20548@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508310205.00965.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 August 2005 01:54, Christoph Lameter wrote:

> Certainly not a big effect (if we make sure the compiler knows that
> this test mostly fails and insure that the variable is in
> __mostly_read) 

Currently neither, but that could be easily fixed.

> but this is a frequently executed code path and the code 
> is there without purpose if CONFIG_KPROBES is off.

Well if you really worry about it then it might be better to do some dynamic
code patching to make generic and distribution kernels too.

> It wont get too bad unless lots of other people have similar ideas about
> fixing their race conditions using similar methods. But we will be setting
> a bad precedent if we allow this.

Agreed on the general direction, but I didn't see an alternative
for kprobes for this. Well actually the hook could be maybe
right now moved into the part before kernel oops which is much less
frequently executed, but then it'll likely move up again once
kprobes support user space probes.

-Andi
