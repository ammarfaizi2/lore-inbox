Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUHBVBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUHBVBm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 17:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUHBVBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 17:01:42 -0400
Received: from holomorphy.com ([207.189.100.168]:18095 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263540AbUHBVBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 17:01:33 -0400
Date: Mon, 2 Aug 2004 14:01:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, kiran@in.ibm.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, greg@kroah.com, dipankar@in.ibm.com
Subject: Re: [patchset] Lockfree fd lookup 0 of 5
Message-ID: <20040802210119.GS2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>,
	viro@parcelfarce.linux.theplanet.co.uk, kiran@in.ibm.com,
	akpm@osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com,
	dipankar@in.ibm.com
References: <20040802101053.GB4385@vitalstatistix.in.ibm.com> <20040802165607.GN12308@parcelfarce.linux.theplanet.co.uk> <20040802130729.2dae8fd5.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802130729.2dae8fd5.davem@redhat.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Aug 2004 17:56:07 +0100 viro@parcelfarce.linux.theplanet.co.uk wrote:
>> How about this for comparison?  That's just a dumb "convert to rwlock"
>> patch; we can be smarter in e.g. close_on_exec handling, but that's a
>> separate story.

On Mon, Aug 02, 2004 at 01:07:29PM -0700, David S. Miller wrote:
> Compares to plain spinlocks, rwlock's don't buy you much,
> if anything, these days.
> Especially for short sequences of code.

I've found unusual results in this area. e.g. it does appear to matter
for mapping->tree_lock for database workloads that heavily share a
given file and access it in parallel. The radix tree walk, though
intuitively short, is long enough to make the rwlock a win in the
database-oriented uses and microbenchmarks starting around 4x.


-- wli
