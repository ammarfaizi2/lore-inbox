Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUHQL76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUHQL76 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 07:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268184AbUHQL76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 07:59:58 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:4742 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S266362AbUHQL7y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 07:59:54 -0400
To: Christer Weinigel <christer@weinigel.se>
Cc: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>,
       Marc Ballarin <Ballarin.Marc@gmx.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, jwendel10@comcast.net,
       linux-kernel@vger.kernel.org, Kai.Makisara@kolumbus.fi
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
References: <411FD919.9030702@comcast.net>
	<20040816143817.0de30197.Ballarin.Marc@gmx.de>
	<1092661385.20528.25.camel@localhost.localdomain>
	<20040816231211.76360eaa.Ballarin.Marc@gmx.de>
	<4121A689.8030708@bio.ifi.lmu.de> <m37jry57fa.fsf@zoo.weinigel.se>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 17 Aug 2004 13:59:53 +0200
In-Reply-To: <m37jry57fa.fsf@zoo.weinigel.se>
Message-ID: <m3y8ke3rgm.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following up to myself...

Christer Weinigel <christer@weinigel.se> writes:

> Some commands are a bit questionable though, for example, should it be
> possible to use GPCMD_PREVENT_ALLOW_MEDIUM_REMOVAL with only read
> permissions?  
> 
> The MODE_SELECT command I belive is needed for read on some tape
> drives because tape parameters such as compression and tape density
> are configured this way.  But there might be a device where a
> MODE_SELECT on a vendor configuration page might destroy the device,
> so it might not be such a good idea to allow MODE_SELECT and in that
> case I don't know how it should be handled.

I just did a quick google search on "MODE SELECT" and "vendor" and
found the following documentation for an IBM DeskStar driver:

    http://www.embeddedlogic.com/TH99/h/txt/1478.txt

    Page 0
    Vendor Unique Parameters
    UQE - Untagged Queuing Enable (1)
    DWD - Disable Write Disconnect (0)
    UAI - Unit Attention Inhibit (0)
    CPE - Concurrent Processing Enable (1)
    TCC - Thermal Compensation (0)
    DSN Disable Target Initiated Synchronous Negotiation (0)
    FRDD Format Degraded (1)
    DRD - Disable Read Disconnect (1)

Allowing a user who is only supposed to have write access to a raw
partition to disable read or write disconnect does not seem like such
a hot idea, so MODE SELECT should probably be disallowed unless
someone writes a verify function that looks for safe bits in the
page.  

This could get a bit painful.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
