Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268751AbTGXOMM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 10:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269033AbTGXOMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 10:12:12 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:6674 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S268751AbTGXOMJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 10:12:09 -0400
To: Hiroshi Miura <miura@da-cha.org>
Cc: ndiamond@wta.att.ne.jp, linux-kernel@vger.kernel.org, vojtech@suse.cz,
       junkio@cox.net
Subject: Re: Japanese keyboards broken in 2.6
References: <018401c35059$2bb8f940$4fee4ca5@DIAMONDLX60>
	<20030722172903.A12240@pclin040.win.tue.nl>
	<87k7a9z7ly.fsf@devron.myhome.or.jp> <3F1FBFFC.9050305@da-cha.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 24 Jul 2003 23:26:31 +0900
In-Reply-To: <3F1FBFFC.9050305@da-cha.org>
Message-ID: <87n0f4j90o.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiroshi Miura <miura@da-cha.org> writes:

> I can use Japanese keyboard.
> I DO recompile console-tools with header file in linux-2.5/2.6.
> Because of NR_KEYS change, as Ogawa-san said,
> in 2.4 NR_KEYS=128, in 2.6 NR_KEYS= 0x200
> 
> When recompile, some tools fails compile on linux-2.6,
> but 'loadkeys' compiles nicely.
> 
> Instantly, user can set new keymap to use a recompiled loadkey command.
> 
> BTW, Ogawa-san's patch is needed?

For example, in loadkeys.y

	      if ((keymap_was_set[i])[j])
		{
		  ke.kb_index = j;
		  ke.kb_table = i;
		  ke.kb_value = (key_map[i])[j];

ke.kb_index overflowed. Likewise dumpkeys has same problem.
And debian using in init.d/console-screen.sh,

       dumpkeys < ${DEVICE_PREFIX}1 |sed -f /etc/console-tools/remap |loadkeys

Important part of my patch is the following. Other part was for
backward compatible.

+struct kbentry {
+	unsigned int kb_table;
+	unsigned int kb_index;
+	unsigned short kb_value;
+};

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
