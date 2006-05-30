Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWE3FNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWE3FNd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 01:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWE3FNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 01:13:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:17074 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751271AbWE3FNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 01:13:32 -0400
Subject: Re: [patch 34/61] lock validator: special locking: bdev
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20060529183523.0985b537.akpm@osdl.org>
References: <20060529212109.GA2058@elte.hu> <20060529212554.GH3155@elte.hu>
	 <20060529183523.0985b537.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 30 May 2006 07:13:29 +0200
Message-Id: <1148966009.2877.1.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-29 at 18:35 -0700, Andrew Morton wrote:
> On Mon, 29 May 2006 23:25:54 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > From: Ingo Molnar <mingo@elte.hu>
> > 
> > teach special (recursive) locking code to the lock validator. Has no
> > effect on non-lockdep kernels.
> > 
> 
> There's no description here of the problem which is being worked around. 
> This leaves everyone in the dark.

it's not really a workaround, it's a "separate the uses" thing. The real
problem is an inherent hierarchy between "disk" and "partition". Where
lots of code assumes you can first take the disk mutex, and then the
partition mutex, and never deadlock. This patch basically separates the
"get me the disk" versus "get me the partition" uses.

