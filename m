Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbUK2QQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbUK2QQl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 11:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUK2QQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 11:16:41 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:34949 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261750AbUK2QQ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 11:16:28 -0500
Subject: Re: [2.6 patch] selinux: possible cleanups
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Adrian Bunk <bunk@stusta.de>
Cc: James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       selinux@tycho.nsa.gov
In-Reply-To: <20041128190139.GD4390@stusta.de>
References: <20041128190139.GD4390@stusta.de>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1101744496.13948.141.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 29 Nov 2004 11:08:16 -0500
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

These functions are part of an overall interface between the AVC and the
security server designed to support dynamic security policy
requirements, based on prior studies including some formal analysis. 
While the example security server does not presently use anything other
than avc_ss_reset, I'd be hesitant to completely remove the rest of the
interface, as that will leave a far less functional interface for future
security servers and may lead to further "optimization" of the AVC that
will preclude support for dynamic policy requirements (or at least make
it much harder to restore such support).

>   - ss/services.c: security_member_sid

There are patches under development for SELinux that make use of this
function, including exporting the interface to userspace via selinuxfs
and using it in-kernel for polyinstantiation.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

