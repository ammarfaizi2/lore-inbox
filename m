Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbUJ0MB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbUJ0MB0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 08:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUJ0MB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 08:01:26 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:18377 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262396AbUJ0MAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 08:00:14 -0400
Date: Wed, 27 Oct 2004 13:59:43 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: usb hotplug $DEVICE empty
Message-ID: <20041027115943.GA1674@xeon2.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ID: EC6E82ZJreJ99eFvLjCX3jDhJv+UtO-NbLZSkNqjKF-O8wPR+rggoB
X-TOI-MSGID: 16eba67b-2ae4-456c-9b8d-dd09139c11ae
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found out why $DEVICE did not show of in /sbin/hotplug
any more. (2.6.10-rc1-bk5)

Depending on the setting of CONFIG_USB_DEVICEFS
either the environment variables DEVICE or PRODUCT
which should be passed to /sbin/hotplug become overwritten
by the environment variable SEQNUM.

This happens in kobject_hotplug() of lib/kobject_uevent.c.

The here called hotplug_ops->hotplug function usb_hotplug()
advances both, the index to envp and the pointer into buffer
but the calling function gets no notice of that.

So to add SEQNUM later on it advances index/pointer to
envp/buffer from where it has stopped before calling
usb_hotplug(), thus overwriting the first entry that 
usb_hotplug() has added before.


-- 
Klaus
