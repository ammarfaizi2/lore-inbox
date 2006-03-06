Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751953AbWCFHbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbWCFHbq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 02:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbWCFHbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 02:31:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7855 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751953AbWCFHbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 02:31:45 -0500
Date: Mon, 6 Mar 2006 02:31:21 -0500
From: Dave Jones <davej@redhat.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       ericvh@gmail.com, rminnich@lanl.gov
Subject: Re: 9pfs double kfree
Message-ID: <20060306073121.GG21445@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Balbir Singh <bsingharora@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, ericvh@gmail.com, rminnich@lanl.gov
References: <20060306070456.GA16478@redhat.com> <20060305.230711.06026976.davem@davemloft.net> <661de9470603052326i5f4a6a7q79bc370d180737b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <661de9470603052326i5f4a6a7q79bc370d180737b1@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 12:56:03PM +0530, Balbir Singh wrote:
 > On 3/6/06, David S. Miller <davem@davemloft.net> wrote:
 > > From: Dave Jones <davej@redhat.com>
 > > Date: Mon, 6 Mar 2006 02:04:58 -0500
 > >
 > > > (I wish we had a kfree variant that NULL'd the target when it was free'd)
 > >
 > > Excellent idea.
 > > -
 > 
 > Slab debugging should catch double frees, but it will not attract your
 > attention till you see your dmesg log.

The vast majority of people never run with slab poisoning enabled
judging by the number of bugs it constantly turns up.

 > kfree() will ignore NULL
 > pointer, from the comments in kfree

*nod*, poisoning the ptr would be a better idea.

 > May we could have such a variant under CONFIG_DEBUG_SLAB if we needed
 > and also change the variant kfree to BUG_ON() a NULL pointer.

given the cost is just a ptr assignment in a slow path, I'd prefer
it was non-optional, otherwise it'll be as underused as the other
debugging options.

		Dave

-- 
http://www.codemonkey.org.uk
