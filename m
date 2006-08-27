Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWH0QCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWH0QCd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 12:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWH0QCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 12:02:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:12728 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932151AbWH0QCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 12:02:06 -0400
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH RFC 4/6] Fix places where using %gs changes the usermode ABI.
Date: Sun, 27 Aug 2006 17:59:07 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
References: <20060827084417.918992193@goop.org> <20060827084452.151407233@goop.org>
In-Reply-To: <20060827084452.151407233@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608271759.07055.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ===================================================================
> --- a/arch/i386/kernel/ptrace.c
> +++ b/arch/i386/kernel/ptrace.c
> @@ -94,13 +94,9 @@ static int putreg(struct task_struct *ch
>  				return -EIO;
>  			child->thread.fs = value;
>  			return 0;
> -		case GS:
> -			if (value && (value & 3) != 3)
> -				return -EIO;
> -			child->thread.gs = value;
> -			return 0;
>  		case DS:
>  		case ES:
> +		case GS:
>  			if (value && (value & 3) != 3)
>  				return -EIO;
>  			value &= 0xffff;
> @@ -132,8 +128,6 @@ static unsigned long getreg(struct task_
>  			retval = child->thread.fs;
>  			break;
>  		case GS:
> -			retval = child->thread.gs;
> -			break;

Didn't the eip/esp offsets change too?

-Andi
