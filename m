Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbTI2RyY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263993AbTI2Rth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:49:37 -0400
Received: from intra.cyclades.com ([64.186.161.6]:34960 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263994AbTI2RtE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:49:04 -0400
Date: Mon, 29 Sep 2003 14:48:33 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@localhost.localdomain
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
In-Reply-To: <20030924001334.A19940@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0309271332080.2874-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 24 Sep 2003, Pete Zaitcev wrote:

> > Date: Tue, 23 Sep 2003 13:15:15 -0700
> > From: Chris Wright <chrisw@osdl.org>
> 
> > --- 1.38/sound/oss/ymfpci.c	Tue Aug 26 09:25:41 2003
> > +++ edited/sound/oss/ymfpci.c	Tue Sep 23 12:42:45 2003
> > @@ -2638,6 +2638,7 @@
> >   out_free:
> >  	if (codec->ac97_codec[0])
> >  		ac97_release_codec(codec->ac97_codec[0]);
> > +	kfree(codec);
> >  	return -ENODEV;
> >  }
> 
> Someone was savaging sound code, adding these bugs.
> For 2.6, the above patch is probably ok; it's immaterial,
> because ALSA won long ago.
> 
> A patch for 2.4 to undo the damage is attached.

Pete, 

So let me see if I get it right: The above "+ kfree(codec)" addition caused the bug?



