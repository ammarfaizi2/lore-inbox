Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967265AbWKYWI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967265AbWKYWI2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 17:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967260AbWKYWI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 17:08:28 -0500
Received: from smtp-out.google.com ([216.239.45.12]:36805 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S967266AbWKYWI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 17:08:27 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:cc:subject:message-id:in-reply-to:
	references:x-mailer:mime-version:content-type:content-transfer-encoding;
	b=vMOetF6jzRe83dpLugJJ4oE46uOtFLp10JK6PHkRmB++Eh+64anBaf98Oui3gevGf
	JxyWYbvr85wbZ/LO5fUrQ==
Date: Sat, 25 Nov 2006 14:08:16 -0800
From: Andrew Morton <akpm@google.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: OOM killer firing on 2.6.18 and later during LTP runs
Message-Id: <20061125140816.903b7dc7.akpm@google.com>
In-Reply-To: <4568B72C.1060801@mbligh.org>
References: <4568AFB1.3050500@mbligh.org>
	<20061125132828.16a01762.akpm@osdl.org>
	<4568B72C.1060801@mbligh.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2006 13:35:40 -0800
"Martin J. Bligh" <mbligh@mbligh.org> wrote:

> > The traces are a bit confusing, but I don't actually see anything wrong
> > there.  The machine has used up all swap, has used up all memory and has
> > correctly gone and killed things.  After that, there's free memory again.
> 
> Yeah, it's just a bit odd that it's always in the IO path.

It's not.  It's in the main pagecache allocation path for reads.

> Makes me
> suspect there's actually a bunch of pagecache in the box as well,

show_free_areas() doesn't appear to dump the information which is needed to
work out how much of that memory is pagecache and how much is swapcache.  I
assume it's basically all swapcache.

> but
> maybe it's just coincidence, and the rest of the box really is full
> of anon mem. I thought we dumped the alt-sysrq-m type stuff on an OOM
> kill, but it seems not. maybe that's just not in mainline.

We do.  It's sitting there in your logs.
