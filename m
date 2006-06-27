Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWF0TRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWF0TRm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbWF0TRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:17:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44946 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932542AbWF0TRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:17:40 -0400
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on
	i386
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@redhat.com>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0606272104500.7853@yvahk01.tjqt.qr>
References: <20060626151012.GR23314@stusta.de>
	 <20060626153834.GA18599@redhat.com>
	 <1151336815.3185.61.camel@laptopd505.fenrus.org>
	 <20060626155439.GB18599@redhat.com>
	 <Pine.LNX.4.61.0606271626470.10810@yvahk01.tjqt.qr>
	 <1151421452.32186.19.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0606272104500.7853@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 21:17:21 +0200
Message-Id: <1151435841.5217.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 21:09 +0200, Jan Engelhardt wrote:
> >> > > cli/sti should just be removed, or at least have those drivers marked
> >> > > BROKEN... nobody is apparently using them anyway...
> >> >
> >> >Just ISDN really.
> >> >
> >> And ISDN is widespread in Germany (besides 56k and DSL(PPPOE)).
> >
> >Then there should be lots of Germans eager to fix it when it gets dealt
> >with.
> >
> 
> /* Heh, heh */
> 
> So what do I need to replace cli/sti with?

proper spinlocks ;)

cli/sti assumed to disable interrupts on all processors, and so when an
old driver uses cli/sti it's sort of a lock against any interrupt
handler (yes this is locking code not data!). In general you need to
find out what data the author wanted to protect, and just create proper
locking for that data.  

yes this is not a mechanical transformation.. if it was it would have
been done already :)


