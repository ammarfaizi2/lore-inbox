Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVFQP6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVFQP6H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 11:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVFQP6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 11:58:07 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:53425 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S262005AbVFQP6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 11:58:03 -0400
Subject: Re: [PATCH 1/1] SELinux: memory leak in selinux_sb_copy_data()
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: geraldsc@de.ibm.com
Cc: akpm@osdl.org, jmorris@redhat.com, schwidefsky@de.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1119023249.7006.71.camel@thinkpad>
References: <1119014283.7006.58.camel@thinkpad>
	 <1119023249.7006.71.camel@thinkpad>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 17 Jun 2005 11:57:05 -0400
Message-Id: <1119023825.15306.30.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-17 at 17:47 +0200, Gerald Schaefer wrote:
> Sorry, there was a whitespace accident and the above patch would not
> apply.
> Here is the fixed version:
> 
> diff -pruN linux-2.6-git/security/selinux/hooks.c linux-2.6-git_xxx/security/selinux/hooks.c
> --- linux-2.6-git/security/selinux/hooks.c	2005-06-16 20:01:03.000000000 +0200
> +++ linux-2.6-git_xxx/security/selinux/hooks.c	2005-06-17 14:38:08.000000000 +0200
> @@ -1945,6 +1945,7 @@ static int selinux_sb_copy_data(struct f
>  	} while (*in_end++);
>  
>  	copy_page(in_save, nosec_save);
> +	free_page((unsigned long)nosec);
>  out:
>  	return rc;
>  }

Shouldn't that be nosec_save?  nosec is advanced by take_option().

-- 
Stephen Smalley
National Security Agency

