Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293226AbSCJUhg>; Sun, 10 Mar 2002 15:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293229AbSCJUhZ>; Sun, 10 Mar 2002 15:37:25 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:28168 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S293226AbSCJUhI>; Sun, 10 Mar 2002 15:37:08 -0500
Date: Sun, 10 Mar 2002 21:37:06 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: linux-kernel@vger.kernel.org
Cc: Danek Duvall <duvall@emufarm.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: root-owned /proc/pid files for threaded apps?
Message-ID: <20020310213706.A673@devcon.net>
Mail-Followup-To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
	linux-kernel@vger.kernel.org, Danek Duvall <duvall@emufarm.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20020307060110.GA303@lorien.emufarm.org> <E16iyBW-0002HP-00@the-village.bc.nu> <20020308100632.GA192@lorien.emufarm.org> <20020308195939.A6295@devcon.net> <20020308203157.GA457@lorien.emufarm.org> <20020308222942.A7163@devcon.net> <20020308214148.GA750@lorien.emufarm.org> <20020308233001.B7163@devcon.net> <20020309030937.GA244@lorien.emufarm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020309030937.GA244@lorien.emufarm.org>; from duvall@emufarm.org on Fri, Mar 08, 2002 at 07:09:37PM -0800
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 07:09:37PM -0800, Danek Duvall wrote:

> Ok, after trying all four combinations (call to wmb() moved or not, and
> set_user(0, 1) vs set_user(0, 0)), it turns out all four exhibit
> skipping, so that's unrelated (in fact, it seems to happen not on net
> access, but on redraw -- mozilla's dialogs make xmms skip, too).

OK, so it's clearly unrelated.

> I'll leave it for someone else to decide what arguments to set_user()
> exec_usermodehelper() should pass.

Clearing dumpable at this point is obviously wrong as it always has
side-effects on the process that was leading into the module request.

It's also unnecessary, as it /only/ has effect on the /old/ mm_struct,
before doing the execve() of the usermode helper. As request_module
and friends don't introduce sensitive data into the address space of
the calling process, leaving dumpable alone is just fine.

So, IMO, set_user(0, 0) should be the way to go.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
