Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVARNPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVARNPJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 08:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVARNPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 08:15:09 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:25716 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261273AbVARNPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 08:15:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=WfFfxMW8ZNFh9t86Mbw5CUoD90oAjUdB0VrObjFzUZOygE9f1BA+bJThHTdn27wOaHhHYM4W/GFTVv7PpSjw/3jJ66NP+RBbOj7GfxfePrcu6wvf2pnD9EyINq8GDaeh49uASFm9jR2tuxTDewC8+xfIyYh8kMw9X2TbJHD0Oag=
Message-ID: <4d6522b905011805154bf27b52@mail.gmail.com>
Date: Tue, 18 Jan 2005 15:15:01 +0200
From: Edjard Souza Mota <edjard@gmail.com>
Reply-To: Edjard Souza Mota <edjard@gmail.com>
To: 7eggert@gmx.de
Subject: Re: User space out of memory approach
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ilias Biris <xyz.biris@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E1CqDGM-0000wi-00@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <fa.lcmt90h.1j1scpn@ifi.uio.no> <fa.ht4gei4.1g5odia@ifi.uio.no>
	 <E1CqDGM-0000wi-00@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
> If my system needs the OOM killer, it's usurally unresponsive to most
> userspace applications. A normal daemon would be swapped out before the
> runaway dhcpd grows larger than the web cache. It would have to be a mlocked
> RT task started from early userspace. It would be difficult to set up (unless
> you upgrade your distro), and almost nobody will feel like tweaking it to
> take the benefit (OOM == -ECANNOTHAPPEN).

Please correct me if I got it wrong: as deamon in this case is not a normal one,
since it never gets rate for its own safety, then it needs an RT lock whenever
system boots. 

> What about creating a linked list of (stackable) algorhithms which can be
> extended by loading modules and resorted using {proc,sys}fs? It will avoid
> the extra process, the extra CPU time (and task switches) to frequently
> update the list and I think it will decrease the typical amount of used
> memory, too.

Wouldn't this bring the (set of ) ranking algorithm(s) back to the kernel? This
is exactly what we're trying to avoid. The way we see the potential for doing 
this is that kernel shouldn't  worry about users decision on which process to 
kill but rather take her/his option into account. The computation of such a
decision could be at user space (protected as you suggested above).

We'll think about it, although I'm not sure if there would be such a decrease 
in memory concumption.

br

Edjard


-- 
"In a world without fences ... who needs Gates?"
