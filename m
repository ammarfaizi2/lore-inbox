Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422901AbWJRUW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422901AbWJRUW5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422917AbWJRUW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:22:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:59141 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422904AbWJRUWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:22:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BMtUe5zAavxFw+vb7FNDelbQkn9+QOYxHh9U4dgyt/EoCpBfK87PidF51RDCTLuZ4gbE+VgemtBlQ3ythG3wRXWYu+SBGwp1StMX6jKvODF4GPr1L0L939QXqrgVLC8yadevIoz6BK4snCRXnj+Q65k5rlLTMa8ojiTf/+h5i3E=
Message-ID: <45368D20.7070701@googlemail.com>
Date: Wed, 18 Oct 2006 22:22:56 +0200
From: Gabriel C <nix.or.die@googlemail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060915)
MIME-Version: 1.0
To: Cedric Le Goater <clg@fr.ibm.com>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc2-mm1
References: <20061016230645.fed53c5b.akpm@osdl.org> <45367210.4040507@googlemail.com> <200610182118.31371.rjw@sisk.pl> <4536818E.3060505@fr.ibm.com>
In-Reply-To: <4536818E.3060505@fr.ibm.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater wrote:
> Rafael J. Wysocki wrote:
>   
>> On Wednesday, 18 October 2006 20:27, Gabriel C wrote:
>>     
>>> Andrew Morton wrote:
>>>       
>>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm1/
>>>>   
>>>>         
>>> Hello,
>>>
>>> I got this build error with 2.6.19-rc2-mm1:
>>>
>>> CHK include/linux/compile.h
>>> UPD include/linux/compile.h
>>> CC init/version.o
>>> LD init/built-in.o
>>> LD .tmp_vmlinux1
>>> mm/built-in.o: In function `xip_file_write':
>>> (.text+0x19a47): undefined reference to `filemap_copy_from_user'
>>> make: *** [.tmp_vmlinux1] Error 1
>>>       
>> \metoo
>>     
>
> Here's a fix i sent to andrew.
>
> C.
>
>
> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
> ---
>  mm/filemap_xip.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: 2.6.19-rc2-mm1/mm/filemap_xip.c
> ===================================================================
> --- 2.6.19-rc2-mm1.orig/mm/filemap_xip.c
> +++ 2.6.19-rc2-mm1/mm/filemap_xip.c
> @@ -317,7 +317,7 @@ __xip_file_write(struct file *filp, cons
>  			break;
>  		}
>  
> -		copied = filemap_copy_from_user(page, offset, buf, bytes);
> +		copied = filemap_copy_from_user_atomic(page, offset, buf, bytes);
>  		flush_dcache_page(page);
>  		if (likely(copied > 0)) {
>  			status = copied;
>
>   

This patch fixed the problem here. Thx.

Gabriel
