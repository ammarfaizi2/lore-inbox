Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbUJZMl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbUJZMl3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 08:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbUJZMl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 08:41:29 -0400
Received: from 66-61-147-78.dialroam.rr.com ([66.61.147.78]:47375 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S262241AbUJZMlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 08:41:23 -0400
Date: Tue, 26 Oct 2004 08:36:51 -0400
From: jfannin1@columbus.rr.com
To: Christophe Saout <christophe@saout.de>
Cc: Mathieu Segaud <matt@minas-morgul.org>, linux-kernel@vger.kernel.org,
       Alasdair G Kergon <agk@redhat.com>
Subject: Re: 2.6.9-mm1: LVM stopped working
Message-ID: <20041026123651.GA2987@zion.rivenstone.net>
Mail-Followup-To: Christophe Saout <christophe@saout.de>,
	Mathieu Segaud <matt@minas-morgul.org>, linux-kernel@vger.kernel.org,
	Alasdair G Kergon <agk@redhat.com>
References: <87oeitdogw.fsf@barad-dur.crans.org> <1098731002.14877.3.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098731002.14877.3.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 09:03:22PM +0200, Christophe Saout wrote:
> Am Sonntag, den 24.10.2004, 01:06 +0200 schrieb Mathieu Segaud:
> 
>>Well, I gave a try to last -mm tree. The bot seemed good till it got to
>>LVM stuff. Vgchange does not find any volume groups. I can't say much because
>>lvm is pretty "early stuff" on this box; so it is pretty unusable.

    LVM doesn't work with 2.6.9-mm1 here either, complaining that it
can't find all the pv's. I'm not using any sort of encryption. Here,
pvdisplay reports:

  --- Physical volume ---
  PV Name               /dev/hda2
  VG Name               home
  PV Size               24.52 GB / not usable 0   
  Allocatable           yes (but full)
  PE Size (KByte)       4096
  Total PE              6277
  Free PE               0
  Allocated PE          6277
  PV UUID               M8tcls-7Tp7-sAYe-ypH3-if50-00JH-hvvXSL
   
  --- Physical volume ---
  PV Name               unknown device
  VG Name               home
  PV Size               70.47 GB / not usable 0   
  Allocatable           yes (but full)
  PE Size (KByte)       4096
  Total PE              18040
  Free PE               0
  Allocated PE          18040
  PV UUID               SmreB9-Q3dp-DBBc-q0N9-v762-o6UB-1VUgYw
   
  --- Physical volume ---
  PV Name               unknown device
  VG Name               home
  PV Size               25.12 GB / not usable 0   
  Allocatable           yes (but full)
  PE Size (KByte)       4096
  Total PE              6431
  Free PE               0
  Allocated PE          6431
  PV UUID               sbbFSh-0MP8-jtir-Jcyx-VtcE-TxNh-tfNwNe

    I can open the device nodes for the 'missing' pv's in a hexeditor and see the
uuid magic; if I reboot into 2.6.9-rc4-mm1 they are found without a
problem, and everything works.

    Whether or not I'll have time to try to narrow down the change
that causes this depends on things that are out of my control ATM. :-/

-- 
Joseph Fannin
jfannin1@columbus.rr.com
