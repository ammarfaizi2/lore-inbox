Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965273AbWJLFG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965273AbWJLFG1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 01:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965275AbWJLFG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 01:06:27 -0400
Received: from bay0-omc3-s2.bay0.hotmail.com ([65.54.246.202]:21045 "EHLO
	bay0-omc3-s2.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S965273AbWJLFG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 01:06:26 -0400
Message-ID: <BAY24-F39D5E3A7E7B3E9B1F469AC5150@phx.gbl>
X-Originating-IP: [75.18.217.89]
X-Originating-Email: [x-list-subscriptions@hotmail.com]
From: "J R" <x-list-subscriptions@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Bugs in (2.6.18) from static analysis tool
Date: Wed, 11 Oct 2006 22:06:22 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 12 Oct 2006 05:06:25.0311 (UTC) FILETIME=[2ABA12F0:01C6EDBC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are in the final stages of refining a new static analysis framework and 
are testing it out on various large open source software projects (like 
other ventures in this space).

Unlike other enterprises, we are making a linux intraprocedural analysis 
tool openly available in binary form to allow our results to be reproduced 
and validated. Ditto the bug lists.

Although this is commercial software, our team are all strong OS advocates 
and contributors. We hope to release some components of this project on an 
OS basis just as soon as we can trash out a solid plan which allows this 
while also enabling us to purchase food.

I've only attached 1 or 2 bugs at the end here (the full list is about 10K 
ascii text), there are at www.cqsat.com/linux.html#bugs. There's about 50 
and I recon 20 or so are both real and not yet identified.

Any comments/issues/feedback is appreciated.

-J

==============================================================================
SEVERITY=[SERIOUS]
ISSUE=[Tainted expression (tmp).kb_table used as an index in this context. 
Expression bounds: [Upper bound unchecked]. Tracking "(tmp).kb_table": 
unsigned, 8 bit(s)]
SOURCE=[/p0/working/Downloads/linux-2.6.9/drivers/char/vt_ioctl.c, line 83]
SINK=[/p0/working/Downloads/linux-2.6.9/drivers/char/vt_ioctl.c, line 88]
ORIGINATOR=[cqsat]

      80:     struct kbentry tmp;
      81:     ushort *key_map, val, ov;
      82:
      83:     if (copy_from_user(&tmp, user_kbe, sizeof(struct kbentry)))
          	^^^---------^^^----------^^^
          	START
      84:         return -EFAULT;
      86:     switch (cmd) {
      87:     case KDGKBENT:
      88:         key_map = key_maps[s];
          	^^^---------^^^----------^^^
          	ERROR
      89:         if (key_map) {
      90:             val = U(key_map[i]);
      91:             if (kbd->kbdmode != VC_UNICODE && KTYP(val) >= 
NR_TYPES)
      92:             val = K_HOLE;
==============================================================================

_________________________________________________________________
Be seen and heard with Windows Live Messenger and Microsoft LifeCams 
http://clk.atdmt.com/MSN/go/msnnkwme0020000001msn/direct/01/?href=http://www.microsoft.com/hardware/digitalcommunication/default.mspx?locale=en-us&source=hmtagline

