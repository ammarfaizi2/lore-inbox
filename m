Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTKGW20 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbTKGW2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:28:05 -0500
Received: from zeus.kernel.org ([204.152.189.113]:64983 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263980AbTKGWCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 17:02:36 -0500
Date: Fri, 7 Nov 2003 22:05:35 +0100
From: Jens Axboe <axboe@suse.de>
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
Cc: torvalds@osdl.org, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-ID: <20031107210535.GA445@suse.de>
References: <3FA69CDF.5070908@gmx.de> <3FA8C916.3060702@gmx.de> <20031105095457.GG1477@suse.de> <3FA8CA87.2070201@gmx.de> <boe68a$f3g$1@gatekeeper.tmr.com> <3FAAB8B5.6060901@gmx.de> <3FAABFBF.3040300@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAABFBF.3040300@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06 2003, Prakash K. Cheemplavam wrote:
> Prakash K. Cheemplavam wrote:
> >bill davidsen wrote:
> >
> >>In article <3FA8CA87.2070201@gmx.de>,
> >>Prakash K. Cheemplavam <prakashkc@gmx.de> wrote:
> >>
> >>| Sorry, I wasn't precise: The data is on the disc, as my DVD-ROM 
> >>restores | the full image (md5sum matches), but the CD-RW does not.
> >>
> >>There is a problem with ide-scsi in 2.6, and rather than fix it someone
> >>came up with a patch to cdrecord to allow that application to work
> 
> >b) The writing or reading issue mentioned above. It is a bit hard to 
> >find out, whether cdrecord actually *writes* an incomplete image 
> >(without using -pad), ie. throwing away the last 4096 bytes, which 
> >*only* happens in non-TAO mode. The programme CDRDAO shows the same 
> >behaviour. Strange enough reading this DAO written image out with my 
> >DVD-ROM makes this (missing?) 4096 bytes reappear... Well, maybe I 
> >should patch the image and put some other bytes instead of the 00s at 
> >the end to see, whether it is a write issue, a read issue of the writer 
> >or a read issue of the reader. Anyway, it doesn't sound right to me, 
> >what is happening at the moment...
> 
> So tested further: I patched the very last byts of the image and these 
> are my findings:
> 
> In DAO mode, the complete image is actually written, but the writer is 
> not able to read it out! The last 4096 bytes are not read. I put the 
> CD-RW into my DVD-ROM, and it reads it out completely.
> 
> So: Is cdrecord/cdrdao making something wrong (yes, I know I can use 
> -pad, but I want an *identical copy*) or has the kernel ATAPI reading 
> routine a bug? (Or has my drive a bug???? Well, I need to read the disc 
> out in windows I guess...)

See one of my mails from a few days ago. It's a hardware issue, some
drives need a bit of pad at the end.

-- 
Jens Axboe

