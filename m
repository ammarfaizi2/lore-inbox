Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWD0DZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWD0DZt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 23:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbWD0DZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 23:25:49 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:52406 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S964907AbWD0DZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 23:25:49 -0400
Date: Wed, 26 Apr 2006 23:25:46 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: "Serge E. Hallyn" <serue@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] selinux: check for failed kmalloc in security_sid_to_context
In-Reply-To: <20060427020740.GA23112@sergelap.austin.ibm.com>
Message-ID: <Pine.LNX.4.64.0604262325090.5735@d.namei>
References: <20060427020740.GA23112@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2006, Serge E. Hallyn wrote:

> Check for NULL kmalloc return value before writing to it.
> 
> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

Acked-by: James Morris <jmorris@namei.org>


> ---
> 
>  security/selinux/ss/services.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> 3d9cf05c7fa2578f87648dd0862e70cf7959ad7a
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 6149248..20b1065 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -593,6 +593,10 @@ int security_sid_to_context(u32 sid, cha
>  
>  			*scontext_len = strlen(initial_sid_to_string[sid]) + 1;
>  			scontextp = kmalloc(*scontext_len,GFP_ATOMIC);
> +			if (!scontextp) {
> +				rc = -ENOMEM;
> +				goto out;
> +			}
>  			strcpy(scontextp, initial_sid_to_string[sid]);
>  			*scontext = scontextp;
>  			goto out;
> 

-- 
James Morris
<jmorris@namei.org>

