Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbVKPXLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbVKPXLm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 18:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbVKPXLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 18:11:41 -0500
Received: from ns2.g-housing.de ([81.169.133.75]:64132 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S1161001AbVKPXLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 18:11:41 -0500
Message-ID: <437BBC59.70301@g-house.de>
Date: Thu, 17 Nov 2005 00:10:17 +0100
From: Christian <evil@g-house.de>
User-Agent: Mail/News 1.6a1 (Windows/20051004)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-rc1: NET_CLS_U32 not working?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 0546-3, 16.11.2005), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i noticed that some of my QoS rules are not working any more. oh, i 
forgot to enable CONFIG_NET_CLS_U32. but when enabled, i got the 
following errors when compiling / installing the module:

* Warning: "unregister_tcf_proto_ops" [net/sched/cls_u32.ko] undefined!
* Warning: "register_tcf_proto_ops" [net/sched/cls_u32.ko] undefined!
* Warning: "tcf_exts_dump" [net/sched/cls_u32.ko] undefined!
* Warning: "tcf_exts_dump_stats" [net/sched/cls_u32.ko] undefined!
* Warning: "tcf_exts_change" [net/sched/cls_u32.ko] undefined!
* Warning: "tcf_exts_validate" [net/sched/cls_u32.ko] undefined!
* Warning: "tcf_exts_destroy" [net/sched/cls_u32.ko] undefined!

modprobe...

cls_u32: Unknown symbol unregister_tcf_proto_ops
cls_u32: Unknown symbol tcf_exts_destroy
cls_u32: Unknown symbol tcf_exts_change
cls_u32: Unknown symbol tcf_exts_dump
cls_u32: Unknown symbol tcf_exts_dump_stats
cls_u32: Unknown symbol register_tcf_proto_ops
cls_u32: Unknown symbol tcf_exts_validate
cls_u32: Unknown symbol unregister_tcf_proto_ops
cls_u32: Unknown symbol tcf_exts_destroy
cls_u32: Unknown symbol tcf_exts_change
cls_u32: Unknown symbol tcf_exts_dump
cls_u32: Unknown symbol tcf_exts_dump_stats
cls_u32: Unknown symbol register_tcf_proto_ops
cls_u32: Unknown symbol tcf_exts_validate

when i disabled CONFIG_NET_CLS_U32, everything compiles fine, but 
cls_u32 is missing of course :-(

all the missing symbols seem to be defined in include/net/pkt_cls.h. but 
  this file is #included by net/sched/cls_u32.c and other too, so i 
don't really know, why it doesn't work.

FWIW, i see EXPORT_SYMBOLs at the very end of net/sched/cls_api.c, but i 
can't see if/when cls_api.c is used (included?) at all.

undoing the PKT_SCHED patch [1] does not really help. the config-file is 
a bit different due to CONFIG_NET_QOS, the errors don't go away.

.config, .config.diff, dmesg, verbose output and more is here:
   http://nerdbynature.de/bits/sheep/2.6.15-rc1/

thanks for looking into that,
Christian.

[1] http://lkml.org/lkml/2005/11/1/141
-- 
BOFH excuse #245:

The Borg tried to assimilate your system. Resistance is futile.
