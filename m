Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWEWKzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWEWKzd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 06:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWEWKzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 06:55:33 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:25257 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750868AbWEWKzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 06:55:32 -0400
Date: Tue, 23 May 2006 19:56:36 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: y-goto@jp.fujitsu.com, ktokunag@redhat.com, ashok.raj@intel.com,
       Andrew Morton <akpm@osdl.org>
Subject: [RFC][PATCH] node hotplug : register_cpu() changes [0/3]
Message-Id: <20060523195636.693e00d6.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With Goto-san's patch, we can add new pgdat/node in runtime.
I'm now considering node-hot-add with cpu + memory on ACPI.

I found acpi container, which describes node, could evaluate cpu before
memory. This means cpu-hot-add occurs before memory hot add.

In most part, cpu-hot-add doesn't depend on node hot add.
But register_cpu, which creates symbolic link from node to cpu, requires
that node should be onlined before register_cpu().
When a node is onlined, its pgdat should be there.

This patch-set holds off creating symbolic link from node to cpu
until node is onlined. 

[1/3] modifies register_cpu
[2/3] changes caller of register cpu
[3/3] changes register_node. create symbolic link fron node to cpu.

By these patch, (cpu + memory) node hot add will succeed.
(cpu-only)/(IO-only) node hot add will need more fixes. (But we need this ?)

And ia64 needs more fixes. I'll post later.

-Kame

