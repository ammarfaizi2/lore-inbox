Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbVLDJ3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbVLDJ3N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 04:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVLDJ3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 04:29:13 -0500
Received: from fep30-0.kolumbus.fi ([193.229.0.32]:14144 "EHLO
	fep30-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1751340AbVLDJ3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 04:29:12 -0500
Date: Sun, 4 Dec 2005 11:29:19 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Hugh Dickins <hugh@veritas.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Ryan Richter <ryan@tau.solarneutrino.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <Pine.LNX.4.61.0512022041130.6058@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.63.0512041053030.10914@kai.makisara.local>
References: <20051129092432.0f5742f0.akpm@osdl.org> 
 <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local> 
 <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org> <1133468882.5232.14.camel@mulgrave>
 <Pine.LNX.4.63.0512012304240.5777@kai.makisara.local>
 <Pine.LNX.4.61.0512021325020.1507@goblin.wat.veritas.com>
 <Pine.LNX.4.63.0512021932590.4506@kai.makisara.local>
 <Pine.LNX.4.61.0512021836100.4940@goblin.wat.veritas.com>
 <Pine.LNX.4.63.0512022131440.4506@kai.makisara.local>
 <Pine.LNX.4.61.0512022041130.6058@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2005, Hugh Dickins wrote:

> On Fri, 2 Dec 2005, Kai Makisara wrote:
> > On Fri, 2 Dec 2005, Hugh Dickins wrote:
> > 
> > > It's just that after seeing how sg.c is claiming to dirty even readonly
> > > memory, I'm excessively averse to saying we've dirtied memory we haven't.
> > > My hangup, I'll get over it!
> > > 
> > Please don't. I have a very conservative attitude to these things: my 
> > priority is to make sure that the data is correct even if it is not the 
> > fastest code. I will happily let others point out when I am too 
> > conservative.
> 
> I'm not certain which way you're directing me now: a conservative
> attitude suggests we play safe at the end of st_read, by saying we might
> somehow have dirtied memory there, perhaps if someone changes sequence.
> 
You should do what you think is best. One of the driver maintainers tasks 
is to look at the changes and ask questions if there is something 
suspicious. I asked and you pointed out that this time my concern was not 
valid.

During this discussion you have mentioned good arguments favouring both 
choices. Peformancewise we are talking about a rather theoretical issue: 
in a production server this issue might be relevant a few times a year.

My current suggestion is to use the value 1 (to minimise the possibility 
of bugs due to future changes). If you want, you can add a comment saying 
that using 1 is not strictly necessary with the current design.

> As I presently, incompletely have it, to maintain more similarity with
> sg.c, I've actually moved away from "dirtied" to "rw" READ or WRITE,
> and it will look odd to put WRITE at the end of st_read.
> 
It might be best to use naming that does not bind the purpose of the 
parameter to any "abstract" (i.e., read or write) activity when the 
purpose is to tell the function that the buffer contents may have been 
altered.

> I'm giving up for the evening, and probably won't have a chance to do
> more until Sunday - the PageCompound issue still under discussion too.
> 
> Hugh
> 

-- 
Kai
