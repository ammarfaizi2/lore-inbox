Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWA3KjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWA3KjR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 05:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWA3KjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 05:39:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36036 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932208AbWA3KjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 05:39:16 -0500
Subject: Re: [PATCH 2.6.16-rc1-git4] accessfs: a permission managing
	filesystem
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>, olaf+list.linux-kernel@olafdietsche.de,
       eike-kernel@sf-tec.de, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0601301135540.12495@yvahk01.tjqt.qr>
References: <87ek3a8qpy.fsf@goat.bogus.local>
	 <200601231257.28796@bilbo.math.uni-mannheim.de>
	 <87mzhgyomh.fsf@goat.bogus.local> <20060128150137.5ba5af04.akpm@osdl.org>
	 <Pine.LNX.4.61.0601301006240.6405@yvahk01.tjqt.qr>
	 <20060130011630.60f402d8.akpm@osdl.org>
	 <Pine.LNX.4.61.0601301024150.6405@yvahk01.tjqt.qr>
	 <1138614388.2977.10.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0601301050260.6405@yvahk01.tjqt.qr>
	 <1138614856.2977.16.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0601301114160.25336@yvahk01.tjqt.qr>
	 <1138617073.2977.21.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0601301135540.12495@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 11:39:10 +0100
Message-Id: <1138617550.2977.24.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-30 at 11:36 +0100, Jan Engelhardt wrote:
> >
> >well... maybe.
> >If you need to mess inside irq context, spinlocks sound more the right
> >thing. Or if you need to do a "I'm done" in the irq and a "sleep until
> >done" thing in process context, then you really should use completions
> >instead.
> 
> Hm, is it allowed to call copy_{from,to}_user() in irq context?

absolutely not.

IRQ context has no defined "userspace" context at all, so even if
copy_from/to_user wouldn't sleep (they do, and that alone makes it
"illegal" to do already) it would be highly undefined what you would be
copying to/from.



