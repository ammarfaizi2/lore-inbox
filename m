Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUFXLEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUFXLEH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 07:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbUFXLEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 07:04:06 -0400
Received: from box.punkt.pl ([217.8.180.66]:38414 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S264246AbUFXLED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 07:04:03 -0400
From: Mariusz Mazur <mmazur@kernel.pl>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.7.0
Date: Thu, 24 Jun 2004 13:02:21 +0200
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, Chris Friesen <cfriesen@nortelnetworks.com>,
       linux-kernel@vger.kernel.org
References: <200406240102.23162.mmazur@kernel.pl> <20040624055832.GA10531@kroah.com> <40DA9C6E.8050205@pobox.com>
In-Reply-To: <40DA9C6E.8050205@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200406241302.21617.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On czwartek, 24 czerwca 2004 11:18, Jeff Garzik wrote:
> Agreed...  It's just getting 'down and dirty' and separating the ABI
> stuff from the non-ABI stuff.  It's not necessarily difficult, just
> incredibly long and tedious, and potentially political.

One step at a time. It's quite simple to remove userland definitions from a 
header and place them somewhere else (at least technically). Since kernel 
headers are currently useless in userland anyway, nobody should care if they 
get altered any more (yeah... right :). My plan is to take care of the 
functionality covered by glibc first and start separating that stuff to some 
abi dir (that is why I've requested more details). Once a patch for 
separating header A gets merged and a new kernel gets released I'd simply 
make llh use that abi header thus making llh a kind of compatibility layer - 
apps could still include the old linux/ stuff while in fact using the new abi 
headers. Nothing would get broken this way.
Once all glibc covered stuff got separated, glibc (and all other libcs for 
that matter) would probably start using it (would they?), thus removing all 
those bloody conflicts and making glibc always up to date.

Doable plan (at least in theory). The main question is - will those patches 
get gradually merged into mainline? (Is there any possibility of getting a 
yes/no answer from Linus?)
If not, the thing gets pointless, since maintaining such patches outside the 
kernel would only need additional work, give no real benefit and accumulate 
errors with time. 


-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
