Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVGAVd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVGAVd3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 17:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVGAVd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 17:33:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40388 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261311AbVGAV0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 17:26:07 -0400
Date: Fri, 1 Jul 2005 17:26:07 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: asm-i386/mmzone.h oddness.
Message-ID: <20050701212606.GA2970@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering why the rawhide gcc (4.0.0 20050622 (Red Hat 4.0.0-13))
blew up whilst trying to compile -rc3 and newer, with this informative
error..

include/asm/mmzone.h:154: error: syntax error before numeric constant

So I dug around, and I've not yet tested my theory, but this
looks just.. wrong.

#if CONFIG_NUMA
extern struct pglist_data *node_data[];
#define NODE_DATA(nid)  (node_data[nid])

#ifdef CONFIG_NUMA

The first #if used to be a #ifdef CONFIG_DISCONTIGMEM,
which made a little more sense to me, but I don't fully
understand the recent changes yet.

Anyone have clues ?

		Dave
