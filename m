Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbVLKUHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbVLKUHX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 15:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbVLKUHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 15:07:23 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:45124 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750852AbVLKUHW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 15:07:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iiKgiU2xg605jK1eOLpJsaOcN/gPX8CY+wsLed3fg/2DWZw1RJfNggyU1vHEV36kGjQGQxVpOb3ddsHVySzOMVPmCjXKGb0ujPgSPssrzjdDik6a8mLemULuUuGeEt2aza0M3Ay9cw1dgUwPPZYOkoj2RPd7Vb41NPr+b9E+4RY=
Message-ID: <9a8748490512111207g15d107f5mf40c4fe696bfe978@mail.gmail.com>
Date: Sun, 11 Dec 2005 21:07:21 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] selinux: Remove unneeded k[cm]alloc() return value casts
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>,
       selinux@tycho.nsa.gov, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
In-Reply-To: <200512112035.02729.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512112035.02729.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resending this as it didn't seem to reach LKML on the first try -
sorry if you recieve it twice]


Remove redundant casts of k*alloc() return values in
security/selinux/ss/services.c

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 security/selinux/ss/services.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.15-rc5-git1-orig/security/selinux/ss/services.c  
2005-12-04 18:49:02.000000000 +0100
+++ linux-2.6.15-rc5-git1/security/selinux/ss/services.c       
2005-12-11 19:46:39.000000000 +0100
@@ -1712,11 +1712,11 @@ int security_get_bools(int *len, char **
                goto out;
        }

-       *names = (char**)kcalloc(*len, sizeof(char*), GFP_ATOMIC);
+       *names = kcalloc(*len, sizeof(char*), GFP_ATOMIC);
        if (!*names)
                goto err;

-       *values = (int*)kcalloc(*len, sizeof(int), GFP_ATOMIC);
+       *values = kcalloc(*len, sizeof(int), GFP_ATOMIC);
        if (!*values)
                goto err;

@@ -1724,7 +1724,7 @@ int security_get_bools(int *len, char **
                size_t name_len;
                (*values)[i] = policydb.bool_val_to_struct[i]->state;
                name_len = strlen(policydb.p_bool_val_to_name[i]) + 1;
-               (*names)[i] = (char*)kmalloc(sizeof(char) * name_len,
GFP_ATOMIC);
+               (*names)[i] = kmalloc(sizeof(char) * name_len, GFP_ATOMIC);
                if (!(*names)[i])
                        goto err;
                strncpy((*names)[i], policydb.p_bool_val_to_name[i], name_len);





--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
