Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVHKRO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVHKRO4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVHKRO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:14:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45482 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751131AbVHKROz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:14:55 -0400
Date: Thu, 11 Aug 2005 18:14:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, dipankar@in.ibm.com,
       rusty@au1.ibm.com, bmark@us.ibm.com
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
Message-ID: <20050811171451.GA5108@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	linux-kernel@vger.kernel.org, mingo@elte.hu, dipankar@in.ibm.com,
	rusty@au1.ibm.com, bmark@us.ibm.com
References: <20050810171145.GA1945@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050810171145.GA1945@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 10:11:45AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This patch is an experiment in use of RCU for individual code paths that
> read-acquire the tasklist lock, in this case, unicast signal delivery.
> It passes five kernbenches on 4-CPU x86, but obviously needs much more
> testing before it is considered for serious use, let alone inclusion.

I think we should switch over tasklist_lock to RCU completely instead of
adding suck hacks.  I've started lots of preparation work to get rid of
tasklist_lock users outside of kernel/, especialy getting rid of any
use in modules.

