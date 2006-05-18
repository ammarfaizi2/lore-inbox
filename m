Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWERPrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWERPrc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWERPrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:47:32 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:59297 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751054AbWERPrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:47:32 -0400
Date: Thu, 18 May 2006 10:47:00 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, xemul@sw.ru, Dave Hansen <haveblue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>,
       serue@us.ibm.com
Subject: [PATCH 0/9] namespaces: Introduction
Message-ID: <20060518154700.GA28344@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces a per-process utsname namespace.  These can
be used by openvz, vserver, and application migration to virtualize and
isolate utsname info (i.e. hostname).  More resources will follow, until
hopefully most or all vserver and openvz functionality can be implemented
by controlling resource namespaces from userspace.

Previous utsname submissions placed a pointer to the utsname namespace
straight in the task_struct.  This patchset (and the last one) moves
it and the filesystem namespace pointer into struct nsproxy, which is
shared by processes sharing all namespaces.  The intent is to keep
the taskstruct smaller as the number of namespaces grows.

Changes:
	- the reference count on fs namespace and uts namespace now
	  refers to the number of nsproxies pointing to it
	- some consolidation of namespace cloning and exit code to
	  clean up kernel/{fork,exit}.c
	- passed ltp and ltpstress on smp power, x86, and x86-64
	  boxes.
