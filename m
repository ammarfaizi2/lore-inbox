Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVGUSDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVGUSDT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 14:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVGUSDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 14:03:19 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:41894 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261825AbVGUSDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 14:03:18 -0400
Subject: Re: why is the jiffies 128 in jffs2_find_gc_block() in gc.c of
	jffs2.
From: Josh Boyer <jdub@us.ibm.com>
To: krishna <krishna.c@globaledgesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42DFD7D3.2060101@globaledgesoft.com>
References: <42DFD7D3.2060101@globaledgesoft.com>
Content-Type: text/plain
Date: Thu, 21 Jul 2005 13:03:03 -0500
Message-Id: <1121968983.20907.5.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-21 at 22:43 +0530, krishna wrote:
> Hi,
> 
> Can any one tell me
> why is the jiffies _128_ in jffs2_find_gc_block() in gc.c of jffs2.

jiffies isn't set in that function.  The value of jiffies is modded by
128.  Since jiffies is a volatile value, the value of n is usually
different on each call of that function.  This value is used to pick an
eraseblock to garbage collect out of a series of different lists.  This
is done to help with effective wear leveling of flash eraseblocks.

josh

