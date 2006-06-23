Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWFWPdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWFWPdj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWFWPdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:33:38 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:44519 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751464AbWFWPdh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:33:37 -0400
In-Reply-To: <20060623020942.GA22889@redhat.com>
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       sfrench@samba.org
Subject: Re: remove useless checks in cifs connect.c
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 7.0 HF144 February 01, 2006
Message-ID: <OFA663BA0A.AC8EFA76-ON87257196.0055A492-86257196.005548D7@us.ibm.com>
From: Steven French <sfrench@us.ibm.com>
Date: Fri, 23 Jun 2006 10:38:19 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 7.0.1HF123 | April 14, 2006) at
 06/23/2006 09:40:58,
	Serialize complete at 06/23/2006 09:40:58
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks - I can make this change - but quite soon this whole routine is 
going away (as well as most of the fs/cifs/connect.c) as the session setup 
code in fs/cifs/sess.c.

The original SessSetup routines in fs/cifs/connect.c badly needed a 
rewrite


Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench at-sign us dot ibm dot com

Dave Jones <davej@redhat.com> wrote on 06/22/2006 09:09:42 PM:

> The ; at the end of the 2nd if line in this diff caught my eye.
> On closer inspection the whole line is unnecessary
> anyway as kfree(NULL) is ok.
> 
> Also nuked another one a few lines up.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- linux-2.6/fs/cifs/connect.c~   2006-06-22 22:07:04.000000000 -0400
> +++ linux-2.6/fs/cifs/connect.c   2006-06-22 22:07:42.000000000 -0400
> @@ -2822,15 +2822,13 @@ CIFSNTLMSSPNegotiateSessSetup(unsigned i
>                           = 0;
>                    } /* else no more room so create dummy domain string 
*/
>                    else {
> -                     if(ses->serverDomain)
> -                        kfree(ses->serverDomain);
> +                     kfree(ses->serverDomain);
>                       ses->serverDomain =
>                           kzalloc(2,
>                              GFP_KERNEL);
>                    }
>                 } else {   /* no room so create dummy domain and 
NOSstring */
> -                  if(ses->serverDomain);
> -                     kfree(ses->serverDomain);
> +                  kfree(ses->serverDomain);
>                    ses->serverDomain =
>                        kzalloc(2, GFP_KERNEL);
>                    if(ses->serverNOS)
> 
> -- 
> http://www.codemonkey.org.uk

