Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbTLDPVB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 10:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTLDPU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 10:20:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:46228 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262308AbTLDPUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 10:20:48 -0500
Date: Thu, 4 Dec 2003 07:20:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem
In-Reply-To: <20031204141725.GC7890@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.58.0312040712270.2055@home.osdl.org>
References: <1070485676.4855.16.camel@nucleon> <20031203214443.GA23693@wohnheim.fh-wedel.de>
 <Pine.LNX.4.58.0312031600460.2055@home.osdl.org> <20031204141725.GC7890@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Dec 2003, Jörn Engel wrote:
>
> Isn't that a problem already handled by all compressing filesystems?
> Or did I miss something really stupid?

Yes, compression and encryption are really the same thing from a fs
implementation standpoint - they just have different goals. So yes, any
compressed filesystem will largely have all the same issues.

And compression isn't very easy to tack on later either.

Encryption does have a few extra problems, simply because of the intent.
In a compressed filesystem it is ok to say "this information tends to be
small and hard to compress, so let's not" (for example, metadata). While
in an encrypted filesystem you shouldn't skip the "hard" pieces..

(Encrypted filesystems also have the key management issues, further
complicating the thing, but that complication tends to be at a higher
level).

		Linus
