Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbSLBFYj>; Mon, 2 Dec 2002 00:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264936AbSLBFYj>; Mon, 2 Dec 2002 00:24:39 -0500
Received: from dp.samba.org ([66.70.73.150]:53916 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264908AbSLBFYh>;
	Mon, 2 Dec 2002 00:24:37 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bob Miller <rem@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL PATCH 2.5.48] Use min_t() instead of min() in fs/cifs/cifssmb.c 
In-reply-to: Your message of "Thu, 21 Nov 2002 14:28:38 -0800."
             <20021121222838.GA1431@doc.pdx.osdl.net> 
Date: Mon, 02 Dec 2002 16:06:14 +1100
Message-Id: <20021202053205.8C73A2C0F3@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021121222838.GA1431@doc.pdx.osdl.net> you write:
> 
> This change removes "duplicate 'const'" compiler warnings.

Um, might want to remove the const from min() and max(), which would
be much nicer.  It was only there because it worked fine with older
compilers, and I don't think it will effect code generation one bit.

Someone wanna test before and after?

Thanks,
Rusty.

> diff -Nru a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
> --- a/fs/cifs/cifssmb.c	Thu Nov 21 13:51:25 2002
> +++ b/fs/cifs/cifssmb.c	Thu Nov 21 13:51:26 2002
> @@ -483,9 +483,10 @@
>  	pSMB->OffsetLow = cpu_to_le32(lseek & 0xFFFFFFFF);
>  	pSMB->OffsetHigh = cpu_to_le32(lseek >> 32);
>  	pSMB->Remaining = 0;
> -	pSMB->MaxCount = cpu_to_le16(min(count,
> -					 (tcon->ses->maxBuf -
> -					  MAX_CIFS_HDR_SIZE) & 0xFFFFFF00));
> +	pSMB->MaxCount = cpu_to_le16(min_t(const unsigned int,
> +					   count,
> +					   (tcon->ses->maxBuf -
> +					    MAX_CIFS_HDR_SIZE) & 0xFFFFFF00));
>  	pSMB->MaxCountHigh = 0;
>  	pSMB->ByteCount = 0;  /* no need to do le conversion since it is 0 */
>  
> @@ -1023,9 +1024,10 @@
>  								   Protocol +
>  								   pSMBr->
>  								   DataOffset),
> -						      min(buflen,
> -							  (int) pSMBr->
> -							  DataCount) / 2);
> +						      min_t(const int,
> +							    buflen,
> +							    (int) pSMBr->
> +							    DataCount) / 2);
>  				cifs_strfromUCS_le(symlinkinfo,
>  						   (wchar_t *) ((char *)
>  								&pSMBr->
> @@ -1037,9 +1039,10 @@
>  			} else {
>  				strncpy(symlinkinfo,
>  					(char *) &pSMBr->hdr.Protocol +
> -					pSMBr->DataOffset, min(buflen, (int)
> -							       pSMBr->
> -							       DataCount));
> +					pSMBr->DataOffset, min_t(const int,
> +								 buflen,
> +								 pSMBr->
> +								 DataCount));
>  			}
>  			symlinkinfo[buflen] = 0;	/* just in case so the 
calling code does not go off the end of the buffer */
>  		}
> -- 
> Bob Miller					Email: rem@osdl.org
> Open Source Development Lab			Phone: 503.626.2455 Ext. 17
> 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
