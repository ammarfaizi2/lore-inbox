Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWIISf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWIISf3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 14:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWIISf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 14:35:29 -0400
Received: from anyanka.rfc1149.net ([81.56.47.149]:50682 "EHLO
	mail2.rfc1149.net") by vger.kernel.org with ESMTP id S1751364AbWIISf1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 14:35:27 -0400
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
References: <87fyf5jnkj.fsf@willow.rfc1149.net> <1157815525.6877.43.camel@localhost.localdomain> <20060909220256.d4486a4f.vsu@altlinux.ru>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Date: 09 Sep 2006 20:35:19 +0200
In-Reply-To: <20060909220256.d4486a4f.vsu@altlinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Samuel Tardieu <sam@rfc1149.net>
Organization: RFC 1149 (see http://www.rfc1149.net/)
Content-Transfer-Encoding: 8bit
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Message-Id: <2006-09-09-20-35-21+trackit+sam@rfc1149.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Sergey" == Sergey Vlasov <vsu@altlinux.ru> writes:

Sergey> Actually the situation is worse.  This driver pokes at SuperIO
Sergey> configuration registers, which are shared by all logical
Sergey> devices of the SuperIO chip.

Exactly (this is something we discussed on a French
mailing-list). However, in our case (dedibox.fr hardware), that was
not an issue because we only use single-core boards, no other parts
of the SuperIO are used at the same time and every existing code sets
the logical device number to use each time it needs to access it.

Also note that this situation exists with any Winbond SuperIO already
in the kernel, this is not specific to this one.

A SuperIO subsystem would be the cleanest solution IMO, even if at the
beginning it only provides lock/unlock functionality. Then it could be
extended as to factor common operation (selecting a logical device and
reading/writing registers) and to allow access to the device from
userland.

On an unrelated subject, the whole watchdog subsystem would benefit
from a refactoring; the code looking for a 'V' in a write() operation
is present at least 35 times.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/

