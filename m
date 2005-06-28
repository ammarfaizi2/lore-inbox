Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbVF1RMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVF1RMv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 13:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVF1RMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 13:12:51 -0400
Received: from graphe.net ([209.204.138.32]:7097 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262153AbVF1RBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 13:01:30 -0400
Date: Tue, 28 Jun 2005 10:01:21 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: William Lee Irwin III <wli@holomorphy.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Anton Blanchard <anton@samba.org>
Subject: Re: [patch 2] mm: speculative get_page
In-Reply-To: <42C17028.6050903@yahoo.com.au>
Message-ID: <Pine.LNX.4.62.0506280959100.10511@graphe.net>
References: <42C0AAF8.5090700@yahoo.com.au> <20050628040608.GQ3334@holomorphy.com>
 <42C0D717.2080100@yahoo.com.au> <20050627.220827.21920197.davem@davemloft.net>
 <20050628141903.GR3334@holomorphy.com> <42C17028.6050903@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005, Nick Piggin wrote:

> But nit picking aside, is it true that we need a load barrier before
> unlock? (store barrier I agree with) The ppc64 changeset in question
> indicates yes, but I can't quite work out why. There are noises in the
> archives about this, but I didn't pinpoint a conclusion...

A spinlock may be used to read a consistent set of variables. If load
operations would be moved below the spin_unlock then one may get values
that have been updated after another process acquired the spinlock.

