Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbUCWKNv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 05:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUCWKNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 05:13:50 -0500
Received: from holomorphy.com ([207.189.100.168]:1684 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262428AbUCWKNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 05:13:49 -0500
Date: Tue, 23 Mar 2004 02:13:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com
Subject: Re: [PATCH] nodemask_t x86_64 changes [5/7]
Message-ID: <20040323101323.GD2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
	linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
	haveblue@us.ibm.com
References: <1079651082.8149.175.camel@arrakis> <20040322230850.1d8f26dc.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322230850.1d8f26dc.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 11:08:50PM -0800, Paul Jackson wrote:
> I'll be surprised if the following line works:
> 	nodemask_t node_offline_map = nodes_complement(node_online_map);
> 1) Doesn't nodes_complement return void, and work in place?
> 2) It might set bits above MAX_NUMNODES, if MAX_NUMNODES isn't a word size multiple.
> I am less sure of (2) - the exact details of handling the unused bits of
> a bitmask are still confusing me.  But this would be one of the very
> rare situations that I can find that would actually be sensitive to
> possible confusions here - most places don't set bits that aren't
> already set in some mask, or are careful to initialize a mask with just
> set bits in select positions from 0 to MAX_NUMNODES-1.

In general I attempted to model things after 3-address code.
bitmap_complement() is a glaring inconsistency I wouldn't mind seeing
shored up with the rest (though I guess it's only got 2 operands).


-- wli
