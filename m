Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVGLNOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVGLNOi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 09:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVGLNOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 09:14:38 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:7046 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261388AbVGLNOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 09:14:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=d5z+ps6fsugqwLt+E+b7FSOsJneL7NhIX1m4VvfzhF6UUNxAspwPSfg1f6nuaTzckn2Q1zEX16quzWVCIfF+7lZpEQ4NbcTFI6K7gBuYUPtV1xoRganVsfWl9nBYHPSjKxbiDf+hCW8ViFR3ept/cRbR8uaaltVclcYemXcRgA4=
Message-ID: <42D3C37C.6040401@gmail.com>
Date: Tue, 12 Jul 2005 15:19:56 +0200
From: Mateusz Berezecki <mateuszb@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: "scheduling while atomic" ? 
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi LKML,

What does the message saying "scheduling while atomic" mean?

The kernel prints a stack backtrace after this message appears so I
suppose this is
not a good behaviour. I am finishing an open source driver, and I need
to do all of this
locking stuff, etc. and this really makes me wonder what I am doing wrong.

here is some part of a backtrace...

scheduling while atomic: insmod/0x00000001/12692
 [<c03e7352>] schedule+0x632/0x640
 [<c0119bb1>] __wake_up_common+0x41/0x70
 [<c03e74df>] wait_for_completion+0x8f/0xf0
 [<c0119b50>] default_wake_function+0x0/0x20
 [<c0119b50>] default_wake_function+0x0/0x20
 [<c012e2dd>] queue_work+0x8d/0xa0
 [<c012e070>] __call_usermodehelper+0x0/0x70
 [<c012e1a5>] call_usermodehelper_keys+0xc5/0xd0
 [<c012e070>] __call_usermodehelper+0x0/0x70
 [<c020c028>] sprintf+0x28/0x30
 [<c020955d>] kobject_hotplug+0x29d/0x310
 [<c019fc6e>] sysfs_create_link+0x3e/0x60
 [<c028b601>] class_device_add+0x161/0x1e0
 [<c036f38e>] netdev_register_sysfs+0x3e/0x100
 [<c03650db>] netdev_run_todo+0x1eb/0x220
 [<c0364dce>] register_netdev+0x5e/0x90

I enable a lock at the beginning of device attach routine
and I disable it at the end. Whats wrong with it?



regards
Mateusz
