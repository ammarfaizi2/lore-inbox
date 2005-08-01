Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbVHAXf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbVHAXf1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 19:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVHAXf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 19:35:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20657 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261342AbVHAXfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 19:35:21 -0400
Date: Mon, 1 Aug 2005 19:35:17 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de
Subject: pci cacheline size / latency oddness.
Message-ID: <20050801233517.GA23172@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, ak@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During boot of todays -git, I noticed this..

PCI: Setting latency timer of device 0000:00:1d.7 to 64

after boot, lspci shows..

00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
Subsystem: Dell: Unknown device 0169
Flags: bus master, medium devsel, latency 0, IRQ 201
                                          ^^						

It also complains about..

PCI: cache line size of 128 is not supported by device 0000:00:1d.7

x86-64 doesn't have an arch override for pci_cache_line_size, so
it ends up at L1_CACHE_BYTES >> 2, which is 128 if you build
x86-64 kernels with CONFIG_GENERIC_CPU or CONFIG_MPSC
This means we will do the wrong thing on AMD machines which have
64 byte cachelines.   I saw this problem however on an em64t box.
Would it make sense to shift >> once more if it fails, and retry
with a smaller size perhaps ?

		Dave

