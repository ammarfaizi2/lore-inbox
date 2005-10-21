Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbVJUOCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbVJUOCo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 10:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbVJUOCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 10:02:44 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:56824 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964956AbVJUOCn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 10:02:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jzwP9ZOTRuWiu7Y4ympb+3OSJpuI1XvcfwSofMxXliq6tNCMMKLBsVcjuUGeG+oOxV+L0eI/ezhHSgY0OmhZ0oOXzhOL25ztETe0Yhet1loAAtbF1XagO8tR+IKVxRrvlLXeH+Yvl5ksQxlvW05Muaw4/MMKBCBpTXN+DPwkqRU=
Message-ID: <cda58cb80510210702g3b0c0bdbk@mail.gmail.com>
Date: Fri, 21 Oct 2005 16:02:40 +0200
From: Franck <vagabon.xyz@gmail.com>
To: linux-usb-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: kernel is overwhelmed by usb hcd's interrupts
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've written an usb driver for linux for a specific usb host
controler. Basicaly the hw generates an interrupt every 1 ms (every
start of frame) and during transfers interrupts can be generated every
30 us ! My cpu is a MIPS one running at 96Mhz and HZ is 100.

After transfering 20M bytes of data through USB, the kernel loops for
a while in timer interrupt handler. It actually loops in update_times
with tick (jiffies - wall_jiffies) value equals to 3707637046 ! I
guess that the kernel have lost a lot of timer ticks...However
interrupts are enable inside usb driver, I don't see how the kernel
can lost so many ticks.

Could anyone give me some advices for that ?

Thanks
--
               Franck
