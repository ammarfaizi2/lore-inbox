Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbTIWAES (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 20:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbTIWAD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 20:03:57 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:52940 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262272AbTIVXei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:34:38 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Muli Ben-Yehuda <mulix@mulix.org>
Date: Tue, 23 Sep 2003 09:34:18 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16239.34554.547683.65579@notabene.cse.unsw.edu.au>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, nfs@lists.sourceforge.net
Subject: Re: [PATCH] fix compile warning in fs/nfsd/nfs4xdr.c, 2.6.0-t5-cvs
In-Reply-To: message from Muli Ben-Yehuda on Sunday September 21
References: <20030921080923.GC4938@actcom.co.il>
X-Mailer: VM 7.17 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday September 21, mulix@mulix.org wrote:
> When compiling fs/nfsd/nfs4xdr.c, I get a warning:
> 
> fs/nfsd/nfs4xdr.c: In function `nfsd4_encode_open':
> fs/nfsd/nfs4xdr.c:1773: warning: `return' with a value, in function
> returning void
> 
> This patch fixes it. I'm not 100% sure about it, but it seems
> correct, and the return value is ignored anyway... 

As the return value is ignored, we really shouldn't be returning one.
I have just sent a patch to Linus which fixes this problem
differently: by making nfsd4_encode_open never return anything.

Thanks,
NeilBrown

> 
> diff --exclude-from /home/muli/p/dontdiff -Naur ../linux-2.5/fs/nfsd/nfs4xdr.c 2.6.0-t5-Werror/fs/nfsd/nfs4xdr.c
> --- ../linux-2.5/fs/nfsd/nfs4xdr.c	Tue Sep  2 12:51:06 2003
> +++ 2.6.0-t5-Werror/fs/nfsd/nfs4xdr.c	Sun Sep 21 10:18:19 2003
> @@ -1709,13 +1709,13 @@
>  }
>  
>  
> -static void
> +static int
>  nfsd4_encode_open(struct nfsd4_compoundres *resp, int nfserr, struct nfsd4_open *open)
>  {
>  	ENCODE_HEAD;
>  
>  	if (nfserr)
> -		return;
> +		return nfserr;
>  
>  	RESERVE_SPACE(36 + sizeof(stateid_t));
>  	WRITE32(open->op_stateid.si_generation);
> 
> -- 
> Muli Ben-Yehuda
> http://www.mulix.org
> 
