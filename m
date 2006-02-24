Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWBXTJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWBXTJl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 14:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWBXTJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 14:09:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34519 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932431AbWBXTJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 14:09:40 -0500
Date: Fri, 24 Feb 2006 19:09:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@intel.linux.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
Subject: Re: [Patch 2/3] fast VMA recycling
Message-ID: <20060224190938.GA6351@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@intel.linux.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <1140688131.4672.21.camel@laptopd505.fenrus.org> <20060224185231.GB5816@infradead.org> <200602242005.17087.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602242005.17087.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 08:05:16PM +0100, Andi Kleen wrote:
> I think voluntary preempt is generally a good idea, but we should make it optional
> for down() since it can apparently cause bad side effects (like holding 
> semaphores/mutexes for too long) 
> 
> There would be two possible ways: 
> 
> have default mutex_lock()/down() do a might_sleep()
> with preemption and have a separate variant that doesn't preempt
> or have the default non preempt and a separate variant
> that does preempt.

better remove the stupid cond_resched() from might_sleep which from it's
naming already is a debug thing and add it to those places where it makes
sense.

