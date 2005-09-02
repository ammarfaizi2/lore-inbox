Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030667AbVIBDp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030667AbVIBDp6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 23:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030668AbVIBDp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 23:45:58 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:7984 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030667AbVIBDp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 23:45:57 -0400
Date: Fri, 02 Sep 2005 12:41:21 +0900 (JST)
Message-Id: <20050902.124121.925177942.hyoshiok@miraclelinux.com>
To: akpm@osdl.org
Cc: ak@suse.de, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       hyoshiok@miraclelinux.com
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <20050901192840.0406862e.akpm@osdl.org>
References: <20050901190846.479229cf.akpm@osdl.org>
	<200509020417.10574.ak@suse.de>
	<20050901192840.0406862e.akpm@osdl.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

From: Andrew Morton <akpm@osdl.org>
> Andi Kleen <ak@suse.de> wrote:
> >
> > On Friday 02 September 2005 04:08, Andrew Morton wrote:
> > 
> > > I suppose I'll queue it up in -mm for a while, although I'm a bit dubious
> > > about the whole idea...  We'll gain some and we'll lose some - how do we
> > > know it's a net gain?
> > 
> > I suspect it'll gain more than it loses. The only case where it might 
> > not gain is immediately someone reading the data from the page cache again
> > after the write.
> 
> That's a pretty common case - temporary files.
> 
> > But I suppose that's far less frequent than writing the data.
> 
> yup.
> 
> Hiro, could you please send through a summary of the performance testing
> results sometime?  Runtimes rather than oprofile output?

iozone results are

original 2.6.12.4 CPU time = 207.768 sec
cache aware       CPU time = 184.783 sec
(three times run)
184.783/207.768=88.94% (11.06% reduction)

original:
pattern9-0-cpu4-0-08191720/iozone.out:  CPU Utilization: Wall time   45.997    CPU time   64.527    CPU utilization 140.28 %
pattern9-0-cpu4-0-08191741/iozone.out:  CPU Utilization: Wall time   46.878    CPU time   71.933    CPU utilization 153.45 %
pattern9-0-cpu4-0-08191743/iozone.out:  CPU Utilization: Wall time   45.152    CPU time   71.308    CPU utilization 157.93 %

cache awre:
pattern9-0-cpu4-0-09011728/iozone.out:  CPU Utilization: Wall time   44.842    CPU time   62.465    CPU utilization 139.30 %
pattern9-0-cpu4-0-09011731/iozone.out:  CPU Utilization: Wall time   44.718    CPU time   59.273    CPU utilization 132.55 %
pattern9-0-cpu4-0-09011744/iozone.out:  CPU Utilization: Wall time   44.367    CPU time   63.045    CPU utilization 142.10 %

Regards,
  Hiro
