Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267707AbUHJVO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267707AbUHJVO6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267727AbUHJVO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:14:58 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:39712 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267707AbUHJVOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:14:49 -0400
Date: Tue, 10 Aug 2004 23:16:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] select FW_LOADER -> depends HOTPLUG
Message-ID: <20040810211656.GA7221@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20040809195656.GX26174@fs.tum.de> <20040809203840.GB19748@mars.ravnborg.org> <Pine.LNX.4.58.0408100130470.20634@scrub.home> <20040810084411.GI26174@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810084411.GI26174@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 10:44:11AM +0200, Adrian Bunk wrote:
> 
> I assume Sam thinks in the direction to let a symbol inherit the 
> dependencies off all symbols it selects.
> 
> E.g. in
> 
> config A
> 	depends on B
> 
> config C
> 	select A
        depends on Z

  config Z
        depends on Y
> 
> 
> C should be treated as if it would depend on B.

Correct. But at the same time I miss some functionality to
tell me what a given symbol:
1) depends on
2) selects

It would be nice in menuconfig to see what config symbol
that has dependencies and/or side effects. 

[*] PCI support
Could look like:
[*]d PCI support
The space for the 'd' tag could be misused for other purposes later.


The pressing 'd' would give me the following output:

C "The C prompt"
-> depends on
   CONFIG_Z "Prompt for Z"
   -> depends on
      CONFIG_Y "Prompt for Y"
-> Selects
   CONFIG_A "Promtp for A"
   -> depends on
      CONFIG_B "Prompt for B"

Or something similar.
The idea is to give user an idea of dependencies (both ways) - recursive.
Using both CONFIG symbol and prompt will give the user an idea where to
locate it.

Something like this is on my wish list.

	Sam
