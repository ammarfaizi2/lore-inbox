Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbSKMVQg>; Wed, 13 Nov 2002 16:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbSKMVQf>; Wed, 13 Nov 2002 16:16:35 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:50602 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262824AbSKMVPs>; Wed, 13 Nov 2002 16:15:48 -0500
Subject: RE: FW: i386 Linux kernel DoS (clarification)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <76D1FF66BB6@vcnet.vc.cvut.cz>
References: <76D1FF66BB6@vcnet.vc.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Nov 2002 21:48:15 +0000
Message-Id: <1037224095.11979.156.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-13 at 21:18, Petr Vandrovec wrote:
> >     pushfl          # We get a different stack layout with call
> >                 # gates, which has to be cleaned up later..
> > +   andl $~0x4500, (%esp)   # Clear NT since we are doing an iret
> 
> this will clear 'D' and 'T' in caller after we do
> iret (if lcall7 returns, of course). I'm not sure that callers

You can adjust that if you want, I copied it about - clearing D is fine,
in fact it may let us avoid the cld

> >  error_code:
> > +   pushfl
> > +   andl $~0x4500, (%esp)       # NT must be clear, do a cld for free
> > +   popfl
> 
> I believe that NT should be automagically cleared by int.

Apparently so - you are I think 100% correct that this isnt needed

