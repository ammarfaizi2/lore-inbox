Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265710AbUA0SpD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 13:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265728AbUA0SpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 13:45:03 -0500
Received: from ns.suse.de ([195.135.220.2]:32410 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265710AbUA0So7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 13:44:59 -0500
Date: Tue, 27 Jan 2004 19:44:57 +0100
From: Andi Kleen <ak@suse.de>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: mahalcro@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Encrypted Filesystem
Message-Id: <20040127194457.5f4cf3c9.ak@suse.de>
In-Reply-To: <4016AB1F.9EF8F42@users.sourceforge.net>
References: <OFA97B290B.67DE842E-ON87256E27.0061728C-86256E27.0061BB0E@us.ibm.com.suse.lists.linux.kernel>
	<p73znc9s724.fsf@nielsen.suse.de>
	<4016AB1F.9EF8F42@users.sourceforge.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jan 2004 20:17:03 +0200
Jari Ruusu <jariruusu@users.sourceforge.net> wrote:
> > The biggest shortcomming in crypto loop is that you cannot change the
> > password easily. Doing so would require reencryption of the whole
> > volume and it is hard to do so in a crash safe way (or you risk loss
> > of the volume when the machine crashes during reencryption)
> 
> Not true with loop-AES where changing password is either:

[...] My version of the loop tools also do all this correctly too. But the loop
most people seem to be using is as insecure as always.  Congratulations
that you fixed it too.

Still considering the other points I think a stacked file system would
be far better  (integrated meta data, separate keys for different files etc.)
Even though I invested quite some work into fixing loop I still think it's a bad
hack, not a real design.

> > The standard crypto loop uses
> > fixed IVs too which do not help against this.
> 
> Not true. Mainline uses simple sector IV. SuSE twofish uses fixed IV which
> is even more vulnerable than mainline. 

It's as as vunerable, but more stable. The mainline IVs are basically useless
for security purposes but broke  on disk format compatibility all the time when 
someone misguided decided again to "improve" the IV format in loop.c (happened far too 
often in the past). In my own loop tools I used them with an hashed IV, added some 
hacks for different IV versions as far as they were fixable and grumbingly converted
the disk format in one case.

[... encrypted swap using a random key for each session...]

Good point. I didn't think of that. Still it's a lot of overhead if you
only use crypto occassionally. With the tainted bit it would be possible to only encrypt 
pages of processes that have been tainted or better not page them out at all.

-Andi
