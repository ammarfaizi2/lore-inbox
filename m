Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265975AbTFWKDv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 06:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265976AbTFWKDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 06:03:51 -0400
Received: from nuit.ca ([66.11.160.83]:36779 "EHLO smtp.nuit.ca")
	by vger.kernel.org with ESMTP id S265975AbTFWKDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 06:03:48 -0400
Date: Mon, 23 Jun 2003 10:17:51 +0000
To: linux-kernel@vger.kernel.org
Subject: problems patching XFS against current benh
Message-ID: <20030623101751.GD2102@nuit.ca>
Reply-To: simon@nuit.ca
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nmemrqcdn5VTmUEE"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: simon raven <simon@nuit.ca>
X-SA-Exim-Mail-From: simon@nuit.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline



--nmemrqcdn5VTmUEE
Content-Type: message/rfc822
Content-Disposition: inline

Date: Mon, 23 Jun 2003 04:54:06 +0000
To: linux-kernel-digest@lists.us.dell.com
Subject: problems patching XFS against current benh
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=iso-8859-15

In file included from /usr/src/kernel_benh/include/linux/modversions.h:166,
                 from /usr/src/kernel_benh/include/linux/module.h:21,
                 from exec_domain.c:14:
/usr/src/kernel_benh/include/linux/modules/ksyms.ver:387:1: warning: "__ver_mark_page_accessed" redefined
In file included from /usr/src/kernel_benh/include/linux/modversions.h:100,
                 from /usr/src/kernel_benh/include/linux/module.h:21,
                 from exec_domain.c:14:
/usr/src/kernel_benh/include/linux/modules/filemap.ver:7:1: warning: this is the location of the previous definition


------

i get this when i've patched current XFS patches (the new ones from today (22-06-2003)) onto benh recent rsync.

in include/linux/sysctl.h, two resources (?) want a VM_ set to 14:

1 =>        VM_HEAP_STACK_GAP=14,   /* int: page gap between heap and stack */
2 =>        VM_PAGEBUF=14,          /* struct: Control pagebuf parameters */
        VM_LAPTOP_MODE=15,
        VM_BLOCK_DUMP=16,

number 1 is from benh, and number 2 is from XFS. i need both - benh's for some drivers for my hardware, and XFS 
because most of my FSes are XFS. 

i get the same error above, even though i set VM_PAGEBUF to say 17 or 18
manually, and there's only one EXPORT_SYMBOL(mark_page_accessed) in
ksyms.h. in ksyms.ver and filemap.ver, the version symbols end up being
different (as can be seen from the above pasting). i tried twice to
change the filemap.ver number to the one that's given in ksyms.ver, and
the when the kernel image builds, it fails. 

i'm at rope's end right now, i don't know what to do. oh yeh, and i did
try on vanilla 2.4.21, and it gives me similar errors about "__ver*"
being redefined.

eric

-- 
UNIX is user friendly, it's just picky about who its friends are.          
-------------------------------------------------------------------
 ,''`.   http://www.debian.org/  | http://www.nuit.ca/           
 : :' :  Debian GNU/Linux        | http://simonraven.nuit.ca/    
 `. `'                           | PGP key ID: 6169 BE0C 0891 A038    
  `-                             | 

--nmemrqcdn5VTmUEE--
