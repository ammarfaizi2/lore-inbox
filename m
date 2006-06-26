Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWFZEIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWFZEIS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 00:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWFZEIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 00:08:18 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:25324 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751500AbWFZEIR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 00:08:17 -0400
In-Reply-To: <20060625231329.GM23314@stusta.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-cifs-client@lists.samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] fs/cifs/cifsproto.h: remove #ifdef around small_smb_init_no_tc() prototype
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 7.0 HF144 February 01, 2006
Message-ID: <OFA1426D0C.77A63AA3-ON87257199.0016018A-86257199.0015D47A@us.ibm.com>
From: Steven French <sfrench@us.ibm.com>
Date: Sun, 25 Jun 2006 23:05:19 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 7.0.1HF123 | April 14, 2006) at
 06/25/2006 22:15:44,
	Serialize complete at 06/25/2006 22:15:44
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The equivalent fix should already be merged in now

 The missed ifdef removal happened a couple days ago as I turned on the 
previously experimental  new session establishment code (in 
fs/cifs/sess.c) and turn off the older code in fs/cifs/connect.c 
(necessary for legacy win9x lanman server support and more secure (ntlmv2) 
session establishment support).    I have a few relatively minor changes 
to make to fs/cifs/sess.c (including changing buffer allocation in a few 
places, an ntlmv2 fix for support of one server type) still.


Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench at-sign us dot ibm dot com

Adrian Bunk <bunk@stusta.de> wrote on 06/25/2006 06:13:29 PM:

> On Sat, Jun 24, 2006 at 06:19:14AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.17-mm1:
> >...
> > +cifs-build-fix.patch
> > 
> >  Fix git-cifs.patch.
> >...
> 
> Let's hope gcc guesses the prototye of the function right.
> 
> Otherwise, this patch has turned a compile error into a nasty runtime 
> error (in many cases, the stack is garbage).
> 
> The -Werror-implicit-function-declaration gcc flag would turn such 
> possible problems into compile errors.
> 
> This patch removes the (never required) #ifdef from the prototype of 
> thie function in fs/cifs/cifsproto.h. 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.17-mm2-full/fs/cifs/cifsproto.h.old   2006-06-26 00:
> 00:56.000000000 +0200
> +++ linux-2.6.17-mm2-full/fs/cifs/cifsproto.h   2006-06-26 00:01:02.
> 000000000 +0200
> @@ -64,11 +64,9 @@
>  extern void header_assemble(struct smb_hdr *, char /* command */ ,
>               const struct cifsTconInfo *, int /* length of
>               fixed section (word count) in two byte units */);
> -#ifdef CONFIG_CIFS_EXPERIMENTAL
>  extern int small_smb_init_no_tc(const int smb_cmd, const int wct,
>              struct cifsSesInfo *ses,
>              void ** request_buf);
> -#endif
>  extern int CIFS_SessSetup(unsigned int xid, struct cifsSesInfo *ses,
>                const int stage, 
>                const struct nls_table *nls_cp);
> 

