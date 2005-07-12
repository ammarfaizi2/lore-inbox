Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVGLSLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVGLSLp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 14:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVGLSLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 14:11:45 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:62367 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261892AbVGLSLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 14:11:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AckVYq3ylb22wqd4q553Si7Fq4kNBqpTQilInbQM4rS2YmZDS6W8QAQ5/PPisdSVxcJiBMEwi9C7QDZau8nlUxTTRy5KryG6ZDibk1wwddtGzHpntPFjbk5XUgAGVOaHHPM51xyFjYbfOqJmB2oSAKl7cJGh3NwLKugqVZ6iaYA=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Michael Krufky <mkrufky@m1k.net>
Subject: Re: [PATCH -rc2-mm2] BUG FIX - v4l broken hybrid dvb inclusion
Date: Tue, 12 Jul 2005 22:18:38 +0400
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com
References: <42D3DC5A.3010807@m1k.net> <200507122107.51907.adobriyan@gmail.com> <42D3FBA4.3050501@m1k.net>
In-Reply-To: <42D3FBA4.3050501@m1k.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507122218.38508.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 July 2005 21:19, Michael Krufky wrote:
> Alexey Dobriyan wrote:
> >On Tuesday 12 July 2005 19:06, Michael Krufky wrote:
> >  
> >
> >>v4l-saa7134-hybrid-dvb.patch
> >>v4l-cx88-update.patch
> >>
> >>The specific change that caused this problem is:
> >>
> >>- Let Kconfig decide whether to include frontend-specific code.
> >>
> >>I had tested this change against 2.6.13-rc2-mm1, and it worked perfectly as
> >>expected, but it caused problems in today's 2.6.13-rc2-mm2 release.  For
> >>some reason, the symbols don't get set properly.
> >>    
> >>
> >What symbols? What error messages do you see?
> >
> Alexey-
> 
> Maybe symbols was the wrong terminology... What I meant was the 
> CONFIG_DVB_LGDT3302 , etc flags
> 
> Previous patch removed the #define's that you see below... This should 
> have worked, since these should be set instead from kconfig, but it 
> didn't work as expected (even though the modules ARE selected by 
> kconfig),

Strange... I did allyesconfig and preprocessed source shows lgdt3302.h,
or51132.h et al. are included. What's your .config?

> and the #ifdef's return false.... (I don't know why it worked  
> in my test against 2.6.13-rc2-mm1, but it doesn't work in -mm2, and it 
> must be fixed) Breaks all hybrid v4l/dvb boards.
> 
> >>--- linux-2.6.13-rc2-mm2.orig/drivers/media/video/cx88/cx88-dvb.c
> >>+++ linux/drivers/media/video/cx88/cx88-dvb.c
> >>    
> >>
> >>+#define CONFIG_DVB_MT352 1
> >>+#define CONFIG_DVB_CX22702 1
> >>+#define CONFIG_DVB_OR51132 1
> >>+#define CONFIG_DVB_LGDT3302 1
> >>    
> >>
> >>--- linux-2.6.13-rc2-mm2.orig/drivers/media/video/saa7134/saa7134-dvb.c
> >>+++ linux/drivers/media/video/saa7134/saa7134-dvb.c
> >>    
> >>
> >>+#define CONFIG_DVB_MT352 1
> >>+#define CONFIG_DVB_TDA1004X 1
