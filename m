Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTIHPg7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTIHPga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:36:30 -0400
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:60114 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S262499AbTIHPev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:34:51 -0400
From: Ingo Oeser <ingo@oeser-vu.de>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] use size_t for the broken ioctl numbers
Date: Mon, 8 Sep 2003 15:10:34 +0200
User-Agent: KMail/1.5.3
Cc: Linus Torvalds <torvalds@osdl.org>, Matthew Wilcox <willy@debian.org>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309071024010.2977-100000@home.osdl.org> <jeekysjydv.fsf@sykes.suse.de>
In-Reply-To: <jeekysjydv.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309081510.34883.ingo@oeser-vu.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 September 2003 19:34, Andreas Schwab wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> > 	({ x __dummy; sizeof(__dummy); })
> >
> > which should work with all compiler versions.
>
> This won't work with array types, eg. in <linux/random.h>:
>
> #define RNDGETPOOL	_IOR( 'R', 0x02, int [2] )

It would, if you did this 

#define RNDGETPOOL _IOR('R', 0x02, struct { int x[2];})

I would vote for simply forbidding arrays in this situation (which the compile 
error will handle as well ;-)). Just another case of "Doctor it hurts!"

Regards

Ingo Oeser


