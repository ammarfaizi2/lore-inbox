Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265541AbSKOBsq>; Thu, 14 Nov 2002 20:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265537AbSKOBsq>; Thu, 14 Nov 2002 20:48:46 -0500
Received: from holomorphy.com ([66.224.33.161]:5068 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265541AbSKOBsp>;
	Thu, 14 Nov 2002 20:48:45 -0500
Date: Thu, 14 Nov 2002 17:53:04 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Tim Hockin <thockin@sun.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH 1/2] Remove NGROUPS hardlimit (resend w/o qsort)
Message-ID: <20021115015304.GQ23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pete Zaitcev <zaitcev@redhat.com>, Tim Hockin <thockin@sun.com>,
	linux-kernel@vger.kernel.org
References: <mailman.1037316781.6599.linux-kernel2news@redhat.com> <200211150006.gAF06JF01621@devserv.devel.redhat.com> <3DD43C65.80103@sun.com> <20021114193156.A2801@devserv.devel.redhat.com> <3DD443EC.2080504@sun.com> <20021115011947.GP23425@holomorphy.com> <20021114204539.A15162@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021114204539.A15162@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 08:45:39PM -0500, Pete Zaitcev wrote:
> This sounds intriguing.
> Bill, if I may borrow from your data structure expertise,
> what would you do if you wanted gid_t's indexed by two criteria?
> Obviously, we want them them indexed by value (to look them up
> for access checking), but NFS also needs them sorted by usage,
> to fit the last 3 into the RPC parameters. This looks like
> something requiring two overlaying trees who share leafs,
> and every leaf being a single gid_t, with nightmarish overhead.
> Before Tim came to the scene, the hope was that lookups would
> do exhaustive search of arrays, sorted by LRU, while RPC
> picked N leading elements of said sorted array. Tim busts
> this scheme to pieces, because he sorts arrays by value
> (if I read it right).

B+ trees separate metadata from data entirely, so two distinct
B+ tree "indices" attached will work just fine for this overlaying
of trees that share leaves.


Bill
