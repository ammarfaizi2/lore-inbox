Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271182AbTHLVih (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 17:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271177AbTHLViY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 17:38:24 -0400
Received: from dsl017-022-215.chi1.dsl.speakeasy.net ([69.17.22.215]:40710
	"EHLO gateway.two14.net") by vger.kernel.org with ESMTP
	id S271156AbTHLVg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 17:36:57 -0400
Date: Tue, 12 Aug 2003 16:36:45 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, Stephan von Krawczynski <skraw@ithnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.22-rc2 ext2 filesystem corruption
Message-ID: <20030812213645.GA1079@furrr.two14.net>
Reply-To: maney@pobox.com
References: <20030812165624.GA1070@furrr.two14.net> <Pine.LNX.4.44.0308121408450.10045-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308121408450.10045-100000@logos.cnet>
User-Agent: Mutt/1.3.28i
From: maney@two14.net (Martin Maney)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 02:09:53PM -0300, Marcelo Tosatti wrote:
> Well, rc2 had a Promise change. I'm not sure if it could be the cause, but 
> lets check.

> Please try -rc2 with the following patch unpplied (patch -R): 

Oops, I overlooked the change.  Tried it with a relatively
stripped-down 22-rc2 build (slimmed the vmlinuz down by about 100K),
but that made no difference.  I popped a CMD648-based card in, disabled
the on-board Promise chip, and it booted right up and works fine with
22-rc2.  So if the .id -> .present is the only change that affected the
Promise driver (I did some looking for obvious, but gave up after
realizing that unless the change actually had a /* borks Promise IDE
controllers*/ in it I wouldn't be likely to recognize it), then I guess
that's it.

> # [PATCH] PATCH: Promise cable
> # 
> # The old driver used to check .id was NULL to detect drive absent
> # (which is wrong but generally worked) with the IDE changes it always
> # got it wrong. This fixes it to test .present instead.
> # 
> # Without this fix it mistakenly assumes that the empty drive slot
> # cannot do UDMA66/100/133

Does this really mean that the Promise has been running at only 33MHz
all along, and that with this fix it stopped choking the speed and
that's the cause of the problem?  I know that back when I first setup
this drive on the Promise (over a year ago - I'm pretty sure I was
runnign 2.2.latest back then and had to jumper the drive to get around
the 64K cylinders problem) I know I saw transfer speeds greater than
33MB reported by hdparm -T.

Okay, for completeness I should back out that change and retest it with
the Promise, and I'll try to remember to throw a quick throughput test
in just to see what it's been doing to me.  ;-)

BTW, yes, I am (and have been) using an 80-pin cable with this drive.

-- 
Faced with the choice between changing one's mind and proving there is
no need to do so, almost everyone gets busy on the proof. -- JKG

