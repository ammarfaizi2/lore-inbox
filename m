Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264082AbUD2Scc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbUD2Scc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 14:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264914AbUD2Scc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 14:32:32 -0400
Received: from holomorphy.com ([207.189.100.168]:30080 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264082AbUD2Scb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 14:32:31 -0400
Date: Thu, 29 Apr 2004 11:32:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Brett E." <brettspamacct@fastclick.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040429183226.GA783@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Brett E." <brettspamacct@fastclick.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <40904FD8.7020208@fastclick.com> <20040428181319.601decfc.akpm@osdl.org> <40905A5E.5000807@fastclick.com> <409143F6.3050300@fastclick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409143F6.3050300@fastclick.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 11:05:42AM -0700, Brett E. wrote:
> Anyone know what I should believe?  Sar's pgpgin/s and pgpgout/s tell me 
>  that it is paging in/out from/to disk.  Yet pswpin/s and pswpout/s are 
> both 0.  Swapping and paging are the same thing I believe. pgpgin/out 
> refer to paging, pswpin/out refer to swapping.  So I for one am confused.
> I guess I could dig through the source but I figured someone might have 
> encountered this disrepency in the past.

Both are to be believed. They merely describe different things.

Pagein/pageout are counts of VM-initiated IO, regardless of whether this
IO is done on filesystem-backed pages or swap-backed pages. Pagein and
pageout are used more generally to describe VM-initiated IO and don't
exclusively refer to swap IO, but also include IO to filesystems to/from
filesystem-backed memory.

Swapin/swapout are counts of swap IO only, and are considered to apply
only to IO done to swap files/devices to/from swap-backed anonymous memory.

Pagein/pageout are both proper and necessary to have. In fact, you were
requesting that filesystem IO be done preferentially to swap IO, and the
pagein/pageout indicators showing IO while swapin/swapout indicators show
none mean you are getting exactly what you asked for.


-- wli
