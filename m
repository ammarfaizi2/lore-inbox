Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289328AbSBXOS6>; Sun, 24 Feb 2002 09:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289372AbSBXOSt>; Sun, 24 Feb 2002 09:18:49 -0500
Received: from postfix1-2.free.fr ([213.228.0.130]:62914 "EHLO
	postfix1-2.free.fr") by vger.kernel.org with ESMTP
	id <S289328AbSBXOSp>; Sun, 24 Feb 2002 09:18:45 -0500
Date: Sun, 24 Feb 2002 15:45:23 +0100
To: linux-kernel@vger.kernel.org
Subject: PPA init lockup under 2.2.20 SMP
Message-ID: <20020224144523.GA30245@bylbo.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: Yann Dirson <ydirson@altern.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I experienced a reproducible lockup while loading the PPA (IOmega ZIP
on parport) on 2.2.19 and 2.2.20, on a bi-pIII machine.  It seems OK
with SMP in 2.4.17, and works fine with UP in 2.2.x.

I narrowed the problem to the case where:

- parport_pc gets loaded on request of ppa
- it is the initial insmod of ppa

That is, it works fine when:

- either parport_pc is insmod'd manually first
- either ppa has been successfully loaded previously (using manual
insmod of parport_pc).  Then even if parport_pc has been unloaded,
"modprobe ppa" loads everything OK.

-- 
Yann Dirson    <ydirson@altern.org> |    Why make M$-Bill richer & richer ?
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
Pro:    <yann.dirson@fr.alcove.com> |  Freedom, Power, Stability, Gratuity
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
