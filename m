Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbULCQDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbULCQDO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 11:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbULCQDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 11:03:14 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:25525 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262303AbULCQDJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 11:03:09 -0500
Subject: Re: [2.6 patch] selinux: possible cleanups
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Adrian Bunk <bunk@stusta.de>
Cc: James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       selinux@tycho.nsa.gov
In-Reply-To: <20041128190139.GD4390@stusta.de>
References: <20041128190139.GD4390@stusta.de>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1102089296.29971.110.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 03 Dec 2004 10:54:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-11-28 at 14:01, Adrian Bunk wrote:
> The patch below contains the following possible cleanups:
> - make needlessly global code static
> - remove the following unused global functions:
>   - avc.c: avc_ss_grant
>   - avc.c: avc_ss_try_revoke
>   - avc.c: avc_ss_revoke
>   - avc.c: avc_ss_set_auditallow
>   - avc.c: avc_ss_set_auditdeny
>   - ss/avtab.c: avtab_map
>   - ss/ebitmap.c: ebitmap_or
>   - ss/hashtab.c: hashtab_remove
>   - ss/hashtab.c: hashtab_replace
>   - ss/hashtab.c: hashtab_map_remove_on_error
>   - ss/services.c: security_member_sid
>   - ss/sidtab.c: sidtab_remove
> - remove the following unused static functions:
>   - avc.c: avc_update_cache
>   - avc.c: avc_control
> 
> 
> Please review and comment on which of these changes are correct and 
> which conflict with pending patches for in-kernel users of the functions 
> affected.

Thanks for working on these cleanups.  I've separately submitted a patch
to export security_member_sid via selinuxfs, as it is part of the
security policy API and is needed for further work on security
polyinstantiation (e.g. multi-level directory support), so please remove
the diffs related to removing that function.  Two other comments:
- Did you mean to make avtab_insert static (you only removed the
function prototype for it)?
- Shouldn't the AVC_CALLBACK_* definitions other than RESET be removed
since you are removing the other avc_ss interfaces?

Otherwise, the patch seems sane to me.
  
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

