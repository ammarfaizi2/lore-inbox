Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVAOMLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVAOMLw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 07:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVAOMLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 07:11:52 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:29066 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S262264AbVAOMLq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 07:11:46 -0500
Date: Sat, 15 Jan 2005 12:10:39 +0000 (UTC)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@sheen.jakma.org
To: =?iso-8859-4?B?SvxyaSBQ9WxkcmU=?= <jyri.poldre@artecdesign.ee>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Amir Guindehi <amir@datacore.ch>
Subject: Re: Ethernet driver link state propagation to ip stack
In-Reply-To: <JJEGJLLALGANNBPNAIMMOEGLDGAA.jyri.poldre@artecdesign.ee>
Message-ID: <Pine.LNX.4.61.0501150507000.15839@sheen.jakma.org>
References: <JJEGJLLALGANNBPNAIMMOEGLDGAA.jyri.poldre@artecdesign.ee>
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="299119927-2027633500-1105765907=:15839"
Content-ID: <Pine.LNX.4.61.0501151159040.31242@sheen.jakma.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--299119927-2027633500-1105765907=:15839
Content-Type: TEXT/PLAIN; CHARSET=utf-8; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.61.0501151159041.31242@sheen.jakma.org>

On Fri, 14 Jan 2005, [iso-8859-4] Jüri Põldre wrote:

> My question is:  Does the kernel handle the interface state/routing 
> tables modifications due to link changing automatically

Not completely.

The biggest problem is that kernel does not remove its "connected" or 
"subnet" route while link is down. This means that even though kernel 
knows link is down, it will still try route packets out that 
interface.

> or is there some external daemon required to do that. Any links are 
> greatly appreciated.

There is "Netplug" - part of the net-tools package (On fedora core 3 
at least). You can use it to 'ip link set dev .... down' when carrier 
is removed. However, you wont get notified of carrier being inserted 
back - I dont know whether that holds true generally, or whether its 
an e1000 bug. So it's one-shot.

We're looking at adding support to the 'zebra' daemon in Quagga to 
remove connected routes while link is down and add them back when 
link-up again, and hence deal with this properly. Amir is very 
interested in this..

/me grumbles about why oh why the "make kernel add connected routes"
   feature was *ever* added in 2.3 in the first place (cause now
   userspace has "forgotten" how to manage them, so we cant simply undo
   this brain-damage[1] without breaking networking for everyone, sigh)

1. In retrospect at least. Brain-damage really only becomes obvious 
with carrier-sensing drivers, which were very rare back in 2.2 days, 
dont think there was a unified way to report these events to 
userspace either.

> Sincerely,
> Jyri Põldre.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Sailors in ships, sail on!  Even while we died, others rode out the storm.
--299119927-2027633500-1105765907=:15839--
