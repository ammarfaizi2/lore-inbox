Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265356AbUBPGV7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 01:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265357AbUBPGV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 01:21:59 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:29190 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S265356AbUBPGV5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 01:21:57 -0500
Date: Sun, 15 Feb 2004 22:21:52 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior
Message-ID: <20040216062152.GB5192@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr>
User-Agent: Mutt/1.3.27i
X-Message-Flag: If you're running Outlook, look out!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 12:03:03AM +0100, Nicolas Mailhot wrote:
> | Linus Torvalds pointed the way of Tux :
> 
> | In short: the kernel talks bytestreams, and that implies that if you 
> | want to talk to the kernel, you HAVE TO USE UTF-8.
> 
> In that case :
> - should the kernel allow apps to write filenames that are invalid 
>   UTF-8 and will crash UTF-8 apps ?

Yes.  The kernel interface specifies it as a bytesteam with
0x00 and 0x2f having special meaning.  That is a constraint,
not a policy.  It is user space that determines the policy
of UTF-8.

>   UTF-8 and will crash UTF-8 apps ?

Fix the broken apps.  Crashing because of "invalid" UTF-8 is
no more excusable than crashing because of a string longer
than expected (buffer overrun).  Filenames as read from the
filesystem should be treated just like any other untrusted
input.

> - should this UTF-8 rule be noted somewhere (in a FAQ/man page/LSB spec/
> whatever) so apps authors know they are supposed to read and write UTF-8
> filenames and not apply locale rules to kernel objects ?

Since the LSB spec describes user space it might be a
suitable place.

> - what happens to already existing invalid UTF-8 filenames ? Should the
> kernel forcibly rewrite them (in 2.7.0...) to remove legacy mess ? What

If you have a filesystem with filenames that don't conform
to your policy write userspace tools to detect and/or fix
them.  If you have programs creating non-conforming
filenames, fix or rm those programs.

> kernel forcibly rewrite them (in 2.7.0...) to remove legacy mess ? What
> should happen if someone plug an unconverted FS in such a system
> afterwards ?

The kernel won't care.  Any user space code that treats the
filenames as something other than bytestreams should be able
to cope with any sequence of bytes.

> These are the questions people have been asking.

OK.  The questions have been asked and answered.
Asking again and again and again won't change the answer.



-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
