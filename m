Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268918AbTGJAMR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 20:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268723AbTGJAIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 20:08:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25993 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266225AbTGJAHA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 20:07:00 -0400
Message-ID: <3F0CB185.3000308@pobox.com>
Date: Wed, 09 Jul 2003 20:21:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Andreas Dilger <adilger@clusterfs.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Christoph Hellwig <hch@infradead.org>, marcelo@connectiva.com.br,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: ->direct_IO API change in current 2.4 BK
References: <20030709133109.A23587@infradead.org>	 <200307091954.12895.m.c.p@wolk-project.de>	 <Pine.LNX.4.55L.0307091506180.27004@freak.distro.conectiva>	 <200307092022.35295.m.c.p@wolk-project.de>	 <Pine.LNX.4.55L.0307091611140.29759@freak.distro.conectiva> <1057794223.7137.15.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1057794223.7137.15.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2003-07-09 at 20:13, Marcelo Tosatti wrote:
> 
>>I applied it because, in my ignorance, I did not noticed it would break
>>the stable API.
>>
>>I applied it because I wanted comments useful from people (Like hch and
>>others did).
> 
> 
> I'm not sure I see what the fuss is about a slight API change that is
> safe since it spews warnings/breaks existing code that isnt fixed. At
> least one vendor kernel also has the changed API anyway


"safe" ignores the pain of people trying to support multiple kernels. 
Each API change like the direct_IO one introduces ifdefs.  Changing a 
function prototype is particularly annoying because you can't create a 
backwards-compat wrapper

I disagree with the AC97 codec changes being merged into 2.4, too, for 
the same reason.  Yes I recognize it is required to support new 
hardware.  Yes I realize it vastly simplifies supporting some existing 
hardware.  But I don't think you realize (or don't care?) about the 
maintenance pain created by the change.  If a vendor wishes their driver 
to support 2.4.21 _and_ 2.4.22 (not a lot to ask), they must add a bunch 
of ifdef crud in their OSS driver.

Feature and API additions are _far_ less painful than API changes in the 
middle of a stable series.

Overall, I think we are looking at a question which needs to be answered 
by the community:  what constitutes a stable series?  when do we stop 
changing the API and let it stabilize?  ... and I am writing a mail 
right now to ask that question (as requested by Marcelo and a couple 
others, though I wanted to do it for a while now).

	Jeff



