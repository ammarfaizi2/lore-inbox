Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUHDMvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUHDMvH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 08:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUHDMvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 08:51:07 -0400
Received: from main.gmane.org ([80.91.224.249]:16358 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264702AbUHDMuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 08:50:35 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Juergen Stuber <juergen@jstuber.net>
Subject: Re: Linux 2.6.8-rc3
Date: Wed, 04 Aug 2004 14:44:06 +0200
Message-ID: <86r7qn9ip5.fsf@jstuber.net>
References: <Pine.LNX.4.58.0408031505470.24588@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dsl-082-083-103-196.arcor-ip.net
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/20.7 (gnu/linux)
Cancel-Lock: sha1:hXukiMc0LTrKgzilNf5mIgROQt4=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:
>[...]
>   o depends on PCI DMA API: Cisco/Aironet 34X/35X/4500/4800

I guess it is this change that made the Airo driver disappear for me,
because I didn't have ISA configured:

--- linux-2.6.8-rc2/drivers/net/wireless/Kconfig        2004-07-18 06:57:48.000000000 +0200
+++ linux-2.6.8-rc3/drivers/net/wireless/Kconfig        2004-08-03 23:27:14.000000000 +0200
@@ -139,7 +139,7 @@
 
 config AIRO
        tristate "Cisco/Aironet 34X/35X/4500/4800 ISA and PCI cards"
-       depends on NET_RADIO && (ISA || PCI)
+       depends on NET_RADIO && ISA && (PCI || BROKEN)
        ---help---
          This is the standard Linux driver to support Cisco/Aironet ISA and
          PCI 802.11 wireless cards.


If I understand it correctly the logic is faulty and should better be

       depends on NET_RADIO && ((ISA && BROKEN) || PCI)


Jürgen

-- 
Jürgen Stuber <juergen@jstuber.net>
http://www.jstuber.net/
gnupg key fingerprint = 2767 CA3C 5680 58BA 9A91  23D9 BED6 9A7A AF9E 68B4

