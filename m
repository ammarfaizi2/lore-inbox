Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286325AbRLJRgh>; Mon, 10 Dec 2001 12:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286328AbRLJRg2>; Mon, 10 Dec 2001 12:36:28 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:26635 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S286325AbRLJRgL>;
	Mon, 10 Dec 2001 12:36:11 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Gregoire Favre <greg@ulima.unil.ch>
Date: Mon, 10 Dec 2001 18:35:24 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Unable to handle kernel NULL pointer dereference at vir
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <B9C25472515@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Dec 01 at 16:45, Gregoire Favre wrote:
> 
> I try to use VMWARE 3.0 under 2.4.16 and had problems, so I try under
> 2.4.17-pre7, with same results:
> 
> ble to handle kernel NULL pointer dereference at virtual address 00000004
>  printing eip:
> Process vmnet-dhcpd (pid: 3209, stackpage=ce951000)
> Stack: d6275ca0 cf7cd7e0 d9106be2 cf7cd7e0 d6275d24 ce951f50 00000000 d91053d6 

Known problem. Your kernel was compiled with different gcc than your
modules were. VMware 3.0 tries 'kgcc', 'egcs' and 'gcc' in this order
of preferrence - so you should do 'CC=gcc vmware-config.pl' if you
have kgcc/egcs installed and you compiled kernel yourself. Verify
that 'cat /proc/version' and 
'objdump -s -j .comment /lib/modules/`uname -r`/misc/vmmon.o' both
report same gcc version.
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
