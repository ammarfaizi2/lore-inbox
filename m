Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbVH3VTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbVH3VTr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 17:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVH3VTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 17:19:47 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:53818 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932473AbVH3VTq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 17:19:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NIqk4+j5FU5tIMa4JZLXo1meeOD6jhing2FoHC7H10IZ+0j0LHSsj6hktPV3rLVwVgDIogXclnLzobPR2X3p+EAN8PrglfMkD2JtPuz1n2o/axA0Rp9hhusfRU6+yKU8pGycPl1ghHFeGpl+7BRw2JBMSnJco85NOq9ANNPVMvU=
Message-ID: <9a87484905083014197ecb835a@mail.gmail.com>
Date: Tue, 30 Aug 2005 23:19:43 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Mark Gross <mgross@linux.intel.com>
Subject: Re: Telecom Clock driver for MPCBL0010 ATCA compute blade.
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200508301336.16112.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508301159.34053.mgross@linux.intel.com>
	 <20050830191611.GA8328@dmt.cnet>
	 <200508301331.27322.mgross@linux.intel.com>
	 <200508301336.16112.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, Mark Gross <mgross@linux.intel.com> wrote:
> On Tuesday 30 August 2005 13:31, Mark Gross wrote:
> > On Tuesday 30 August 2005 12:16, Marcelo Tosatti wrote:
> > >
> > > Mark,
> > >
> > > Please fix identation accordingly to CodingStyle and repost, it
> > > looks quite ugly at the moment.
> > >
> > Sorry about that.
> >
> 
> My email client is f-ing with me.  See attached.
> 

ok, a few small comments  : 


+/* sysFS interface definition:

Isn't it just called "sysfs" without the caps?

+Uppon loading the driver will create a sysfs directory under class/misc/tlclk.

s/Uppon/Upon/

+This directory exports the following interfaces.  There opperation is
documented

Line is longer than 80 chars - there are a few more such long lines,
not going to point them all out, just one example. Ohh, and
"opperation" should be "operation".

+All sysfs interaces are integers in hex format, i.e echo 99 > refalign

s/interaces/interfaces/

+#if CONFIG_DEBUG_KERNEL

I believe this should be "#ifdef CONFIG_DEBUG_KERNEL" or "#if
defined(CONFIG_DEBUG_KERNEL)" or you'll run afoul of the -Wundef
crowd.

+	int ret_val = 0;

There seems to be a preference for the name "retval" in the kernel source.

+	val = (unsigned char)arg;


That cast looks pointless.

+tlclk_read(struct file * filp, char __user * buf, size_t count, loff_t * f_pos)


tlclk_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
"*" next to the variable name is generally the preffered coding style
(several cases of this, only pointing out one).

+	val = (unsigned char)tmp;

pointless cast. Do take a look at all your casts and check if they are
really needed and remove them if not.

+ * This is also the probe opperation to avoid driver use on 

s/opperation/operation/

+/*	switchover_timer.function = switchover_timeout; */

+/*	switchover_timer.data = 0; */

Why submit a driver with commented out code? If this is not supposed
to be there, then just remove it. If it needs to be added later, then
submit a patch later to add it.
Some people may disagree with me here, but that's my oppinion.

+      out3:


labels belong at column 0 (zero).


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
