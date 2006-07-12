Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWGLQ5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWGLQ5a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWGLQ5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:57:30 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:27332 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1751271AbWGLQ5a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:57:30 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
Date: Wed, 12 Jul 2006 18:57:45 +0200
User-Agent: KMail/1.9.1
Cc: ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <44B52674.8060802@suse.com>
In-Reply-To: <44B52674.8060802@suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607121857.45988.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 July 2006 18:42, Jeff Mahoney wrote:
>  On systems with block devices containing slashes (virtual dasd, cciss,
>  etc), reiserfs will fail to initialize /proc/fs/reiserfs/<dev> due to
>  it being interpreted as a subdirectory. The generic block device code
>  changes the / to ! for use in the sysfs tree. This patch uses that
>  convention.
>
>  Tested by making dm devices use dm/<number> rather than dm-<number>

Your patch handles at most one slash. But the description mentions 'slashes' 
(ie several slashes)

> +	if (s)
> +		*s = '!';

Maybe you need a loop

while (s) {
	*s = '!';
	s = strchr(s, '/');
}

Eric
