Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVEEMW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVEEMW4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 08:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVEEMWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 08:22:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31461 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262075AbVEEMVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 08:21:38 -0400
Date: Thu, 5 May 2005 13:22:04 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: michaelc@cs.wisc.edu, linux-scsi@vger.kernel.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] add open iscsi netlink interface to iscsi transport class
Message-ID: <20050505122204.GL19678@parcelfarce.linux.theplanet.co.uk>
References: <42798AC1.2010308@cs.wisc.edu> <20050505.185503.78606493.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050505.185503.78606493.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2005 at 06:55:03PM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> In article <42798AC1.2010308@cs.wisc.edu> (at Wed, 04 May 2005 19:53:53 -0700), Mike Christie <michaelc@cs.wisc.edu> says:
> 
> > +struct iscsi_uevent {
> :
> > +} __attribute__ ((aligned (sizeof(unsigned long))));
> 
> I think it'd be better to use sizeof(uint64_t) or something.

Actually, it's completely unnecessary.  iscsi_uevent contains a uint64_t
element, and the GCC docs (in the 'Type attribute' section, documenting
aligned) say:

     Note that the alignment of any given `struct' or `union' type is
     required by the ISO C standard to be at least a perfect multiple of
     the lowest common multiple of the alignments of all of the members
     of the `struct' or `union' in question.  This means that you _can_

So best to just delete it.  It has no effect.

> Please check other spots, too. e.g.:
> 
> > +	struct iscsi_stats_custom custom[0]
> > +		__attribute__ ((aligned (sizeof(unsigned long))));

This one's probably useless too, but it's hard to tell since the patches
weren't sent inline thus making them difficult to cross-reference.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
