Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264264AbTDKFmX (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 01:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264281AbTDKFmW (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 01:42:22 -0400
Received: from modemcable169.130-200-24.mtl.mc.videotron.ca ([24.200.130.169]:44086
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264264AbTDKFmV (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 01:42:21 -0400
Date: Fri, 11 Apr 2003 01:46:47 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: davidm@hpl.hp.com
cc: "Randy.Dunlap" <rddunlap@osdl.org>, "" <alan@lxorguk.ukuu.org.uk>,
       "" <akpm@zip.com.au>, "" <linux-kernel@vger.kernel.org>
Subject: Re: proc_misc.c bug
In-Reply-To: <16022.21891.554860.506152@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.50.0304110145070.540-100000@montezuma.mastecende.com>
References: <200304102202.h3AM2YH3021747@napali.hpl.hp.com>
 <1050011057.12930.134.camel@dhcp22.swansea.linux.org.uk>
 <20030410154902.32f48f9c.rddunlap@osdl.org> <32880.4.64.197.106.1050037303.squirrel@webmail.osdl.org>
 <16022.21891.554860.506152@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Apr 2003, David Mosberger wrote:

> Wouldn't the kmalloc() likely fail in fragmented conditions?  Also,
> I'm wondering whether there is such a thing as "well-tuned" in this
> case.  For example, in the extreme case of the SGI SN2 machine, each
> CPU could in theory have up to 256 interrupt sources (OK, perhaps it's
> only 256 interrupts per 2 CPUs, but it's still a lot of interrupts to
> go around ;-).  OTOH, most ia64 machines out there have less than 256
> interrupt per _system_.  That's a large variation.

I think NR_CPUS belongs in there somewhere, this is what triggered the 
original change;

           CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7       CPU8       CPU9       CPU10       CPU11       CPU12       CPU13       CPU14       CPU15       CPU16       CPU17       CPU18       CPU19       CPU20       CPU21       CPU22       CPU23       CPU24       CPU25       CPU26       CPU27       CPU28       CPU29       CPU30       CPU31       
  0:    3652909          0          0          1          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0  local-APIC-edge  timer
  2:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          XT-PIC  cascade
  4:       2274       2134       1993       2147          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0    IO-APIC-edge  serial
  8:          0          0          1          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   IO-APIC-level  rtc
 19:       1082       1068        527       1118          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   IO-APIC-level  eth0
 37:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   IO-APIC-level  eth7
 38:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   IO-APIC-level  eth6
 39:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   IO-APIC-level  eth5
 40:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   IO-APIC-level  eth4
 41:       3558       2894       2648       3244          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   IO-APIC-level  qlogicisp
 89:          0          0          0          0          4          4          4          3          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   IO-APIC-level  qlogicisp
115:          0          0          0          0          0          0          0          0        361        366        366        347          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   IO-APIC-level  eth1
163:          0          0          0          0          0          0          0          0          0          0          0          0        383        385        385        384          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   IO-APIC-level  eth2
211:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0        375        376        374        375          0          0          0          0          0          0          0          0          0          0          0          0   IO-APIC-level  eth3
NMI:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0 
LOC:    3604478    3603640    3603819    3603799    3603663    3603641    3603627    3603601    3603603    3603583    3603563    3603542    3603588    3603567    3603546    3603526    3603416    3603394    3603374    3603352    3603601    3603578    3603557    3603536    3603707    3603686    3603665    3603644    3603430    3603410    3603388    3603368 
ERR:          0
MIS:          0

-- 
function.linuxpower.ca
