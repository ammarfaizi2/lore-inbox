Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267497AbTACL0P>; Fri, 3 Jan 2003 06:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267500AbTACL0O>; Fri, 3 Jan 2003 06:26:14 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:9859 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S267497AbTACL0N>;
	Fri, 3 Jan 2003 06:26:13 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andy Chou <acc@CS.Stanford.EDU>
Date: Fri, 3 Jan 2003 12:34:51 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [CHECKER] 24 more buffer overruns in 2.5.48
Cc: alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mc@cs.stanford.edu
X-mailer: Pegasus Mail v3.50
Message-ID: <C2B6EB553C4@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  2 Jan 03 at 19:06, Andy Chou wrote:
> > > void do_install_cmap(int con, struct fb_info *info)
> > > {
> > >     if (con != info->currcon)
> > >     return;
> > 
> > currcon can never be -1. I don't think the compiler can ever deduce that
> > detail though.

With matroxfb (and dozen of other fbdevs) currcon can be -1 (with matroxfb
currcon can be even -2 during probe, so con != info->currcon tests always
fail...) when there is no VT attached to the fbdev. That's why matroxfb
uses my_install_cmap instead of generic one.

It should be no issue in 2.5.54 though, as there is no install_cmap 
anymore...
                                                    Petr Vandrovec
                                                    
