Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSCIAes>; Fri, 8 Mar 2002 19:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292035AbSCIAej>; Fri, 8 Mar 2002 19:34:39 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:11269 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S290593AbSCIAeh>; Fri, 8 Mar 2002 19:34:37 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A76EA@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Bill Nottingham'" <notting@redhat.com>
Cc: "'linux-serial'" <linux-serial@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "'Russell King'" <rmk@arm.linux.org.uk>
Subject: RE: [PATCH] serial.c procfs kudzu - discussion
Date: Fri, 8 Mar 2002 16:34:35 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Mar 08, 2002, Ed Vance wrote:
> 
> On Fri Mar 08, 2002, Russell King wrote:
> > 
> > 2. "port:" entry being 0.  I don't think we really want to report IO
> >    port or memory addresses here without giving userspace some
> >    indication which we're reporting.
> > 
> > For 2, I'd suggest replacing "port:" with "mem:" for iomem ports, and
> > changing the serinfo: line to reflect the changed format (this is
> > probably ignored by kudzu though.)
> >
> Yes. I'll change the serinfo line rev marking from 1.0 to 1.1 and label 
> the  iomem value as "mem". If I remember correctly, kudzu detects that 
> field by its delimiters, so it does not matter that we change the field 
> label. It's probably easiest for me to verify by just trying it. If there 
> is a surprise there, I will inform Bill Nottingham at Red Hat. 

Bill,

I did not remember kudzu's parsing of the "port" field as well as I thought.

It does a string match against the first three labels, "uart", "port", and 
"irq". So, if I change the second label to "mem" for ports that are mapped 
into memory space, then it will break kudzu. In function InitSerials(), 
pointer variable "port" becomes null at pciserial.c:61 and causes strchr() 
to explode at line pciserial.c:71. (kudzu-0.99.23 from Red Hat 7.2) 

The only way we could differentiate I/O and memory addresses without 
breaking the current kudzu (that I could think of at my present caffeine 
level) would be to leave it "port" and output four hex digits for I/O 
addresses and eight digits for memory addresses. (just a bit ugly)

All,

Is this correction of information presented to the user from the driver 
worth changing kudzu? Opinions please. 

Best regards,
Ed Vance
