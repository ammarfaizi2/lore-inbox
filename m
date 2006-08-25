Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWHYUVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWHYUVW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWHYUVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:21:22 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20496 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932394AbWHYUVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:21:21 -0400
Date: Fri, 25 Aug 2006 22:21:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Konrad Rzeszutek <konradr@us.ibm.com>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>
Subject: Re: [PATCH 1/2] Add SATA support to libsas
Message-ID: <20060825202120.GY19810@stusta.de>
References: <44DBE943.4080303@us.ibm.com> <20060825194338.GA6020@andromeda.dapyr.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825194338.GA6020@andromeda.dapyr.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 03:43:38PM -0400, Konrad Rzeszutek wrote:
> On Thu, Aug 10, 2006 at 07:19:47PM -0700, Darrick J. Wong wrote:
> > Hook the scsi_host_template functions in libsas to delegate
> > functionality to libata when appropriate.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> > 
> > diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
> > index b0705ee..76bbb9f 100644
> > --- a/drivers/scsi/libsas/sas_discover.c
> > +++ b/drivers/scsi/libsas/sas_discover.c
> 
> (...)
> 
> >  /* ---------- Domain device ---------- */
> > @@ -626,4 +634,8 @@ void sas_unregister_devices(struct sas_h
> >  
> >  void sas_init_dev(struct domain_device *);
> >  
> > +extern void sas_target_destroy(struct scsi_target *);
> > +extern int sas_slave_alloc(struct scsi_device *);
> > +extern int sas_ioctl(struct scsi_device *sdev, int cmd, void __user *arg);
> > +
> 
> Those should not be 'extern' otherwise the EXPORT_SYMBOL functions 
> won't be found when the aic94xx is built as a module.

The "extern"s can be dropped since they don't have any effect, but 
I don't see what problem you are thinking of.

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

