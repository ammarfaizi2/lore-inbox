Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266224AbUBQPNI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 10:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266227AbUBQPNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 10:13:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:22202 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266224AbUBQPNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 10:13:05 -0500
Date: Tue, 17 Feb 2004 07:13:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: tridge@samba.org
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <16433.47753.192288.493315@samba.org>
Message-ID: <Pine.LNX.4.58.0402170704210.2154@home.osdl.org>
References: <16433.38038.881005.468116@samba.org> <Pine.LNX.4.58.0402162034280.30742@home.osdl.org>
 <16433.47753.192288.493315@samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004 tridge@samba.org wrote:
> 
> From memory, the patch added new classes of dentries to the current
> "+ve" and "-ve" dentries. It added concepts like a "-ve
> case-insensitive" dentry and a "-ve case-sensitive" dentry. It
> certainly adds more code in trying to deal with these variants, but I
> see no reason why it should be significantly computationally less
> efficient.

Yes, we could add context sensitivity to the dcache with a context 
bitmask.

However, it's _not_ correct.

It assumes that there is only one way to do lower/upper case, which just 
isn't true. What about different locales that have different case rules? 
Your "one bit per dentry" becomes "one bit per locale per dentry". That's 
just horribly hard to do.

I don't know how Windows does it, so maybe this thing is hardcoded, and 
you don't even want "true" case insensitivity. How "correct" is Windows?

(And don't even bother telling me about the translation table in NTFS 
volumes - I'm not interested. This would have to work on a sane filesystem 
to be useful, even for samba.)

		Linus
