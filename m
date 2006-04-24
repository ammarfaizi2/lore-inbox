Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWDXTNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWDXTNm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWDXTNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:13:42 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:26509 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751136AbWDXTNl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:13:41 -0400
Subject: Re: [PATCH 1/2] ext3 percpu counter fixes to suppport for more
	than 2**31 ext3 free blocks counter
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andrew Morton <akpm@osdl.org>, LaurentVivier@wanadoo.fr, sct@redhat.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060424182632.GA4063@localhost.localdomain>
References: <1144691929.3964.53.camel@dyn9047017067.beaverton.ibm.com>
	 <1145631546.4478.10.camel@localhost.localdomain>
	 <20060421150943.2fdc5c4a.akpm@osdl.org>
	 <1145900913.4820.14.camel@dyn9047017069.beaverton.ibm.com>
	 <20060424182632.GA4063@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 24 Apr 2006 12:13:17 -0700
Message-Id: <1145906008.4820.21.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 11:26 -0700, Ravikiran G Thirumalai wrote:
> On Mon, Apr 24, 2006 at 10:48:32AM -0700, Mingming Cao wrote:
> > On Fri, 2006-04-21 at 15:09 -0700, Andrew Morton wrote:
> > > >
> > > I think it would be saner to explicitly specify the size of the field. 
> > > That means using s32 and s64 throughout this code.
> > > 
> > 
> > Agree. Will use s64 in this code. As s32 has the same issue with what we
> > have(unsigned long) on 32 bit machine today: it is not enough for ext3
> > to support more than 2**31 free blocks, and also obviously not enough
> > for 64 bit ext3 that Laurent is working on.
> 
> I think Andrew's suggestion was to change global counter to s64 and local
> counter to s32.  That way we avoid allocating a 64 bit local counter on 64
> bit systems when we could do with a 32 bit counter. (although there is no
> real space savings with current alloc_percpu ;), but hopefully that will
> change in the future)
> 

Oh, I see. :-) I shall have the updated patch soon.

Mingming

