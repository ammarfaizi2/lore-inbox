Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261876AbTCaWTQ>; Mon, 31 Mar 2003 17:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261877AbTCaWTP>; Mon, 31 Mar 2003 17:19:15 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:53163 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S261876AbTCaWTO>; Mon, 31 Mar 2003 17:19:14 -0500
Message-ID: <3E88BFA9.5010003@nortelnetworks.com>
Date: Mon, 31 Mar 2003 17:22:33 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, erik@hensema.net,
       linux-kernel@vger.kernel.org
Subject: Re: Delaying writes to disk when there's no need
References: <slrnb843gi.2tt.usenet@bender.home.hensema.net> <20030328231248.GH5147@zaurus.ucw.cz> <slrnb8gbfp.1d6.erik@bender.home.hensema.net> <3E8845A8.20107@aitel.hist.no> <3E88BAF9.8040100@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> I haven't thought about this much, but it seems to me that
> doing writeout whenever the disk would otherwise be idle
> (and we have dirty memory to write out) would be a good
> solution.

The whole argument about waiting though is that there may be another write 
coming to the same place, in which case you could save the cost of the first 
write because it didn't have to be written.

Writing to disk isn't free, even if the disk would otherwise be idle.  You have 
the cost of the setup as well as the memory and pci bus traffic.  You may have 
disk bandwidth available but be already maxing out the PCI bus, in which case 
your "free" disk write takes I/O away from other things.

Ultimately its all a tradeoff.  Do you write now, or do you hold off and hope 
that you can throw away some of the writes because new stuff will home in to 
overwrite them?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

