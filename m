Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317551AbSGPFnb>; Tue, 16 Jul 2002 01:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317757AbSGPFna>; Tue, 16 Jul 2002 01:43:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40458 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317551AbSGPFna>; Tue, 16 Jul 2002 01:43:30 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: IDE/ATAPI in 2.5
Date: 15 Jul 2002 22:46:17 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ah0bv9$ldv$1@cesium.transmeta.com>
References: <200207121955.g6CJtQur018433@burner.fokus.gmd.de> <20020713054058.GA19292@codepoet.org> <20020713125346.B10051@zalem.puupuu.org> <20020714003425.GC29007@codepoet.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020714003425.GC29007@codepoet.org>
By author:    Erik Andersen <andersen@codepoet.org>
In newsgroup: linux.dev.kernel
>   
> Of course making user space do this is pretty lame.  But we
> have a much better way.  Each cdrom device registers with the
> uniform cdrom driver, which can easily assign each registered
> cdrom device a major and minor.  That scanning for cdroms would
> be as simple as
>     for i in /dev/cdrom* ; do
> 	open ($i, O_RDONLY|O_NONBLOCK)) < 0) {
> 	    /* Found a cdrom drive */
> 	}
>     

Yes, something like that would be nice.

However, the case still remains that I think Linus' proposed overall
packet infrastructure is the right thing to do.  That way a uniform
API would be available for poking at any device that supports MMC (is
that the correct term these days?) commands, regardless of the type
of device and the lower-level transports.

People have -- correctly -- corrected me on the "ATAPI = SCSI over
IDE" issue.  When I think of SCSI, I tend to think of what a network
engineer would call "the upper data link layer", i.e. the command
packet frame format.  I did not mean to imply that the physical
interface (PHY), or the lower data link layer (MAC) where the same.  I
also realize that there are differences, but *from what I've seen*
they seem to be relatively minor.

I meant to start a discussion, not "call a vote", especially not
w.r.t. the lower-level implementation details.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
