Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268115AbUILPu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268115AbUILPu0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 11:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268117AbUILPu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 11:50:26 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:56809 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S268115AbUILPuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 11:50:23 -0400
Date: Sun, 12 Sep 2004 17:50:35 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20040912155035.GA17972@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094967978.1306.401.camel@krustophenia.net>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lee Revell <rlrevell@joe-job.com> ha scritto:
> The realtime-lsm Linux Security Module, written by Torben Hohn and Jack
> O'Quin, selectively grants realtime capabilities to specific user groups
> or applications. 

Hi,
just a couple of comments:

> diff -ruN -X /home/joq/bin/kdiff.exclude linux-2.6.8.1/security/realtime.c linux-2.6.8.1-rt/security/realtime.c
> --- linux-2.6.8.1/security/realtime.c   Wed Dec 31 18:00:00 1969
> +++ linux-2.6.8.1-rt/security/realtime.c        Fri Sep 10 11:09:09 2004
[...]
> +#ifdef NGROUPS_SMALL                   /* using new groups struct? */
> +                       get_group_info(current->group_info);
> +                       for (i = 0; i < current->group_info->ngroups; ++i) {
> +                               if (gid == GROUP_AT(current->group_info, i)) {
> +                                       rt_ok = 1;
> +                                       break;
> +                               }
> +                       }
> +                       put_group_info(current->group_info);
> +#else  /* old task struct */
> +                       for (i = 0; i < NGROUPS; ++i) {
> +                               if (gid == current->groups[i]) {
> +                                       rt_ok = 1;
> +                                       break;
> +                               }
> +                       }
> +#endif /* NGROUPS_SMALL */

Since you are targeting linux 2.6.9 this ifdef can go away.

> +#ifdef LSM_UNSAFE_SHARE                        /* version >= 2.6.6 */
> +       .bprm_apply_creds =             cap_bprm_apply_creds,
> +#else
> +       .bprm_compute_creds =           cap_bprm_compute_creds,
> +#endif

Same here.

> +#define MY_NAME THIS_MODULE->name

This is ugly :P

Luca
-- 
Home: http://kronoz.cjb.net
Se alla sera, dopo una strepitosa vittoria, guardandoti allo
specchio dovessi notare un secondo paio di palle, che il tuo 
cuore non si riempia d'orgoglio, perche` vuol dire che ti 
stanno inculando -- Saggio Cinese
