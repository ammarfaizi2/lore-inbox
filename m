Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWF1Tt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWF1Tt2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWF1Tt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:49:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10118 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751128AbWF1Tt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:49:27 -0400
Date: Wed, 28 Jun 2006 12:49:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: mbligh@google.com, mbligh@mbligh.org, linux-kernel@vger.kernel.org,
       apw@shadowen.org, linuxppc64-dev@ozlabs.org, drfickle@us.ibm.com
Subject: Re: 2.6.17-mm2
Message-Id: <20060628124906.b289e80b.akpm@osdl.org>
In-Reply-To: <44A2D6DA.1050607@goop.org>
References: <449D5D36.3040102@google.com>
	<449FF3A2.8010907@mbligh.org>
	<44A150C9.7020809@mbligh.org>
	<20060628034215.c3008299.akpm@osdl.org>
	<20060628034748.018eecac.akpm@osdl.org>
	<44A29582.7050403@google.com>
	<20060628121102.638f08d9.akpm@osdl.org>
	<44A2D6DA.1050607@goop.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 12:22:02 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Andrew Morton wrote:
> > Found a way to reproduce it - do `cat /proc/slabinfo > /dev/null' in a
> > tight loop.  With that happening, a little two-way wasn't able to make
> > it through `dbench 4' without soiling the upholstery.  Then bisection-searching.
> >   
> It's surprising it was so subtle.  I'd been running with that code for a 
> month or so without a peep of problem...
> 

It'll only bite if someone does snprintf() into a too-short buffer.  That's
rare (it's usually a bug).  But it looks like the seq_file() code does it
when someone is trying to generate more than PAGE_SIZE's worth of data. 
Like /proc/slabinfo.

