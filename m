Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756797AbWK0FBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756797AbWK0FBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 00:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756807AbWK0FBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 00:01:08 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1449 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1756797AbWK0FBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 00:01:07 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Containers <containers@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] Fix the binary ipc and uts namespace sysctls.
Date: Sun, 26 Nov 2006 21:59:26 -0700
Message-ID: <m1hcwlmqmp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The binary interface to the namespace sysctls was never implemented
resulting in some really weird things if you attempted to use
sys_sysctl to read your hostname for example.

This patch series simples the code a little and implements the binary
sysctl interface.

In testing this patch series I discovered that our 32bit compatibility
for the binary  sysctl interface is imperfect.  In particular
KERN_SHMMAX and KERN_SMMALL are size_t sized quantities and are
returned as 8 bytes on to 32bit binaries using a x86_64 kernel.  
However this has existing for a long time so it is not a new
regression with the namespace work.

Gads the whole sysctl thing needs work before it stops being easy
to shoot yourself in the foot.

Looking forward a little bit we need a better way to handle sysctls
and namespaces as our current technique will not work for the network
namespace.  I think something based on the current overlapping sysctl
trees will work but the proc side needs to be redone before we can
use it.

Eric



