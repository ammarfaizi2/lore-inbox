Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316876AbSEVGyI>; Wed, 22 May 2002 02:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316877AbSEVGyH>; Wed, 22 May 2002 02:54:07 -0400
Received: from mail011.syd.optusnet.com.au ([210.49.20.139]:65465 "EHLO
	mail011.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S316876AbSEVGyH>; Wed, 22 May 2002 02:54:07 -0400
Date: Wed, 22 May 2002 16:57:09 +1000
From: Andrew Pam <xanni@glasswings.com.au>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initialisation bug in IDE patch
Message-ID: <20020522165709.K2437@kira.glasswings.com.au>
In-Reply-To: <20020522161144.G2437@kira.glasswings.com.au> <Pine.LNX.4.10.10205212313160.19403-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 11:18:56PM -0700, Andre Hedrick wrote:
> Now you have me puzzled........
> If "ide_setup" which parses the passed settings calls "init_ide_data"
> which initalizes all "hwif" groups and sets a cookie to prevent "ide_init"
> from re-initalizing thus purging the contents place in by "ide_setup", how
> are you getting a "BAD -- OPTION"?

Off the top of my head, it looks like ide_init_default_hwifs creates
an uninitialised "hw_regs_t hw;" variable, fills in some fields, then
calls "ide_register_hw(&hw, NULL);" which does "memcpy(&hwif->hw, hw,
sizeof(*hw));" thus copying the unitialised fields (such as "chipset")
right over the area zeroed by init_ide_data().

Am I on the right track?

Cheers,
	Andrew Pam
-- 
mailto:xanni@xanadu.net                         Andrew Pam
http://www.xanadu.com.au/                       Chief Scientist, Xanadu
http://www.glasswings.com.au/                   Technology Manager, Glass Wings
http://www.sericyb.com.au/                      Manager, Serious Cybernetics
http://two-cents-worth.com/?105347&EG		Donate two cents to our work!
P.O. Box 477, Blackburn VIC 3130 Australia	Phone +61 401 258 915
