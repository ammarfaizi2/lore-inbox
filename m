Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbTBCVJR>; Mon, 3 Feb 2003 16:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264683AbTBCVJR>; Mon, 3 Feb 2003 16:09:17 -0500
Received: from ool-4351594a.dyn.optonline.net ([67.81.89.74]:28676 "EHLO
	badula.org") by vger.kernel.org with ESMTP id <S263291AbTBCVJQ>;
	Mon, 3 Feb 2003 16:09:16 -0500
Date: Mon, 3 Feb 2003 16:18:41 -0500
Message-Id: <200302032118.h13LIfqN006832@buggy.badula.org>
From: Ion Badulescu <ionut@badula.org>
To: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: NETIF_F_SG question
In-Reply-To: <001501c2ca5b$f4b45990$020120b0@jockeXP>
User-Agent: tin/1.5.12-20020427 ("Sugar") (UNIX) (Linux/2.4.20 (i586))
X-Spam-Flag: NO
X-Spam-Score: -0.8, 7 required, IN_REP_TO,SIGNATURE_SHORT_DENSE,SPAM_PHRASE_02_03,USER_AGENT
X-Spam-Report: ---- Start SpamAssassin results
 
	-0.80 hits, 7 required;
 
	* -0.8 -- Found a In-Reply-To header
 
	* -0.5 -- Found a User-Agent header
 
	*  0.8 -- BODY: Spam phrases score is 02 to 03 (medium)
 
	          [score: 2]
 
	* -0.3 -- Short signature present (no empty lines)
 
	---- End of SpamAssassin results
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Feb 2003 02:39:41 +0100, Joakim Tjernlund <Joakim.Tjernlund@lumentis.se> wrote:
> 
> I think HW checksumming and SG are independent. Either one of them should
> not require the other one in any context.

They should be independent in general, but they aren't when the particular
case of TCP/IPv4 is concerned.

> Zero copy sendfile() does not require HW checksum to do zero copy, right?

Wrong...

> If HW checksum is present, then you get some extra performance as a bonus.

You get zerocopy, yes. :-) No HW cksum, no zerocopy.

Don't let this stop you, however. It's always possible that other networking
stacks will eventually make use of SG while not requiring HW TCP/UDP cksums.
None of them do right now, but...

> (hmm, one could make SG mandatory and the devices that don't support it can 
> implement it in their driver. Just an idea)

Not really, that way lies driver madness. The less complexity in the driver,
the better.

Ion
[starfire driver maintainer]

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
