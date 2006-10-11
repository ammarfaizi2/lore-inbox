Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbWJKMCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWJKMCd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 08:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWJKMCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 08:02:32 -0400
Received: from mail.actcom.co.il ([192.114.47.66]:8839 "EHLO
	smtp4.actcom.co.il") by vger.kernel.org with ESMTP id S1030390AbWJKMCc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 08:02:32 -0400
Message-ID: <047b01c6ed2d$1e810140$c500a8c0@Chavalaptop>
From: "Chava Leviatan" <chavale@actcom.net.il>
To: <linux-kernel@vger.kernel.org>
Subject: kernel thread and cahche memeory at 2.4
Date: Wed, 11 Oct 2006 14:02:23 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="windows-1255";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi ,


I am trying to understand whether there is any context (thread wise)
involved when I do alloc_skb.


I have a kernel module that runs a kernel thread. (2.4.18 , regular PC with
2 ethernet interfaces)
That thread generates an ICMP packet every 50 milisec. It does it as
follows:

    -     call to alloc_skb
    -     fill ip header and icmp header
    -     fill in the necessary skb fields
    -     call to ip_rcv to inject the packet into the stack

Al of that worked just fine , and I was able to inspect the outgoing packets
through ethereal.
The problem occured while I did a rmmod for that module - the machine just
crashed (reset )

After spending some time in debugging this problem , I added a short delay
at my exit function before
the stop thread call. I have discovered that the last call to __kfree_skb
from net_tx_action must come while
my kernel thread is still alive .

I am trying to understand why is it so . Is there any importance to the
context that had performed the alloc ?


Thanks for any tip,
Chava 

