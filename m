Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVFQRem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVFQRem (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 13:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbVFQRem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 13:34:42 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:19144 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S262026AbVFQRei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 13:34:38 -0400
Subject: Re: [PATCH 1/1] SELinux: memory leak in selinux_sb_copy_data()
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: geraldsc@de.ibm.com
Cc: akpm@osdl.org, jmorris@redhat.com, schwidefsky@de.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1119025096.7006.83.camel@thinkpad>
References: <1119014283.7006.58.camel@thinkpad>
	 <1119023249.7006.71.camel@thinkpad>
	 <1119023825.15306.30.camel@moss-spartans.epoch.ncsc.mil>
	 <1119025096.7006.83.camel@thinkpad>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 17 Jun 2005 13:33:36 -0400
Message-Id: <1119029616.15306.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-17 at 18:18 +0200, Gerald Schaefer wrote:
> On Fri, 2005-06-17 at 11:57 -0400, Stephen Smalley wrote:
> > 
> > Shouldn't that be nosec_save?  nosec is advanced by take_option().
> > 
> That's right, I muddled that up. Hope I got this one-line patch right
> this time...
> 
> diff -pruN linux-2.6-git/security/selinux/hooks.c linux-2.6-git_xxx/security/selinux/hooks.c
> --- linux-2.6-git/security/selinux/hooks.c	2005-06-16 20:01:03.000000000 +0200
> +++ linux-2.6-git_xxx/security/selinux/hooks.c	2005-06-17 14:38:08.000000000 +0200
> @@ -1945,6 +1945,7 @@ static int selinux_sb_copy_data(struct f
>  	} while (*in_end++);
>  
>  	copy_page(in_save, nosec_save);
> +	free_page((unsigned long)nosec_save);
>  out:
>  	return rc;
>  }

Thanks, looks fine.

Acked-by:  Stephen Smalley <sds@epoch.ncsc.mil>

-- 
Stephen Smalley
National Security Agency

