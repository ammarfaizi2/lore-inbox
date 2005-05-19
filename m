Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVESG03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVESG03 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 02:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVESG03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 02:26:29 -0400
Received: from smtp.istop.com ([66.11.167.126]:65490 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262215AbVESG0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 02:26:25 -0400
From: Daniel Phillips <phillips@istop.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Subject: Re: [RFC] [PATCH] OCFS2
Date: Thu, 19 May 2005 02:30:23 -0400
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, torvalds@osdl.org, akpm@osdl.org,
       wim.coekaerts@oracle.com, lmb@suse.de
References: <20050518223303.GE1340@ca-server1.us.oracle.com>
In-Reply-To: <20050518223303.GE1340@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505190230.23624.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 May 2005 18:33, Mark Fasheh wrote:
> http://oss.oracle.com/projects/ocfs2/dist/files/patches/2.6.12-rc4/broken-o
>ut/06_dlm.patch A distributed lock manager built with the cluster file
> system use case in mind. The OCFS2 dlm exposes a VMS style API, though
> things have been simplified internally. The only lock levels implemented
> currently are NLMODE, PRMODE and EXMODE.

+ if (recovery && 
+     (!dlm_is_recovery_lock(name, strlen(name)) || convert) ) {
+  goto error;
+ }

Zero terminated strings for lock names is bad taste.  It generates a bunch of 
useless strlen executions and you force an ascii namespace for no apparent 
reason.  Add a 9th parameter, namelen, to the lock call maybe?

Regards,

Daniel 
