Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWCFH3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWCFH3E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 02:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbWCFH3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 02:29:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48812 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751393AbWCFH3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 02:29:02 -0500
Date: Mon, 6 Mar 2006 02:28:23 -0500
From: Dave Jones <davej@redhat.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       ericvh@gmail.com, rminnich@lanl.gov
Subject: Re: 9pfs double kfree
Message-ID: <20060306072823.GF21445@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Al Viro <viro@ftp.linux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, ericvh@gmail.com, rminnich@lanl.gov
References: <20060306070456.GA16478@redhat.com> <20060305.230711.06026976.davem@davemloft.net> <20060306072346.GF27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306072346.GF27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 07:23:46AM +0000, Al Viro wrote:
 > On Sun, Mar 05, 2006 at 11:07:11PM -0800, David S. Miller wrote:
 > > From: Dave Jones <davej@redhat.com>
 > > Date: Mon, 6 Mar 2006 02:04:58 -0500
 > > 
 > > > (I wish we had a kfree variant that NULL'd the target when it was free'd)
 > > 
 > > Excellent idea.
 > 
 > ITYM "poison the pointer variable".  Otherwise that sort of crap will go
 > unnoticed.

yeah, even better idea. Just like slab debug, but without the overhead
of poisoning the whole object.

I wonder if we could get away with something as simple as..

#define kfree(foo) \
	__kfree(foo); \
	foo = KFREE_POISON;

?

		Dave

-- 
http://www.codemonkey.org.uk
