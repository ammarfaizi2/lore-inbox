Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVCaOcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVCaOcy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 09:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVCaOcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 09:32:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13032 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261469AbVCaOcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 09:32:46 -0500
Date: Thu, 31 Mar 2005 15:32:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: shobhit dayal <shobhit@calsoftinc.com>
Cc: hch@infradead.org, christoph@lameter.com, manfred@colorfullife.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org, Shai Fultheim <shai@scalex86.org>
Subject: Re: Fwd: [PATCH] Pageset Localization V2
Message-ID: <20050331143235.GA18058@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	shobhit dayal <shobhit@calsoftinc.com>, christoph@lameter.com,
	manfred@colorfullife.com, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	linux-mm@kvack.org, Shai Fultheim <shai@scalex86.org>
References: <Pine.LNX.4.58.0503292147200.32571@server.graphe.net> <20050330111439.GA13110@infradead.org> <bab4333005033003295f487e3d@mail.gmail.com> <1112187977.9773.15.camel@kuber>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112187977.9773.15.camel@kuber>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 06:36:18PM +0530, shobhit dayal wrote:
> The goal here is to replace the head of a existing list pointed to by
> 'list' with a new head pointed to by 'nlist'. 
> First there is a memcpy that copies the contents of list to nlist then
> this macro is called.
> The macro makes sure that if the old head was empty then INIT_LIST_HEAD
> the 'nlist', if not then make sure that the nodes before and after the
> head now correclty point to nlist instead of list.

Which would be much nicer done using INIT_LIST_HEAD on the new head
always and then calling list_replace (of which currently only a _rcu variant
exists).

Note to Christoph:  Just duplicating the code doesn't make it better ;-)

