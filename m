Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317366AbSGDICf>; Thu, 4 Jul 2002 04:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317365AbSGDICf>; Thu, 4 Jul 2002 04:02:35 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:38916 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S317367AbSGDICd>; Thu, 4 Jul 2002 04:02:33 -0400
Message-ID: <3D24019A.1434FD85@aitel.hist.no>
Date: Thu, 04 Jul 2002 10:04:42 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.24-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Ryan Anderson <ryan@michonline.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
References: <Pine.LNX.4.10.10207021746570.579-100000@mythical.michonline.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Anderson wrote:
> 
> On Tue, 2 Jul 2002, Oliver Neukum wrote:
[...]
> > Either there is a race or there isn't. Such a thing is unusable on a
> > production system.
> 
> In a single processor, no preempt kernel, there is no race.
> Turn on SMP or preempt and there is one.

Seems to me that module _replacement_ (as opposed to
unloading in order to free memory) is an easier case.

Just load the new module and initialize it.  If some
other preempted processor manages to race and activate
the old module - no problem, because the code isn't gone.

The old module may be unloaded once we know the new one
will get all future requests and the old one has 0 references.

Helge Hafting
