Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270651AbTHPMyC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 08:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270811AbTHPMyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 08:54:02 -0400
Received: from maja.beep.pl ([195.245.198.10]:5637 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S270651AbTHPMyA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 08:54:00 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Martin Schlemmer <azarah@gentoo.org>, gene.heskett@verizon.net
Subject: Re: increased verbosity in dmesg
Date: Sat, 16 Aug 2003 14:51:44 +0200
User-Agent: KMail/1.5.3
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200308160438.59489.gene.heskett@verizon.net> <1061030883.13257.253.camel@workshop.saharacpt.lan>
In-Reply-To: <1061030883.13257.253.camel@workshop.saharacpt.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308161451.44398.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is there any quick and dirty way to increase this to at least 32k, or
> > maybe even to 64k?  With half a gig of memory, this shouldn't be a
> > problem should it?
>
>  # dmesg -s 30000
Hmm, that would mean that bufer in kernel is different than 16kb which is not 
true on UP x86 machines:

if defined(CONFIG_MULTIQUAD) || defined(CONFIG_IA64)
#define LOG_BUF_LEN     (65536)
#elif defined(CONFIG_ARCH_S390)
#define LOG_BUF_LEN     (131072)
#elif defined(CONFIG_SMP)
#define LOG_BUF_LEN     (32768)
#else
#define LOG_BUF_LEN     (16384)                 /* This must be a power of two 
*/
#endif

USB messages are filling whole buffer for me on my UP x86 machine so I don't 
see any messages before usb after fresh boot :(

Maybe this value should be increased in kernel to 32768 on UP, too?

> Works here.

-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm@sse.pl   AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux

