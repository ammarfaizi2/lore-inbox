Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVGLNwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVGLNwa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 09:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVGLNwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 09:52:17 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49573 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S261168AbVGLNvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 09:51:10 -0400
Message-Id: <1121176268.15213.238283120@webmail.messagingengine.com>
X-Sasl-Enc: UDZecOGs4g4Oy4NJYcAm2kdh2zgUz3YYxJKlwy4KVx0b 1121176268
From: "Bron Gondwana" <brong@fastmail.fm>
To: "Lars Roland" <lroland@gmail.com>, "Rob Mueller" <robm@fastmail.fm>
Cc: linux-kernel@vger.kernel.org, "Jeremy Howard" <jhoward@fastmail.fm>
Content-Transfer-Encoding: 7bit
Content-Type: multipart/mixed; boundary="_----------=_1121176268152130"; charset="iso-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.5  (F2.73; T1.001; A1.64; B3.05; Q3.03)
References: <01dd01c586c3$cdd525d0$7c00a8c0@ROBMHP>
   <4ad99e05050712024319bc7ada@mail.gmail.com>
   <021801c586d7$5ebf4090$7c00a8c0@ROBMHP>
   <4ad99e05050712051341cf6e3@mail.gmail.com>
Subject: Re: 2.6.12.2 dies after 24 hours
In-Reply-To: <4ad99e05050712051341cf6e3@mail.gmail.com>
Date: Tue, 12 Jul 2005 23:51:08 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--_----------=_1121176268152130
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.5  (F2.73; T1.001; A1.64; B3.05; Q3.03)
Date: Tue, 12 Jul 2005 13:51:08 UT


On Tue, 12 Jul 2005 14:13:01 +0200, "Lars Roland" <lroland@gmail.com>
said:
> You have irq balancing, the line 
> 
> CONFIG_IRQBALANCE=y
> 
> in your config file confirms it - I am not completely sure that it is
> the root of the problem but when I experienced the problem I changed
> two things: my acpi code and irq balancing and one of then made the
> difference, I am just to lazy to check which one it is (also it is
> production servers so I cannot do whatever I want).

Our ACPI looked very similar to yours, so I've disabled IRQBALANCE.

We'll be rebooting the server during a less busy time to try the new
kernel, so not for about 12 hours or so.

> >   append="elevator=deadline"
>
> I use the same io scheduler so that should not be a problem. I have
> uploaded my config file - it works on ibm 335/336 servers, and a quick
> look at your boot msg seams to indicate that your server have some of
> the same hardware - note however that I load ide/scsi/filesystem stuff
> as modules so you will need to build a initrd to use my config.
> 
> the config is here
> 
> http://randompage.org/static/kernel.conf

Great, thanks for that.  I've had a look through and I think the
IRQBALANCE issue is the most likely cause.

We're also applying the attached patch.  There's a bug in reiserfs that
gets tickled by our huge MMAP usage (it's amazing what really busy
Cyrus daemons can do to a server, ouch).  It's fixed in generic_write,
so we take the few percent performance hit for something that doesn't
break!

Bron.
-- 
  Bron Gondwana
  brong@fastmail.fm


--_----------=_1121176268152130
Content-Disposition: attachment; filename="patch-2.6.12.2-reiserfix.bz2"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream; name="patch-2.6.12.2-reiserfix.bz2"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.5  (F2.73; T1.001; A1.64; B3.05; Q3.03)
Date: Tue, 12 Jul 2005 13:51:08 UT

QlpoOTFBWSZTWfKiO3gAAGtfgGIwQG/7XGI1BYCfrd7yMADspDU0p5qg3qho
9EbUxAD0mmgB6hgNAaAADTQaAaANAlCNEp+lP0p6TT9UYgNNAA0xPSNA4AqI
0ISE2e+S1BFEADWqDtMlzKaLikwH6qtte4jx59X679dsr4Uq+/qKiwnaWcwJ
SyBYi6AYC4KA8FVgfXAsbIqsDWF+EZuo4oODESAstlyNGYwHraeRj7M8yVgp
ussGCFkLS20g5wPKxeT7LxUIl45CcOHiJ6xCvne3ptDfIRgzNt+eagihnEeB
W/lUStAhObKMyOGXSLKPYYBDdu1URONyccQKiY2nmsrjYr9GOEsyB1apAEyg
IMZP/i7kinChIeVEdvA=

--_----------=_1121176268152130--

