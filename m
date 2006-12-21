Return-Path: <linux-kernel-owner+w=401wt.eu-S1422991AbWLURfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422991AbWLURfo (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 12:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422993AbWLURfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 12:35:44 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2799 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422991AbWLURfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 12:35:42 -0500
Date: Thu, 21 Dec 2006 17:35:33 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-arch <linux-arch@vger.kernel.org>,
       Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
Message-ID: <20061221173532.GF3958@flint.arm.linux.org.uk>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-arch <linux-arch@vger.kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
References: <20061221152621.GB3958@flint.arm.linux.org.uk> <1166718582.3365.1509.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166718582.3365.1509.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 05:29:42PM +0100, Arjan van de Ven wrote:
> 
> > So, given all this additional complexity _and_ that it would only be
> > safe on non-preempt UP, the question becomes: is using get_user_pages()
> > to access the current processes memory space legal?  Given the above,
> > I would say not.
> 
> I'd say that copy_from_user is the right api for this, not
> get_user_pages + kmap hacks...

I would tend to agree.

So the question then comes down to: is there really an issue with using
copy_*_user in fuse.

Bearing in mind that get_user_pages() simulates page faults in the
memory it is trying to access, we're going to either take simulated
page faults at that time, or real page faults in copy_*_user.

(I was just about to test a hacked up implementation of flush_anon_page()
on my test system, but it seems its ethernet interface has warmed up
too much and won't obtain a link with my switch... which makes download
of kernels impossible.  Hence it's going to have to wait a few hours for
it to cool down.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
