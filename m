Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161140AbWFVOBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbWFVOBl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161145AbWFVOBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:01:41 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:31898 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id S1161140AbWFVOBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:01:39 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Dropping Packets in 2.6.17
Date: Thu, 22 Jun 2006 14:01:38 +0000 (UTC)
Organization: Cistron
Message-ID: <e7e7s2$3qc$1@news.cistron.nl>
References: <20060622113147.3496.qmail@web33304.mail.mud.yahoo.com> <449A9ADC.9070800@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: ncc1701.cistron.net 1150984898 3916 194.109.0.112 (22 Jun 2006 14:01:38 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@n2o.xs4all.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <449A9ADC.9070800@draigBrady.com>,
Pádraig Brady  <P@draigBrady.com> wrote:
>Note there is a max interrupt rate of around 80K/s
>on x86 at least (not sure about opteron), so make
>sure you're using NAPI. /proc/interrupts will
>show your interrupt rate.

The e1000 driver has some more knobs you can turn. I have this
in my /etc/modules file:

e1000 RxAbsIntDelay=256,256 TxAbsIntDelay=256,256 TxDescriptors=1024,1024 RxDescriptors=1024,1024

(this is for two cards)

and this in /etc/sysctl.conf:

# Tune back swappiness on 2.6
vm.swappiness = 10

# Lots of kernel memory needed for e1000
vm.min_free_kbytes = 65535

This box accepts ~250 mbit/sec, stores that on disk, and streams it
out again to multiple peers at ~1300 mbit/sec total. Kernel 2.6.14.2,
dual xeon em64t in 64 bits mode, 4 GB memory.

Mike.

