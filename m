Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270982AbTHKFCD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 01:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271002AbTHKFBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 01:01:05 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58034 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271118AbTHKE7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 00:59:55 -0400
Date: Sun, 10 Aug 2003 21:54:22 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org, jmorris@intercode.com.au
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-Id: <20030810215422.0db6192a.davem@redhat.com>
In-Reply-To: <20030811021512.GF10446@mail.jlokier.co.uk>
References: <20030809074459.GQ31810@waste.org>
	<20030809010418.3b01b2eb.davem@redhat.com>
	<20030809140542.GR31810@waste.org>
	<20030809103910.7e02037b.davem@redhat.com>
	<20030809194627.GV31810@waste.org>
	<20030809131715.17a5be2e.davem@redhat.com>
	<20030810081529.GX31810@waste.org>
	<20030811021512.GF10446@mail.jlokier.co.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003 03:15:12 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> Matt Mackall wrote:
> > > > Ok, can I export some more cryptoapi primitives?
> 
> Why so complicated?  Just move the "sha1_transform" function to its
> own file in lib, and call it from both drivers/char/random.c and
> crypto/sha1.c.

This is also broken.

The whole point of the 'tfm' the Crypto API makes you allocate is
that it provides all of the state and configuration information
needed to do the transforms.

There is no reason why random.c's usage of the crypto-API cannot be
done cleanly and efficiently such that it is both faster and resulting
in smaller code size than what random.c uses now.  All of this _WITHOUT_
bypassing and compromising the well designed crypto API interfaces to these
transformations.
