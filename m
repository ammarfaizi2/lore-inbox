Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268854AbTCCXCO>; Mon, 3 Mar 2003 18:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268857AbTCCXCO>; Mon, 3 Mar 2003 18:02:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39944 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268854AbTCCXCN>; Mon, 3 Mar 2003 18:02:13 -0500
Date: Mon, 3 Mar 2003 15:09:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Benjamin LaHaise <bcrl@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Horrible L2 cache effects from kernel compile
In-Reply-To: <1046735907.7947.0.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0303031508190.12325-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 3 Mar 2003, Alan Cox wrote:
> On Mon, 2003-03-03 at 19:13, Linus Torvalds wrote:
> > dentry itself. Yes, you could make it smaller (you could remove the inline
> > string from it, for example, and you could avoid allocating it at
> 
> How about at least making the inline string align to the slab alignment so we
> dont waste space ?

2.5.x does that already:

	#define DNAME_INLINE_LEN \
	        (sizeof(struct dentry)-offsetof(struct dentry,d_iname))

with the DNAME_INLINE_LEN_MIN just being exactly what the name says: the 
minimum size.

		Linus

