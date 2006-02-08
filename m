Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030607AbWBHUOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030607AbWBHUOo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030609AbWBHUOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:14:44 -0500
Received: from science.horizon.com ([192.35.100.1]:11849 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1030607AbWBHUOn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:14:43 -0500
Date: 8 Feb 2006 15:14:36 -0500
Message-ID: <20060208201436.14693.qmail@science.horizon.com>
From: linux@horizon.com
To: clameter@engr.sgi.com
Subject: Re: Terminate process that fails on a constrained allocation
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would perhaps a less drastic solution, that at least supports the common
partitioned-system configuration, be to limit the oom killer to processes
whose nodes are a *subset* of ours?

That way, a limited process won't kill any unlimited processes, but it
can fight with other processes with the same limits.  However, an
unlimited process discovering oom can kill anything on the system if
necessary.

(This requires a modified version of cpuset_excl_nodes_overlap that
calls nodes_subset() instead of nodes_intersects(), but it's pretty
straightforward.)
