Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266652AbUGVJ7C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266652AbUGVJ7C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 05:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUGVJ7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 05:59:02 -0400
Received: from mailr.eris.qinetiq.com ([128.98.1.9]:57558 "HELO
	qinetiq-tim.net") by vger.kernel.org with SMTP id S266849AbUGVJ65 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 05:58:57 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel oops while shutting down (2.6.8rc1)
Date: Thu, 22 Jul 2004 10:53:53 +0100
User-Agent: KMail/1.6.1
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>
References: <200407161011.36677.m.watts@eris.qinetiq.com> <Pine.LNX.4.58.0407201008460.21932@montezuma.fsmlabs.com> <Pine.LNX.4.58.0407201133520.23033@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0407201133520.23033@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407221053.53735.m.watts@eris.qinetiq.com>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.26.0.10; VDF: 6.26.0.38; host: mailr.qinetiq-tim.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I had to apply it by hand for some reason (I'm not running -mm1 if that makes 
a difference), but it's fixed the problem :)

Many Thanks

Mark.

> On Tue, 20 Jul 2004, Zwane Mwaikambo wrote:
> > On Mon, 19 Jul 2004, Mark Watts wrote:
> > > Sorry - read that as 'run lsmod'
> >
> > No problem, i seem to have fired off a premature email too, i'll eyeball
> > the patches on the bugzilla report
> > (http://bugme.osdl.org/process_bug.cgi).
>
> Does the following patch work for you?
>
> Index: linux-2.6.8-rc1-mm1/drivers/acpi/processor.c
> ===================================================================
> RCS file: /home/cvsroot/linux-2.6.8-rc1-mm1/drivers/acpi/processor.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 processor.c
> --- linux-2.6.8-rc1-mm1/drivers/acpi/processor.c	14 Jul 2004 04:56:25
> -0000	1.1.1.1 +++ linux-2.6.8-rc1-mm1/drivers/acpi/processor.c	20 Jul 2004
> 15:31:46 -0000 @@ -2372,8 +2372,10 @@ acpi_processor_remove (
>  	pr = (struct acpi_processor *) acpi_driver_data(device);
>
>  	/* Unregister the idle handler when processor #0 is removed. */
> -	if (pr->id == 0)
> +	if (pr->id == 0) {
>  		pm_idle = pm_idle_save;
> +		synchronize_kernel();
> +	}
>
>  	status = acpi_remove_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY,
>  		acpi_processor_notify);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA/46xBn4EFUVUIO0RAqbTAKD6KO90X0tpXtubYBkINf318F0sngCg6nwG
PtDz94xRmVoLtWedN35VwRw=
=JXmv
-----END PGP SIGNATURE-----
