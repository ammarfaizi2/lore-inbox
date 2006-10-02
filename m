Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932692AbWJBGuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbWJBGuP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 02:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWJBGuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 02:50:15 -0400
Received: from smtpout.mac.com ([17.250.248.178]:31722 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932692AbWJBGuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 02:50:13 -0400
In-Reply-To: <200610012324.48289.gene.heskett@verizon.net>
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com> <4517CB2C.7020807@aitel.hist.no> <62b0912f0610011940n1e2f2748k87eaa430a75113d7@mail.gmail.com> <200610012324.48289.gene.heskett@verizon.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9706B96D-5499-4879-8209-B6BA64E5DAE6@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: ext3 corruption
Date: Mon, 2 Oct 2006 02:50:05 -0400
To: Gene Heskett <gene.heskett@verizon.net>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 01, 2006, at 23:24:48, Gene Heskett wrote:
> On Sunday 01 October 2006 22:40, Molle Bestefich wrote:
>> To reiterate:
>> The distro halt script tries "umount -f" three times, which all  
>> fail with
>> "Device or resource busy".
>
> Me too.
> I'm getting those messages from the NFS stuff at shutdown time,  
> with NO NFS
> shares active.  I have had them for years.  But the reboot goes on
> eventually, and apparently without harm.

What causes problems on _all_ of my softraid boxes is that without a  
whole bunch of pivot_root magic in the shutdown code to switch to a  
tmpfs and unmount my lvm-on-md-on-sata stuff, it's impossible to get  
the kernel to stop devices cleanly.  I get all sorts of messages from  
the kernel about trying to stop MD devices and not being able to  
_after_ reboot is called, even though at that point it should just  
forcibly kill all userspace, unmount all filesystems, and deconstruct  
the MD/DM device tree.  I see no reason why a successful shutdown or  
reboot call should _ever_ leave the disks in an inconsistent state.

Cheers,
Kyle Moffett

