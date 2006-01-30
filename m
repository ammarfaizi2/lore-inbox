Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWA3KbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWA3KbT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 05:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWA3KbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 05:31:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27776 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932200AbWA3KbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 05:31:18 -0500
Subject: Re: [PATCH 2.6.16-rc1-git4] accessfs: a permission managing
	filesystem
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>, olaf+list.linux-kernel@olafdietsche.de,
       eike-kernel@sf-tec.de, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0601301114160.25336@yvahk01.tjqt.qr>
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
Content-Type: text/plain
Date: Mon, 30 Jan 2006 11:31:12 +0100
Message-Id: <1138617073.2977.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-30 at 11:25 +0100, Jan Engelhardt wrote:
> >> You can't do that.
> >
> >Exactly why not? Assuming there are zero users left in the kernel.....
> >(which highly obviously is a prerequisite for even thinking about such a
> >step)
> 
>    Documentation/mutex-design.txt:
>    * - mutexes may not be used in irq contexts
> 
> I need some locking strategy within irq contexts, and that suggests 
> semaphores do the job.

well... maybe.
If you need to mess inside irq context, spinlocks sound more the right
thing. Or if you need to do a "I'm done" in the irq and a "sleep until
done" thing in process context, then you really should use completions
instead.


