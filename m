Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWJEBds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWJEBds (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 21:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWJEBds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 21:33:48 -0400
Received: from mga07.intel.com ([143.182.124.22]:40605 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751308AbWJEBdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 21:33:47 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,257,1157353200"; 
   d="scan'208"; a="127094454:sNHT25896710"
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Organization: Intel Corporation
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] bitmap: separate bitmap parsing for user buffer and kernel buffer
Date: Wed, 4 Oct 2006 18:33:37 -0700
User-Agent: KMail/1.9.3
Cc: Reinette Chatre <reinette.chatre@linux.intel.com>,
       Joe Korty <joe.korty@ccur.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
References: <200610041756.30528.reinette.chatre@linux.intel.com> <20061004181003.6dae6065.akpm@osdl.org>
In-Reply-To: <20061004181003.6dae6065.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610041833.40866.inaky@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 October 2006 18:10, Andrew Morton wrote:
> On Wed, 4 Oct 2006 17:56:30 -0700
> Reinette Chatre <reinette.chatre@linux.intel.com> wrote:
> > +			if (is_user) {
> > +				if (__get_user(c, buf++))
> > +					return -EFAULT;
> > +			}
> > +			else
> > +				c = *buf++;
>
> Is this actually needed?  __get_user(kernel_address) works OK and (believe
> it or not, given all the stuff it involves) boils down to a single
> instruction.

We weren't too sure if that'd be true in all kinds of arches and
memory models. If it works for kernel space too, then we can fold
out a lot of code...

Your call, you are the expert :)

--
Inaky
