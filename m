Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932786AbWJGTdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932786AbWJGTdi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 15:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932788AbWJGTdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 15:33:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57580 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932786AbWJGTdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 15:33:37 -0400
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot
	handle IRQ -1"
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Muli Ben-Yehuda <muli@il.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0610071154510.3952@g5.osdl.org>
References: <20061005212216.GA10912@rhun.haifa.ibm.com>
	 <m11wpl328i.fsf@ebiederm.dsl.xmission.com>
	 <20061006155021.GE14186@rhun.haifa.ibm.com>
	 <m1d5951gm7.fsf@ebiederm.dsl.xmission.com>
	 <20061006202324.GJ14186@rhun.haifa.ibm.com>
	 <m1y7rtxb7z.fsf@ebiederm.dsl.xmission.com>
	 <20061007080315.GM14186@rhun.haifa.ibm.com>
	 <m14pugxe47.fsf@ebiederm.dsl.xmission.com>
	 <Pine.LNX.4.64.0610071154510.3952@g5.osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 07 Oct 2006 21:33:05 +0200
Message-Id: <1160249585.3000.159.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is one of those age-old questions: in _theory_ you can do a better 
> job in software, but in _practice_ it's just too damn expensive and 
> complicated to do a perfect job especially with dynamic decisions, so in 
> _practice_ it tends to be better to let hardware make some of the 
> decisions.

it seems the right mix at this time is to have the software select the
package, and the hardware pick the core within the package. 

Or rather, the software picks which cache domain (and I only count the
largest cache, not L1) and the hardware then has the freedom to do the
right thing inside that. Binding interrupts to a cache domain seems to
be still the right strategy (at least for frequent interrupts like
networking), but to do that right more higher level info is needed than
that the hw has in general. Within the package... it's the opposite
ballgame.



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

