Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVCIS2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVCIS2c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 13:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVCIS1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 13:27:52 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:60316 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262161AbVCIS0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:26:08 -0500
Message-ID: <422F3FD8.5020204@sgi.com>
Date: Wed, 09 Mar 2005 10:26:32 -0800
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
CC: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>, Jay Lan <jlan@engr.sgi.com>
Subject: Re: I/O and Memory accounting...
References: <1110374723.10590.116.camel@frecb000711.frec.bull.fr>
In-Reply-To: <1110374723.10590.116.camel@frecb000711.frec.bull.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought you planned to read from CSA pacct file?

Well, while we are in discussion of whether to merge and
replace BSD accounting with CSA accounting, your proposed
change will provide you data on charater I/O in a BSD pacct
file. I supposed you do not need to have seperate fields on
character-read and character-written? CSA will provide the
data separately.

CSA writes the data to a CSA pacct file in a similar way as
BSD on exit callback at do_acct_process(). The CSA's exit
callback is implemented as a loadable module. The CSA
project and code can be downloaded at
http://oss.sgi.com/projects/csa.

Cheers,
  - jay


Guillaume Thouvenin wrote:
> Hello,
> 
>   In the ChangeLog-2.6.11 file I read that the enhanced I/O accounting
> data patch and the enhanced memory accounting data collection patch were
> added. It's cool but I don't see how this stuff is used because
> information is never dump in a file or send to an accounting application
> (or I miss something). 
>  
>   Maybe we should update the ac_io in the "struct acct"? Thus, values
> will be dump in the accounting file. Maybe it could be something like:
> 
> --- acct.c.orig	2005-03-09 14:17:07.000000000 +0100
> +++ acct.c	2005-03-09 14:18:20.000000000 +0100
> @@ -477,8 +477,8 @@ static void do_acct_process(long exitcod
>  	}
>  	vsize = vsize / 1024;
>  	ac.ac_mem = encode_comp_t(vsize);
> -	ac.ac_io = encode_comp_t(0 /* current->io_usage */);	/* %% */
> -	ac.ac_rw = encode_comp_t(ac.ac_io / 1024);
> +	ac.ac_io = encode_comp_t(current->rchar + current->wchar);
> +	ac.ac_rw = encode_comp_t(0);
>  	ac.ac_minflt = encode_comp_t(current->signal->min_flt +
>  				     current->group_leader->min_flt);
>  	ac.ac_majflt = encode_comp_t(current->signal->maj_flt +
> 
> 
> For memory and read/write syscall we may add new fields. 
> 
> Best regards,
> Guillaume
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

