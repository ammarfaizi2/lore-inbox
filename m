Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWF1TL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWF1TL0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWF1TL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:11:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56039 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751016AbWF1TLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:11:25 -0400
Date: Wed, 28 Jun 2006 12:11:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@google.com>
Cc: mbligh@mbligh.org, jeremy@goop.org, linux-kernel@vger.kernel.org,
       apw@shadowen.org, linuxppc64-dev@ozlabs.org, drfickle@us.ibm.com
Subject: Re: 2.6.17-mm2
Message-Id: <20060628121102.638f08d9.akpm@osdl.org>
In-Reply-To: <44A29582.7050403@google.com>
References: <449D5D36.3040102@google.com>
	<449FF3A2.8010907@mbligh.org>
	<44A150C9.7020809@mbligh.org>
	<20060628034215.c3008299.akpm@osdl.org>
	<20060628034748.018eecac.akpm@osdl.org>
	<44A29582.7050403@google.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 07:43:14 -0700
"Martin J. Bligh" <mbligh@google.com> wrote:

> Andrew Morton wrote:
> > On Wed, 28 Jun 2006 03:42:15 -0700
> > Andrew Morton <akpm@osdl.org> wrote:
> > 
> > 
> >>his is caused by the vsprintf() changes.  Right now, if you do
> >>
> >>	snprintf(buf, 4, "1111111111111");
> >>
> >>the memory at `buf' gets [31 31 31 31 00], which is not good.
> >>
> >>This'll plug it, but I didn't check very hard whether it still has any
> >>off-by-ones, or if breaks the intent of Jeremy's patch.  I think it's OK..
> 
> Aha, you're a genius!

That's not what my kids say.

> How the hell did you figure that one out?

Found a way to reproduce it - do `cat /proc/slabinfo > /dev/null' in a
tight loop.  With that happening, a little two-way wasn't able to make
it through `dbench 4' without soiling the upholstery.  Then bisection-searching.
