Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWDPDhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWDPDhm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 23:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWDPDhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 23:37:42 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:64322 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932189AbWDPDhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 23:37:41 -0400
Date: Sat, 15 Apr 2006 20:34:23 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: kurt.hackel@oracle.com, ocfs2-devel@oss.oracle.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] fs/ocfs2/: remove unused exports
Message-ID: <20060416033423.GH25194@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060414113409.GJ4162@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060414113409.GJ4162@stusta.de>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,
	These are all cluster stack functions and the OCFS2 cluster stack is
pretty much OCFS2 specific right now. So technically one could say they can
all be unexported until used by another related module. I'd rather leave
some of the ones that could make sense as exports though.

On Fri, Apr 14, 2006 at 01:34:09PM +0200, Adrian Bunk wrote:
> This patch removes the following unused EXPORT_SYMBOL_GPL's:
> - cluster/heartbeat.c: o2hb_check_node_heartbeating_from_callback
Completes an API. Lets keep this one please :)

> - cluster/heartbeat.c: o2hb_stop_all_regions
Hmm, called by the quorum stuff, which right now is embedded in the same
module as heartbeat anyway. Can probably go.

> - cluster/nodemanager.c: o2nm_get_node_by_num
> - cluster/nodemanager.c: o2nm_configured_node_map
> - cluster/nodemanager.c: o2nm_get_node_by_ip
I could definitely see the file system using these.

> - cluster/nodemanager.c: o2nm_node_put
> - cluster/nodemanager.c: o2nm_node_get
Can go for now.

> - dlm/dlmmaster.c: dlm_migrate_lockres
Was exported for debugging only anyway AFAIR. Can go.

Thanks,
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

