Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268345AbUI2Mln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268345AbUI2Mln (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 08:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268347AbUI2Mln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 08:41:43 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:32004 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268345AbUI2MlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 08:41:19 -0400
Date: Wed, 29 Sep 2004 13:41:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Leubner, Achim" <Achim_Leubner@adaptec.com>
Cc: arjanv@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gdth update
Message-ID: <20040929134112.B11891@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Leubner, Achim" <Achim_Leubner@adaptec.com>, arjanv@redhat.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <B51CDBDEB98C094BB6E1985861F53AF302DE00@nkse2k01.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <B51CDBDEB98C094BB6E1985861F53AF302DE00@nkse2k01.adaptec.com>; from Achim_Leubner@adaptec.com on Wed, Sep 29, 2004 at 02:15:57PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 02:15:57PM +0200, Leubner, Achim wrote:
> > C99 initializers work in all kernel versions since it's a property of
> > the C compiler not of the kernel. I wonder why you are putting this
> > ifdef here....
> >
> Agree. If the initializers works also fine with compiler versions in
> older distributions with the 2.4.x and 2.2.x kernels, the ifdef is
> really useless. 

C99 initializes (.foo) are supported at least down to gcc 2.7

> > the rest of your ifdefs are generally quite fishy too
> unfortionately...
> >
> Could you please explain it exactly? I really want to learn what the
> problems are to correct it in the next version.

e.g. you have

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,11)
MODULE_LICENSE("GPL");
#endif


much better would be to put a 

#ifndef MODULE_LICENSE
#define MODULE_LICENSE(name)
#endif

into some header and use it unconditionally later on.

or you have

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
    b = virt_ctr ? NUMDATA(scp->device->host)->busnum : scp->device->channel;
    t = scp->device->id;
#else
    b = virt_ctr ? NUMDATA(scp->host)->busnum : scp->channel;
    t = scp->target;
#endif

where the 2.6 branch just works for 2.4 and 2.2 kernels aswell, so you
could get rid of the old branch completely.

In genereal always try to write to the current API and emulate it on
older releases.

