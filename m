Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268301AbUHQPrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268301AbUHQPrk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268295AbUHQPqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:46:30 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:63493 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268272AbUHQPhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:37:38 -0400
Date: Tue, 17 Aug 2004 16:37:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "David S. Miller" <davem@redhat.com>, raybry@sgi.com, ak@muc.de,
       benh@kernel.crashing.org, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath patch v2: fix race conditions, stats for 8,32 and 512 cpu SMP
Message-ID: <20040817163715.A23196@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christoph Lameter <clameter@sgi.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, raybry@sgi.com, ak@muc.de,
	benh@kernel.crashing.org, manfred@colorfullife.com,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com> <20040815130919.44769735.davem@redhat.com> <Pine.LNX.4.58.0408151552280.3370@schroedinger.engr.sgi.com> <20040815165827.0c0c8844.davem@redhat.com> <Pine.LNX.4.58.0408151703580.3751@schroedinger.engr.sgi.com> <20040815185644.24ecb247.davem@redhat.com> <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com> <20040816143903.GY11200@holomorphy.com> <Pine.LNX.4.58.0408170804430.8365@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0408170804430.8365@schroedinger.engr.sgi.com>; from clameter@sgi.com on Tue, Aug 17, 2004 at 08:28:44AM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 08:28:44AM -0700, Christoph Lameter wrote:
> This is the second release of the page fault fastpath path. The fast path
> avoids locking during the creation of page table entries for anonymous
> memory in a threaded application running on a SMP system. The performance
> increases significantly for more than 4 threads running concurrently.

Please reformat your patch according to Documentation/CodingStyle
(or just look at the surrounding code..).

Also you're duplicating far too much code of the regular pagefault code,
this probably wants some inlined helpers.

Your ptep_lock should be called ptep_trylock.

