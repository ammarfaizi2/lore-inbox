Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261634AbTCKV40>; Tue, 11 Mar 2003 16:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261636AbTCKV40>; Tue, 11 Mar 2003 16:56:26 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:53987 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261634AbTCKV4Z>; Tue, 11 Mar 2003 16:56:25 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Oleg Drokin <green@namesys.com>
Date: Wed, 12 Mar 2003 09:06:44 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15982.24052.21454.181492@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5] nfsd/export.c memleak.
In-Reply-To: message from Oleg Drokin on Tuesday March 11
References: <20030311175848.A3142@namesys.com>
X-Mailer: VM 7.08 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday March 11, green@namesys.com wrote:
> Hello!
> 
>      There is trivial memleak on error exit path in nfsd.
>      See the patch below.
>      Found with help of smatch + enhanced unfree script.

Thanks to all threee of you?
However in keeping with the style of surrounding code I will make it:


===== fs/nfsd/export.c 1.71 vs edited =====
--- 1.71/fs/nfsd/export.c	Tue Feb 25 13:08:50 2003
+++ edited/fs/nfsd/export.c	Tue Mar 11 17:55:18 2003
@@ -294,7 +294,10 @@
 
 	/* client */
 	len = qword_get(&mesg, buf, PAGE_SIZE);
-	if (len <= 0) return -EINVAL;
+	err = -EINVAL;
+	if (len <= 0)
+		goto out;
+	
 	err = -ENOENT;
 	dom = auth_domain_find(buf);
 	if (!dom)

NeilBrown
