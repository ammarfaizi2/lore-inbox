Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbVCOJOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbVCOJOu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 04:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVCOJOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 04:14:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37808 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262368AbVCOJOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 04:14:41 -0500
Date: Tue, 15 Mar 2005 09:14:33 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Lameter <christoph@lameter.com>
Cc: akpm@osdl.org, shai@scalex86.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Per cpu irq stat
Message-ID: <20050315091433.GA29079@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christoph Lameter <christoph@lameter.com>, akpm@osdl.org,
	shai@scalex86.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0503142230050.11651@server.graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503142230050.11651@server.graphe.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 10:32:34PM -0800, Christoph Lameter wrote:
> The definition of the irq_stat as an array means that the individual
> elements of the irq_stat array are located on one NUMA node requiring
> internode traffic to access irq_stat from other nodes. This patch makes
> irq_stat a per_cpu variable which allows most accesses to be local.

There's architectures accessing it from assemly.

But furthermore there's absolutely not point for the irq_stat structure
at all anymore now that we have the per_cpu infrastructure.  so kill it
completely and let every architecture just provide a local_softirq_pending
macro.

