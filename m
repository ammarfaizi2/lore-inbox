Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288457AbSADCdl>; Thu, 3 Jan 2002 21:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288458AbSADCdb>; Thu, 3 Jan 2002 21:33:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54288 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288457AbSADCdX>; Thu, 3 Jan 2002 21:33:23 -0500
Date: Thu, 3 Jan 2002 18:32:46 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>, <andries.brouwer@cwi.nl>
Subject: Re: 2.5.2-pre7 still missing bits of kdev_t
In-Reply-To: <3C34F3AA.23431926@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0201031828540.1153-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 Jan 2002, Jeff Garzik wrote:
>
> reiserfs is blindly storing the kernel's kdev_t value raw to disk.

Well, it won't do that. You have to use "kdev_t_to_nr()", which (whenever
the format of kdev_t changes) will still be identical in the low 16 bits.

Now, if somebody actually has the raw "kdev_t" in their on-disk
structures, that's a real problem, but I don't think anybody does.
Certainly I didn't see reiserfs do it (but it may well be missing a few
"kdev_t_to_nr()" calls)

		Linus

