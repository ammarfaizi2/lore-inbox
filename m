Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318220AbSHMQKo>; Tue, 13 Aug 2002 12:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318222AbSHMQKo>; Tue, 13 Aug 2002 12:10:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17292 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318220AbSHMQKn>;
	Tue, 13 Aug 2002 12:10:43 -0400
Date: Tue, 13 Aug 2002 18:14:06 +0200
From: Jens Axboe <axboe@suse.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, Erik Andersen <andersen@codepoet.org>
Subject: Re: [PATCH] cdrom sane fallback vs 2.4.20-pre1
Message-ID: <20020813161406.GC32470@suse.de>
References: <200208131413.g7DEDd502174@localhost.localdomain> <Pine.LNX.4.33L2.0208130847380.5175-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0208130847380.5175-100000@dragon.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13 2002, Randy.Dunlap wrote:
> On Tue, 13 Aug 2002, James Bottomley wrote:
> 
> | > > -             if (ret) {
> | > > +             if (ret && sense.sense_key==0x05 && sense.asc==0x20 && sense.ascq==0x00) {
> | >
> | > Do you really need to hardcode this values ?
> |
> | We have no #defines for the asc and ascq codes (they are interpreted in
> | constants.c but the values are hardcoded in there too).  There is a #define
> | for sense_key 0x05 as ILLEGAL_REQUEST in scsi/scsi.h, but these #defines have
> | annoyed a lot of people by being rather namespace polluting.
> 
> and that's precisely the wrong attitude IMO.
> 
> I was glad to see that Marcelo asked about the hardcoded values.
> They hurt.

I usually find it a hell of a lot easier remembering that 5/20/00 is
illegal opcode, 5/24/00 is illegal field, etc. There are just too many
of these to be named sanely. sense_key can be done, agreed, but asc and
ascq just gets silly imo, and it makes it harder to read for those that
know the codes. Encouraging others to look up the values (it's not hard,
you can see it's asc and ascq and it relates to sense info) does
definitely not hurt, they might pick up something else along the way.

-- 
Jens Axboe

