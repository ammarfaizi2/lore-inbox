Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266888AbUJNVEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266888AbUJNVEu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 17:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267294AbUJNVDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 17:03:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39690 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267709AbUJNVCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:02:49 -0400
Date: Thu, 14 Oct 2004 22:02:43 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: __attribute__((unused))
Message-ID: <20041014220243.B28649@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice that module.h contains stuff like:

#define MODULE_GENERIC_TABLE(gtype,name)                        \
extern const struct gtype##_id __mod_##gtype##_table            \
  __attribute__ ((unused, alias(__stringify(name))))

and even:

#define __MODULE_INFO(tag, name, info)                                    \
static const char __module_cat(name,__LINE__)[]                           \
  __attribute_used__                                                      \
  __attribute__((section(".modinfo"),unused)) = __stringify(tag) "=" info

My understanding is that we shouldn't be using __attribute__((unused))
in either of these - can someone confirm.

The second one looks fairly dodgy since we're telling a compiler that
it's both used and unused.  That sounds a bit like a HHGTTG puzzle (you
have tea and no tea.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
