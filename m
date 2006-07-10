Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422706AbWGJRDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422706AbWGJRDK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 13:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422704AbWGJRDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 13:03:10 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:13494 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1422702AbWGJRDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 13:03:08 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH] remove empty node at boot time
Date: Mon, 10 Jul 2006 11:03:03 -0600
User-Agent: KMail/1.8.3
Cc: linux-ia64@vger.kernel.org, tony.luck@intel.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20060601200436.6bf7c4e5.kamezawa.hiroyu@jp.fujitsu.com> <200607092038.41053.bjorn.helgaas@hp.com> <20060710141903.424ba3db.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060710141903.424ba3db.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607101103.03849.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 July 2006 23:19, KAMEZAWA Hiroyuki wrote:
> Could you try this patch ? (against 2.6.18-rc1)

Your patch does fix it.  But I'm worried about removing
empty nodes at boot-time.  I want to support the following
scenario:

  node 0: 1 enabled CPU, 3 disabled CPUs, no local memory
  node 1: 4 disabled CPUs, no local memory
  node 2: no CPUs, big interleaved memory across nodes 0 & 1

At run-time, I'd like to be able to enable any or all of the
7 disabled CPUs.  If you remove the "empty" node 1 at boot-time,
it sounds like I won't be able to enable its CPUs later.

Bjorn
