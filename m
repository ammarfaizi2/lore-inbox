Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933205AbWFXCoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933205AbWFXCoG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 22:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWFXCn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 22:43:29 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:46222 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932132AbWFXCnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 22:43:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e5kOis0D237MFmhcvwiLxBNty0nbE9WqclUaGWr5G4mhZN66pOpg0fNJ8ORdK7sPlCx5DuaOkTe1EO0FPoqYE7Rz8t/y+FBEljuAh7D6UQ8xfdq1egEiazohGkam5vYtOlm8Uey8hMRtXrBmqAeJzaUI7jRuuE80iB2I3ZLURkk=
Message-ID: <787b0d920606231943x7aad43bwb108b6a88b678b1a@mail.gmail.com>
Date: Fri, 23 Jun 2006 22:43:05 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: i386 ABI and the stack
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       76306.1226@compuserve.com, ak@muc.de, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.64.0606231907290.6483@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920606231837k5d57da8ct5c511def6c035176@mail.gmail.com>
	 <Pine.LNX.4.64.0606231844460.6483@g5.osdl.org>
	 <449C9C6D.7050905@zytor.com>
	 <Pine.LNX.4.64.0606231907290.6483@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/06, Linus Torvalds <torvalds@osdl.org> wrote:
> On Fri, 23 Jun 2006, H. Peter Anvin wrote:
> > >
> > > The x86-64 ABI has a 128-byte(*) zone that is safe from signals etc, so you
> > > can use a small amount of stack below the stackpointer safely. Not so on
> > > x86.
> >
> > Adding a small redzone like this to i386 would be easy, though -- just drop
> > the stack pointer by that much when creating a signal frame.  128 bytes isn't
> > enough to interfere with libraries.
>
> However, any binaries created with that in mind would be
> buggy-by-definition on older kernels, so I don't think it's worth it.

Since gcc-2.96 would access 256 bytes below the stack pointer
(according to the valgrind man page), the kernel needs to allow
for this in signal handlers anyway.

I'm pretty sure I saw that code in the kernel in fact, but I
can't find it now. Perhaps it got lost in a cleanup accident?
(it sure would be nice to have continuous source control history)
