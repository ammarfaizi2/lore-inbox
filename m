Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316877AbSEVHAt>; Wed, 22 May 2002 03:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316878AbSEVHAs>; Wed, 22 May 2002 03:00:48 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:19977
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316877AbSEVHAs>; Wed, 22 May 2002 03:00:48 -0400
Date: Tue, 21 May 2002 23:59:35 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Andrew Pam <xanni@glasswings.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Initialisation bug in IDE patch
In-Reply-To: <20020522165709.K2437@kira.glasswings.com.au>
Message-ID: <Pine.LNX.4.10.10205212356360.19403-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First question for 2.2.X, in your .config is "CONFIG_BLK_DEV_QD6580" set ?
If not then ide0=qd6580 will yield "-- BAD OPTION"

Second question for 2.4.X in your .config is "CONFIG_BLK_DEV_QD65XX" set ?
If not then ide0=qd65xx will yield "-- BAD OPTION"

Please check those first.

Cheers,


On Wed, 22 May 2002, Andrew Pam wrote:

> On Tue, May 21, 2002 at 11:18:56PM -0700, Andre Hedrick wrote:
> > Now you have me puzzled........
> > If "ide_setup" which parses the passed settings calls "init_ide_data"
> > which initalizes all "hwif" groups and sets a cookie to prevent "ide_init"
> > from re-initalizing thus purging the contents place in by "ide_setup", how
> > are you getting a "BAD -- OPTION"?
> 
> Off the top of my head, it looks like ide_init_default_hwifs creates
> an uninitialised "hw_regs_t hw;" variable, fills in some fields, then
> calls "ide_register_hw(&hw, NULL);" which does "memcpy(&hwif->hw, hw,
> sizeof(*hw));" thus copying the unitialised fields (such as "chipset")
> right over the area zeroed by init_ide_data().
> 
> Am I on the right track?
> 
> Cheers,
> 	Andrew Pam
> -- 
> mailto:xanni@xanadu.net                         Andrew Pam
> http://www.xanadu.com.au/                       Chief Scientist, Xanadu
> http://www.glasswings.com.au/                   Technology Manager, Glass Wings
> http://www.sericyb.com.au/                      Manager, Serious Cybernetics
> http://two-cents-worth.com/?105347&EG		Donate two cents to our work!
> P.O. Box 477, Blackburn VIC 3130 Australia	Phone +61 401 258 915
> 

Andre Hedrick
LAD Storage Consulting Group

