Return-Path: <linux-kernel-owner+w=401wt.eu-S932209AbWLLSiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWLLSiJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 13:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWLLSiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 13:38:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:48781 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbWLLSiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 13:38:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qfSECaDTMD3rBj+eixd8giF894l7G0zqyE2AAFA6ZxS+CsTjTIpCsdTDck1cjtZhAM+WCq2eg8q9tCGngz1r4NN23VDN7iFPmLS+ugwsg7LcpK2laH3fpA3rbATio6Xz/LpdoqBRBQUJqqKCZQx23YureI2fV/GGnD0GIoJpLSg=
Message-ID: <625fc13d0612121038l22a2b252v3d3773caa8826e41@mail.gmail.com>
Date: Tue, 12 Dec 2006 12:38:05 -0600
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH/RFC] Delete JFFS (version 1)
Cc: "Jeff Garzik" <jeff@garzik.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, jffs-dev@axis.com,
       "David Woodhouse" <dwmw2@infradead.org>
In-Reply-To: <20061212095359.51483704.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <457EA2FE.3050206@garzik.org>
	 <20061212095359.51483704.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/06, Andrew Morton <akpm@osdl.org> wrote:
> On Tue, 12 Dec 2006 07:39:26 -0500
> Jeff Garzik <jeff@garzik.org> wrote:
>
> > I have created the 'kill-jffs' branch of
> > git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git that
> > removes fs/jffs.
> >
> > I argue that you can count the users (who aren't on 2.4) on one hand,
> > and developers don't seem to have cared for it in ages.
> >
> > People are already talking about jffs2 replacements, so I propose we zap
> > jffs in 2.6.21.
>
> It would be good to provide unignorable notice of this in 2.6.20.  Via a
> loud printk, or perhaps even CONFIG_BROKEN or CONFIG_EMBEDDED.

Something like the below?

Make CONFIG_JFFS depend on CONFIG_BROKEN

Signed-off-by: Josh Boyer <jwboyer@gmail.com>

diff --git a/fs/Kconfig b/fs/Kconfig
index b3b5aa0..4ac367d 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1204,13 +1204,16 @@ config EFS_FS

 config JFFS_FS
 	tristate "Journalling Flash File System (JFFS) support"
-	depends on MTD && BLOCK
+	depends on MTD && BLOCK && BROKEN
 	help
 	  JFFS is the Journalling Flash File System developed by Axis
 	  Communications in Sweden, aimed at providing a crash/powerdown-safe
 	  file system for disk-less embedded devices. Further information is
 	  available at (<http://developer.axis.com/software/jffs/>).

+	  NOTE: This filesystem is deprecated and is scheduled for removal in
+	  2.6.21.  See Documentation/feature-removal-schedule.txt
+
 config JFFS_FS_VERBOSE
 	int "JFFS debugging verbosity (0 = quiet, 3 = noisy)"
 	depends on JFFS_FS
