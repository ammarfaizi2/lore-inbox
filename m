Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271739AbTG3E3e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 00:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272712AbTG3E3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 00:29:34 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:19896 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S271739AbTG3E3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 00:29:33 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Date: Wed, 30 Jul 2003 14:29:23 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16167.18851.734177.14074@gargle.gargle.HOWL>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS Server running 2.6.0-test2
In-Reply-To: message from Robert L. Harris on Tuesday July 29
References: <20030729110716.GC786@rdlg.net>
	<16166.25350.70923.742360@gargle.gargle.HOWL>
	<20030729130924.GE786@rdlg.net>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday July 29, Robert.L.Harris@rdlg.net wrote:
> 
> 
> The messages file is completely empty of any error messages related to
> anything disk or filesystem related from about 6 hours prior to the
> error up until the time I rebooted.  In addition the actual device
> (RAID5 filesystem) is intact.
> 

Well, it looks quite unplesant then.
That error message can only get printed if the JFS_ABORT flag is set
for the ext3 journal, and whenever JFS_ABORT is set, the message:
   Aborting journal on device ...
comes first.  If you don't have that message, then the impossible has
happened.

The impossible is usually caused either by bad memory (and a
single-bit-error in memory could have caused this probem), or by some
stray pointer corrupting something.

So, I would suggest memtest86 if that is convenient, followed by
reporting the problem to the ext3 developers (see the MAINAINERS
file). 

This problem is unlikely to be related to the machine being an NFS
server, though until we know the cause, nothing should be ruled out.

NeilBrown
