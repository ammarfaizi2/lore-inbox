Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265886AbUFISKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265886AbUFISKK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 14:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUFISJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 14:09:59 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:33699 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265886AbUFISJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 14:09:50 -0400
Date: Wed, 9 Jun 2004 11:09:42 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: linux-kernel@vger.kernel.org
cc: linux-ia64@vger.kernel.org
Subject: Unaligned accesses in net/ipv4/netfilter/arp_tables.c:184
Message-ID: <Pine.LNX.4.58.0406091106210.21291@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following code casts pointers to char to long in order to do a fast
comparison. This causes alignment errors on IA64 and likely also on
other platforms:

        /* Look for ifname matches; this should unroll nicely. */
        for (i = 0, ret = 0; i < IFNAMSIZ/sizeof(unsigned long); i++) {
                ret |= (((const unsigned long *)indev)[i]
                        ^ ((const unsigned long *)arpinfo->iniface)[i])
                        & ((const unsigned long *)arpinfo->iniface_mask)[i];
        }

iniface is a pointer to char.
