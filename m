Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266888AbUJBAm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266888AbUJBAm5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 20:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUJBAm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 20:42:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:63418 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266888AbUJBAmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 20:42:54 -0400
Message-ID: <415DF88E.4020002@sgi.com>
Date: Fri, 01 Oct 2004 17:38:38 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       csa@oss.sgi.com, akpm@osdl.org, guillaume.thouvenin@bull.net,
       tim@physik3.uni-rostock.de, corliss@digitalmages.com
Subject: Re: [Lse-tech] Re: [PATCH 2.6.9-rc2 2/2] enhanced MM accounting data
 collection
References: <4158956F.3030706@engr.sgi.com>	<41589927.5080803@engr.sgi.com> <20040928023350.611c84d8.pj@sgi.com>
In-Reply-To: <20040928023350.611c84d8.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> nits:
> 
> 1) I'm not sure the "no-op if CONFIG_CSA not set" comments
>    are worthwhile - it does not seem to be a common practice
>    to mark macros that collapse under certain CONFIG's with
>    such comments, and some code, such as in fork.c, would
>    become quite a bit less readable if such comments were
>    widely used.

Yeah, that makes sense. Will be fixed in next posting.

> 
> 2) Three of the added csa_update_integrals() lines have
>    leading spaces, instead of a tab char, such as in:
> 
> ===================================================================
> --- linux.orig/fs/exec.c	2004-09-27 11:57:40.201435722 -0700
> +++ linux/fs/exec.c	2004-09-27 14:05:41.266160725 -0700
> @@ -1163,6 +1164,9 @@
>  
>  		/* execve success */
>  		security_bprm_free(&bprm);
> +		/* no-op if CONFIG_CSA not set */
> +                csa_update_integrals();		<=========
> +                update_mem_hiwater();			<=========
>  		return retval;
>  	}

Caused by 'cut-n-paste'. Will be fixed.

>  
> 3) Is it always the case that csa_update_integrals() and
>    update_mem_hiwater() are used together?  If so, perhaps
>    they could be collapsed into one?  Even the current->mm
>    test inside them could be made one test, perhaps?

As Robin pointed out, there are a couple of instances that are
not the case. Actually there are three.

Thanks for your feedback, Paul!

  - jay

