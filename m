Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263687AbUJ3Kvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUJ3Kvt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 06:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263683AbUJ3Kvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 06:51:49 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:33959
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S263690AbUJ3KvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 06:51:00 -0400
Subject: Re: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Chris Ross <chris@tebibyte.org>, Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Rik van Riel <riel@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
       kernel@kolivas.org
In-Reply-To: <4183649C.7070601@jp.fujitsu.com>
References: <Pine.LNX.4.44.0410251823230.21539-100000@chimarrao.boston.redhat.com>
	 <Pine.LNX.4.44.0410251833210.21539-100000@chimarrao.boston.redhat.com>
	 <20041028120650.GD5741@logos.cnet> <41824760.7010703@tebibyte.org>
	 <41834FE7.5060705@jp.fujitsu.com> <418354C0.3060207@tebibyte.org>
	 <418357C5.4070304@jp.fujitsu.com> <41835F4D.2060508@tebibyte.org>
	 <4183649C.7070601@jp.fujitsu.com>
Content-Type: text/plain
Organization: linutronix
Date: Sat, 30 Oct 2004 12:42:46 +0200
Message-Id: <1099132966.22115.89.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-30 at 18:53 +0900, Hiroyuki KAMEZAWA wrote:
> > Should I move your fix into the loop or move the declaration of area to 
> > function scope?
> > 
> Oh, Okay, my patch was wrong ;(.
> Very sorry for wrong hack.
> This one will be Okay.

It fixes at least the corrupted output of show_free_areas().
DMA: 4294966389*4kB 4294966983*8kB 4294967156*16kB .....
Normal: 4294954991*4kB 4294962949*8kB 4294965607*16kB ....

now it's
DMA: 248*4kB 63*8kB 7*16kB 1*32kB 0*64kB 0*128kB ...
Normal: 204*4kB 416*8kB 157*16kB 20*32kB 3*64kB ...

Good catch.

But it still does not fix the random madness of oom-killer. Once it is
triggered it keeps going even if there is 50MB free memory available.

tglx


