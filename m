Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263727AbTEFNyk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbTEFNyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:54:04 -0400
Received: from rth.ninka.net ([216.101.162.244]:52176 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263727AbTEFNw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:52:59 -0400
Subject: Re: 2.5.69-mm1
From: "David S. Miller" <davem@redhat.com>
To: dipankar@in.ibm.com
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030506110907.GB9875@in.ibm.com>
References: <20030504231650.75881288.akpm@digeo.com>
	 <20030505210151.GO8978@holomorphy.com>  <20030506110907.GB9875@in.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052222542.983.27.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 05:02:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-06 at 04:09, Dipankar Sarma wrote:
> That brings me to the point - with the fget-speedup patch, we should
> probably change ->file_lock back to an rwlock again. We now take this
> lock only when fd table is shared and under such situation the rwlock
> should help. Andrew, it that ok ?

rwlocks believe it or not tend not to be superior over spinlocks,
they actually promote cache line thrashing in the case they
are actually being effective (>1 parallel reader)

-- 
David S. Miller <davem@redhat.com>
