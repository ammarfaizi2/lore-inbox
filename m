Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbWH0RpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbWH0RpH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 13:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWH0RpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 13:45:07 -0400
Received: from main.gmane.org ([80.91.229.2]:54966 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932193AbWH0RpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 13:45:05 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Peter" <sw98234@hotmail.com>
Subject: RESOLVED: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Date: Sun, 27 Aug 2006 17:44:36 +0000 (UTC)
Message-ID: <ecslm4$ki8$1@sea.gmane.org>
References: <ecpru4$9t3$1@sea.gmane.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pool-151-204-7-242.pskn.east.verizon.net
X-Archive: encrypt
User-Agent: pan 0.109 (Beable)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am guessing that a recent update with kernel patches for
iosched-rollup-2.6.17.4-2.patch appears to have removed the problems
described here. With this and others installed, even with CONFIG_PREEMPT=y
there are no more io problems being recorded with or without vmware mods.
For some reason, these patches are not in the vanilla 2.6.17.11 sources.

The particular kernel series I used for test were:

2.6.17.11 - problem persisted
2.6.17-beyond3.1pre1 - problem persisted
2.6.17-beyond4pre1 - problem solved ( for half a day anyway :) )

http://iphitus.loudas.com/beyond/2.6.17/2.6.17-beyond4pre1/

compare dmesg output at point of error:

Failure:
/dev/vmnet: open called by PID 9443 (vmware-vmx) 
eth0: Promiscuous mode enabled.
device eth0 entered promiscuous mode
bridge-eth0: enabled promiscuous mode 
/dev/vmnet: port on hub 0 successfully opened 
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error } 
hda: dma_intr: error=0x84 { DriveStatusError BadCRC } 
ide: failed opcode was: unknown

NOW:
/dev/vmnet: open called by PID 11758 (vmware-vmx)
eth0: Promiscuous mode enabled.
device eth0 entered promiscuous mode
bridge-eth0: enabled promiscuous mode
/dev/vmnet: port on hub 0 successfully opened
( *** note, error occured here *** )
/dev/vmmon[11758]: host clock rate change request 83 -> 19
device eth0 left promiscuous mode
bridge-eth0: disabled promiscuous mode
/dev/vmmon[11752]: host clock rate change request 19 -> 0


This sequence occured several places, and no times were errors
reported.

HTH

So, for me, for now, this issue is resolved...
-- 
Peter
+++++
Do not reply to this email, it is a spam trap and not monitored.
I can be reached via this list, or via 
jabber: pete4abw at jabber.org
ICQ: 73676357

