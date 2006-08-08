Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWHHOvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWHHOvl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 10:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWHHOvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 10:51:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:33763 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932590AbWHHOvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 10:51:41 -0400
X-Authenticated: #5039886
Date: Tue, 8 Aug 2006 16:51:38 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, dev@openvz.org, stable@kernel.org
Subject: Re: + sys_getppid-oopses-on-debug-kernel.patch added to -mm tree
Message-ID: <20060808145138.GA2720@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Muli Ben-Yehuda <muli@il.ibm.com>, linux-kernel@vger.kernel.org,
	dev@sw.ru, dev@openvz.org, stable@kernel.org
References: <200608081432.k78EWprf007511@shell0.pdx.osdl.net> <20060808143937.GA3953@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060808143937.GA3953@rhun.haifa.ibm.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.08.08 17:39:37 +0300, Muli Ben-Yehuda wrote:
> On Tue, Aug 08, 2006 at 07:32:51AM -0700, akpm@osdl.org wrote:
> > 
> > The patch titled
> > 
> >      sys_getppid() oopses on debug kernel
> > 
> > has been added to the -mm tree.  Its filename is
> > 
> >      sys_getppid-oopses-on-debug-kernel.patch
> > 
> > See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> > out what to do about this
> > 
> > ------------------------------------------------------
> > Subject: sys_getppid() oopses on debug kernel
> > From: Kirill Korotaev <dev@sw.ru>
> > 
> > sys_getppid() optimization can access a freed memory.  On kernels with
> > DEBUG_SLAB turned ON, this results in Oops.
> > 
> > Signed-off-by: Kirill Korotaev <dev@openvz.org>
> > Cc: <stable@kernel.org>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> 
> I'm probably missing something, but is it really valid to access freed
> kernel memory even if CONFIG_DEBUG_SLAB is off - as this patch does?

There's a note right above the function that explains it:
 * NOTE! This depends on the fact that even if we _do_
 * get an old value of "parent", we can happily dereference
 * the pointer (it was and remains a dereferencable kernel pointer
 * no matter what): we just can't necessarily trust the result
 * until we know that the parent pointer is valid.

HTH
Björn
