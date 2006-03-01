Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751844AbWCAUcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbWCAUcN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWCAUcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:32:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:167 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751177AbWCAUcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:32:10 -0500
Date: Wed, 1 Mar 2006 15:32:08 -0500
From: Dave Jones <davej@redhat.com>
To: linux-acpi@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.16rc5 acpi slab corruption
Message-ID: <20060301203208.GA21722@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, linux-acpi@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <200603012014.k21KE9FI010352@dhcp150.install.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200603012014.k21KE9FI010352@dhcp150.install.boston.redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the latest git, on a testbox here, we're seeing this..

  slab size-512: redzone mismatch in slab f7d74040, obj f7d74078, bufctl 0xfffffffe
  Redzone: 0x170fc2a5/0x170fc200.
  Last user: [<c0205e51>](acpi_ut_allocate+0x28/0x45)
  000: 53 53 44 54 fa 01 00 00 01 f9 50 6d 52 65 66 00
  010: 43 70 75 30 49 73 74 00 00 30 00 00 49 4e 54 4c

over and over just after booting.
Translating that to ascii, it looks like..

SSDT �PmRef
Cpu0Ist0INTL


(Does no-one else run with slab-poisoning any more?
 Sometimes I feel I'm the only person who sees these.)

		Dave


