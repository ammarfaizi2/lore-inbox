Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbVHVW13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbVHVW13 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbVHVW0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:26:53 -0400
Received: from supmuscle.dreamhost.com ([66.33.192.105]:30113 "EHLO
	coverity.dreamhost.com") by vger.kernel.org with ESMTP
	id S1751435AbVHVW0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:26:05 -0400
Message-ID: <430A5127.5000304@coverity.com>
Date: Mon, 22 Aug 2005 15:26:47 -0700
From: Ted Unangst <tedu@coverity.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.7.3) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: some missing spin_unlocks
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think these are all real bugs.

sound/synth/emux/emux_synth.c snd_emux_note_on, line 101
snd_assert will return without unlocking emu->voice_lock (line 89)

sound/pci/au88x0/au88x0_core.c vortex_adb_allocroute, search for EBUSY
returns without unlocking vortex->lock

net/rose/rose_route.c rose_route_frame, line 998
returns without unlocking rose_node_list_lock, rose_neigh_list_lock, or 
rose_route_list_lock

net/rose/rose_timer.c rose_heartbeat_expiry, line 141
rose_destroy_socket does not unlock sk as far as i can see

drivers/net/irda/donauboe.c toshoboe_net_ioctl, search for EPERM
returns without unlocking self->lock


-- 
Ted Unangst             www.coverity.com             Coverity, Inc.
