Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbUK3IJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUK3IJE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 03:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbUK3IJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 03:09:04 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:1035 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262008AbUK3IJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 03:09:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=D8ZfssHj13PDIjJKK/5nBIItpFfp2tCt7U3LKDB7c5jZ8D1+suGA6xGqEvWfNTuN5/cN9MUzXgdan/RsfT3QekVc3gJEDVUNIVOTe2B/4y7HEcp4LXkbBDqKbMuaXw2Rzxq4hVYFC8L2FByjphekjXJ3o8jQB3ajZy51RjwZ7KQ=
Message-ID: <81b0412b04113000087fc8391e@mail.gmail.com>
Date: Tue, 30 Nov 2004 09:08:59 +0100
From: Alex Riesen <raa.lkml@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
In-Reply-To: <1101721336.21273.6138.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <19865.1101395592@redhat.com>
	 <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	 <1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	 <20041127032403.GB10536@kroah.com>
	 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	 <1101721336.21273.6138.camel@baythorne.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2004 09:42:16 +0000, David Woodhouse <dwmw2@infradead.org> wrote:
> I've lost track of the number of times things have broken because of
> incorrect use of kernel headers from userspace. That's what we're trying
> to fix -- by putting only the bits which are _supposed_ to be visible
> into files which userspace sees, where we know they define part of the
> userspace API and hence we can be extremely careful when editing them.

how about generating the user-visible interfaces and structures from the headers
using something like sparse and defined annotations? I.e.:

struct iovec
{
	void __user *iov_base;
	__kernel_size_t iov_len;
} __user_api__;
