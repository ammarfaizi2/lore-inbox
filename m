Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270667AbTHFMp5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 08:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270750AbTHFMp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 08:45:57 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:16391 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S270667AbTHFMp4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 08:45:56 -0400
Date: Wed, 6 Aug 2003 14:45:16 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: marcelo@conectiva.com.br, andrea@suse.de, linux-kernel@vger.kernel.org,
       green@namesys.com, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-ID: <20030806124516.GA11720@alpha.home.local>
References: <20030802142734.5df93471.skraw@ithnet.com> <Pine.LNX.4.44.0308051340010.2848-100000@logos.cnet> <20030806094150.4d7b0610.skraw@ithnet.com> <20030806090920.GA9492@alpha.home.local> <20030806113658.7a53731c.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806113658.7a53731c.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hm, the hardware may not be that widespread. I guess not many people are really
> using SMP, 64 bit PCI network, 3 GB RAM, 3ware RAID5 and serverworks board
> altogether in one box. I can't fight the impression it has something to do with
> locking issues. It doesn't look exactly like a hardware problem, you would not
> expect crashes on the same type of code then.

Well, it depends... I once had an overclocked CPU which died only in one
case, it was a car simulator, and it always crashed exactly on the same race,
at the same position in the round ! I even knew that if I could pass that
position, it was ok for another round ! So I later used that game as a
reliability test when I was not sure about the origin of a crash :-)
It seems as a particular sequence of data and/or code could reliably trigger it
although parallel makes never hurt it.

> The question is: what additional information is needed to find the underlying
> problem?

Perhaps cache poisonning could help. Alan has already used this technique
extensively in the past, and might still have a patch which could apply to your
kernel without too many changes. Alan ?

On the other hand, you could also do it by hand, but it's a little hard. You
have to pick every place there's a free, and write particular data before the
free, if possible, data which can identify who has freed the page.

Then after the next crash, you can identify who used the page last. It can
sometimes lead you to some driver missing a lock. But that's not certain.

Cheers,
Willy

