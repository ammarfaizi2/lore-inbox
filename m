Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbSLMOfd>; Fri, 13 Dec 2002 09:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbSLMOfd>; Fri, 13 Dec 2002 09:35:33 -0500
Received: from mxintern.kundenserver.de ([212.227.126.204]:3782 "EHLO
	mxintern.kundenserver.de") by vger.kernel.org with ESMTP
	id <S264699AbSLMOfc>; Fri, 13 Dec 2002 09:35:32 -0500
Date: Fri, 13 Dec 2002 15:43:17 +0100
From: Anders Henke <anders.henke@sysiphus.de>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: using 2 TB  in real life
Message-ID: <20021213144317.GA21991@schlund.de>
References: <UTC200212122315.gBCNFdp22965.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200212122315.gBCNFdp22965.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.3.28i
Organization: Schlund + Partner AG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 13th 2002, Andries.Brouwer@cwi.nl wrote:
> > SCSI device sdb: -320126976 512-byte hdwr sectors (-163904 MB)
> 
> Yes, the code in 2.4.20 works up to 30 bits.
> A slight modification works up to 31 bits.

It works up to less than 30 bits - a 0.9 TB Device shows up as

SCSI device sdb: 1806745600 512-byte hdwr sectors (-174457 MB)

while a 480 GB Device (correctly) shows up this way:

SCSI device sda: 961818624 512-byte hdwr sectors (492451 MB)

At 0.5 TB (29 bits) the first problem occurs: negative size.
At 1 T (30 bits), the sector count also becomes negative.

Your patch (thank you!) does fix both problems and up to 1.9 TB,
everything works as expected:

SCSI device sdb: 3974840320 512-byte hdwr sectors (2035118 MB)

Yes, it's purely cosmetical, but should be included in the main tree.


Regards,

Anders
-- 
http://sysiphus.de
