Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275517AbRJBPtO>; Tue, 2 Oct 2001 11:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275389AbRJBPs5>; Tue, 2 Oct 2001 11:48:57 -0400
Received: from gap.cco.caltech.edu ([131.215.139.43]:5825 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S275529AbRJBPsd>; Tue, 2 Oct 2001 11:48:33 -0400
Date: Tue, 2 Oct 2001 10:23:06 -0500
From: Tommy Reynolds <reynolds@redhat.com>
To: "Dinesh  Gandhewar" <dinesh_gandhewar@rediffmail.com>
Cc: mlist-linux-kernel@nntp-server.caltech.edu
Subject: Re:
Message-Id: <20011002102306.49730a0b.reynolds@redhat.com>
In-Reply-To: <20011002152945.15180.qmail@mailweb16.rediffmail.com>
In-Reply-To: <20011002152945.15180.qmail@mailweb16.rediffmail.com>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.6.2cvs9 (GTK+ 1.2.9; )
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
X-Message-Flag: Outlook Virus Warning: Reboot within 12 seconds or risk loss of all files and data!
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dinesh  Gandhewar" <dinesh_gandhewar@rediffmail.com> was pleased to say:

> I have written a linux kernel module. The linux version is 2.2.14. 
> In this module I have declared an array of size 2048. If I use this array, the
> execution of this module function causes kernel to reboot. If I kmalloc() this
> array then execution of this module function doesnot cause any problem.
> Can you explain this behaviour?

Unlike userland application programming, the kernel stack does not grow: it has
a fixed size.  You are using too much stack space and corrupting your system.
The kernel stack is quite small (less than 8K is available for ALL nested
modules and interrupt handlers), so driver functions should use an absolute
minimum of local variables, such as a pointer to a per-instance data area. 
Kernel-leval kmalloc() is efficient enough to use frequently.

---------------------------------------------+-----------------------------
Tommy Reynolds                               | mailto:	<reynolds@redhat.com>
Red Hat, Inc., Embedded Development Services | Phone:  +1.256.704.9286
307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX:    +1.236.837.3839
Senior Software Developer                    | Mobile: +1.919.641.2923
