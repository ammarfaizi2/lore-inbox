Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWADA2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWADA2s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 19:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWADA2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 19:28:48 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:6619 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965002AbWADA2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 19:28:47 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] [RFC] Optimize select/poll by putting small data sets on the stack
Date: Wed, 4 Jan 2006 00:28:40 +0000
User-Agent: KMail/1.9.1
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <200601032158.14057.ak@suse.de>
In-Reply-To: <200601032158.14057.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601040028.40633.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 January 2006 20:58, Andi Kleen wrote:
> 
> This is a RFC for now. I would be interested in testing
> feedback. Patch is for 2.6.15.
> 
> Optimize select and poll by a using stack space for small fd sets
> 
> This brings back an old optimization from Linux 2.0. Using
> the stack is faster than kmalloc. On a Intel P4 system
> it speeds up a select of a single pty fd by about 13%
> (~4000 cycles -> ~3500)

Hmm, can you include the same change for compat_sys_select()?
When that was introduced, sys_select and compat_sys_select were
basically identical in their code, which makes it a lot easier
to verify that the compat_ version is correct.

Interestingly, doing a diff between sys_select and compat_sys_select
in the current kernel seems to suggest that they are both buggy
in that they miss checks for failing __put_user, but in /different/
places.

	Arnd <><
