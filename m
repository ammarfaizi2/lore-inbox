Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSFJHI5>; Mon, 10 Jun 2002 03:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316397AbSFJHI4>; Mon, 10 Jun 2002 03:08:56 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:39572 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S314634AbSFJHIz>;
	Mon, 10 Jun 2002 03:08:55 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200206100708.AAA19223@csl.Stanford.EDU>
Subject: Re: [CHECKER] 54 missing null pointer checks in 2.4.17
To: bhards@bigpond.net.au (Brad Hards)
Date: Mon, 10 Jun 2002 00:08:46 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
In-Reply-To: <200206101703.13780.bhards@bigpond.net.au> from "Brad Hards" at Jun 10, 2002 05:03:13 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for these. Patch for 2.4.19-pre10 to fix catc and se401 bugs currently 
> compile testing :)

Good deal!  Thanks for letting us know.

> > 	se401->width=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
> > 	se401->height=kmalloc(se401->sizes*sizeof(int), GFP_KERNEL);
> > 	for (i=0; i<se401->sizes; i++) {
> > 		    se401->width[i]=cp[6+i*4+0]+cp[6+i*4+1]*256;
> > 		    se401->height[i]=cp[6+i*4+2]+cp[6+i*4+3]*256;
> > 	}
> > 	sprintf (temp, "%s Sizes:", temp);
> > 	for (i=0; i<se401->sizes; i++) {
> > Error --->
> > 		sprintf(temp, "%s %dx%d", temp, se401->width[i], se401->height[i]);
> > 	}
> > 	info("%s", temp);
> > 	se401->maxframesize=se401->width[se401->sizes-1]*se401->height[se401->size
> >s-1]*3; ---------------------------------------------------------
> bradh: this one is wrong. If it didn't oops on the previous one, it won't oops 
> here :)

Yeah, indeed.  The current rewrite doesn't (yet) have false path suppression
back in and I'm getting too old to be reliable.  Thanks for pointing it
out.  
