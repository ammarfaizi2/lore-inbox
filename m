Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbUBIBSa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 20:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUBIBSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 20:18:30 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:59462 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S264537AbUBIBS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 20:18:29 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.25-rc1: Inconsistent ioctl symbol usage in drivers/message/fusion/mptctl.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 09 Feb 2004 12:18:05 +1100
Message-ID: <2556.1076289485@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.25-rc1 drivers/message/fusion/mptctl.c expects sys_ioctl,
register_ioctl32_conversion and unregister_ioctl32_conversion to be
exported symbols when MPT_CONFIG_COMPAT is defined.  That symbol is
defined for __sparc_v9__, __x86_64__ and __ia64__.

The symbols are not exported in ia64, mptctl.o gets unresolved symbols
when it is a module on ia64.

x64_64 exports register_ioctl32_conversion and unregister_ioctl32_conversion,
but not sys_ioctl.

