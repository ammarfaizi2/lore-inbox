Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbTE0AXG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 20:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbTE0AXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 20:23:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61969 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262403AbTE0AXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 20:23:05 -0400
Date: Mon, 26 May 2003 17:36:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5] [Cool stuff] "checking" mode for kernel builds
In-Reply-To: <3ED2AEA9.1000401@gmx.net>
Message-ID: <Pine.LNX.4.44.0305261728520.15826-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 May 2003, Carl-Daniel Hailfinger wrote:
> 
> while eagerly waiting for the release of that tool, I have a few
> comments about the patch itself.

Well, I guess I can just tell people about it. It's unfinished enough that
I'm a bit embarrassed about some of it, but I've gotten the permission
from Transmeta to make it open source, and it's actually been available
for some time on "bk://kernel.bkbits.net/torvalds/sparse". I just didn't 
tell about it in public (although a few people have known about it).

Be gentle with it. It does many things wrong, including (but limited 
to) enums, but it does a lot of things right too.

The biggest problem (apart from the things it does wrong) is that some
parts of the kenel re-use the same structure to hold both user- and kernel
pointers. That's a big no-no for the static semantic parser, since it's 
literally a _static_ type-checker, and doesn't know about dynamic 
differences. 

The main offender is the networking layer that sometimes keeps user
pointers and sometimes kenrel pointers in a "struct iovec". David has
promised to look into this, and seemed confident that he can fix it 
easily.

Most people who have used the tool actually like how it forces you to make 
it very _explicit_ whether you're using a user pointer or not. But I have 
to admit that I've grown tired of trying to look at all the uses and 
making sure which sparse warnings are valid and which aren't.

				Linus

