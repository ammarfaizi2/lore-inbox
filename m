Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbTESKFG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 06:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTESKFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 06:05:06 -0400
Received: from landfill.ihatent.com ([217.13.24.22]:44928 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id S262169AbTESKE7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 06:04:59 -0400
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@digeo.com>,
       "" <linux-kernel@vger.kernel.org>, "" <linux-mm@kvack.org>
Subject: Re: [OOPS] 2.5.69-mm6
References: <20030516015407.2768b570.akpm@digeo.com>
	<87fznfku8z.fsf@lapper.ihatent.com>
	<20030516180848.GW8978@holomorphy.com>
	<20030516185638.GA19669@suse.de>
	<20030516191711.GX8978@holomorphy.com>
	<Pine.LNX.4.50.0305162322360.2023-100000@montezuma.mastecende.com>
	<Pine.LNX.4.50.0305170937350.1910-100000@montezuma.mastecende.com>
	<87u1brbazl.fsf@lapper.ihatent.com>
	<Pine.LNX.4.50.0305190431130.28750-100000@montezuma.mastecende.com>
	<873cjbjp0b.fsf@lapper.ihatent.com>
	<Pine.LNX.4.50.0305190452460.28750-100000@montezuma.mastecende.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 19 May 2003 12:18:11 +0200
In-Reply-To: <Pine.LNX.4.50.0305190452460.28750-100000@montezuma.mastecende.com>
Message-ID: <87he7r2qak.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The oops is gone, and I'm now left with this one:

Linux agpgart interface v0.100 (c) Dave Jones
[drm] Initialized radeon 1.8.0 20020828 on minor 0
[drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
[drm:radeon_unlock] *ERROR* Process 4421 using kernel context 0

This one only seems to appear when I'm compiling it modular.

mvh,
A

Zwane Mwaikambo <zwane@linuxpower.ca> writes:

> Could you try with this patch and modular too?
> 
> ? linux-2.5-devel/drivers/char/agp/.amd-k7-agp.c.swp
> Index: linux-2.5-devel/drivers/char/agp/ali-agp.c
> ===================================================================
> RCS file: /home/cvs/linux-2.5/drivers/char/agp/ali-agp.c,v
> retrieving revision 1.12
> diff -u -p -B -r1.12 ali-agp.c
> --- linux-2.5-devel/drivers/char/agp/ali-agp.c	11 May 2003 18:53:08 -0000	1.12
> +++ linux-2.5-devel/drivers/char/agp/ali-agp.c	19 May 2003 07:58:39 -0000
> @@ -391,7 +391,7 @@ static struct pci_device_id agp_ali_pci_
>  
>  MODULE_DEVICE_TABLE(pci, agp_ali_pci_table);
>  
> -static struct __initdata pci_driver agp_ali_pci_driver = {
> +static struct pci_driver agp_ali_pci_driver = {
>  	.name		= "agpgart-ali",
>  	.id_table	= agp_ali_pci_table,
>  	.probe		= agp_ali_probe,
> Index: linux-2.5-devel/drivers/char/agp/amd-k7-agp.c
> ===================================================================
> RCS file: /home/cvs/linux-2.5/drivers/char/agp/amd-k7-agp.c,v
> retrieving revision 1.11
> diff -u -p -B -r1.11 amd-k7-agp.c
> --- linux-2.5-devel/drivers/char/agp/amd-k7-agp.c	11 May 2003 18:53:08 -0000	1.11
> +++ linux-2.5-devel/drivers/char/agp/amd-k7-agp.c	19 May 2003 07:58:40 -0000
> @@ -469,7 +469,7 @@ static struct pci_device_id agp_amdk7_pc
>  
>  MODULE_DEVICE_TABLE(pci, agp_amdk7_pci_table);
>  
> -static struct __initdata pci_driver agp_amdk7_pci_driver = {
> +static struct pci_driver agp_amdk7_pci_driver = {
>  	.name		= "agpgart-amdk7",
>  	.id_table	= agp_amdk7_pci_table,
>  	.probe		= agp_amdk7_probe,
> Index: linux-2.5-devel/drivers/char/agp/amd-k8-agp.c
> ===================================================================
> RCS file: /home/cvs/linux-2.5/drivers/char/agp/amd-k8-agp.c,v
> retrieving revision 1.16
> diff -u -p -B -r1.16 amd-k8-agp.c
> --- linux-2.5-devel/drivers/char/agp/amd-k8-agp.c	14 May 2003 01:31:52 -0000	1.16
> +++ linux-2.5-devel/drivers/char/agp/amd-k8-agp.c	19 May 2003 07:58:40 -0000
> @@ -343,7 +343,7 @@ static struct pci_device_id agp_amdk8_pc
>  
>  MODULE_DEVICE_TABLE(pci, agp_amdk8_pci_table);
>  
> -static struct __initdata pci_driver agp_amdk8_pci_driver = {
> +static struct pci_driver agp_amdk8_pci_driver = {
>  	.name		= "agpgart-amd-k8",
>  	.id_table	= agp_amdk8_pci_table,
>  	.probe		= agp_amdk8_probe,
> Index: linux-2.5-devel/drivers/char/agp/hp-agp.c
> ===================================================================
> RCS file: /home/cvs/linux-2.5/drivers/char/agp/hp-agp.c,v
> retrieving revision 1.12
> diff -u -p -B -r1.12 hp-agp.c
> --- linux-2.5-devel/drivers/char/agp/hp-agp.c	11 May 2003 18:53:08 -0000	1.12
> +++ linux-2.5-devel/drivers/char/agp/hp-agp.c	19 May 2003 07:58:40 -0000
> @@ -400,7 +400,7 @@ static struct pci_device_id agp_hp_pci_t
>  
>  MODULE_DEVICE_TABLE(pci, agp_hp_pci_table);
>  
> -static struct __initdata pci_driver agp_hp_pci_driver = {
> +static struct pci_driver agp_hp_pci_driver = {
>  	.name		= "agpgart-hp",
>  	.id_table	= agp_hp_pci_table,
>  	.probe		= agp_hp_probe,
> Index: linux-2.5-devel/drivers/char/agp/i460-agp.c
> ===================================================================
> RCS file: /home/cvs/linux-2.5/drivers/char/agp/i460-agp.c,v
> retrieving revision 1.12
> diff -u -p -B -r1.12 i460-agp.c
> --- linux-2.5-devel/drivers/char/agp/i460-agp.c	11 May 2003 18:53:08 -0000	1.12
> +++ linux-2.5-devel/drivers/char/agp/i460-agp.c	19 May 2003 07:58:40 -0000
> @@ -600,7 +600,7 @@ static struct pci_device_id agp_intel_i4
>  
>  MODULE_DEVICE_TABLE(pci, agp_intel_i460_pci_table);
>  
> -static struct __initdata pci_driver agp_intel_i460_pci_driver = {
> +static struct pci_driver agp_intel_i460_pci_driver = {
>  	.name		= "agpgart-intel-i460",
>  	.id_table	= agp_intel_i460_pci_table,
>  	.probe		= agp_intel_i460_probe,
> Index: linux-2.5-devel/drivers/char/agp/intel-agp.c
> ===================================================================
> RCS file: /home/cvs/linux-2.5/drivers/char/agp/intel-agp.c,v
> retrieving revision 1.16
> diff -u -p -B -r1.16 intel-agp.c
> --- linux-2.5-devel/drivers/char/agp/intel-agp.c	13 May 2003 18:45:44 -0000	1.16
> +++ linux-2.5-devel/drivers/char/agp/intel-agp.c	19 May 2003 07:58:41 -0000
> @@ -1450,7 +1450,7 @@ static struct pci_device_id agp_intel_pc
>  
>  MODULE_DEVICE_TABLE(pci, agp_intel_pci_table);
>  
> -static struct __initdata pci_driver agp_intel_pci_driver = {
> +static struct pci_driver agp_intel_pci_driver = {
>  	.name		= "agpgart-intel",
>  	.id_table	= agp_intel_pci_table,
>  	.probe		= agp_intel_probe,
> Index: linux-2.5-devel/drivers/char/agp/nvidia-agp.c
> ===================================================================
> RCS file: /home/cvs/linux-2.5/drivers/char/agp/nvidia-agp.c,v
> retrieving revision 1.2
> diff -u -p -B -r1.2 nvidia-agp.c
> --- linux-2.5-devel/drivers/char/agp/nvidia-agp.c	11 May 2003 18:53:08 -0000	1.2
> +++ linux-2.5-devel/drivers/char/agp/nvidia-agp.c	19 May 2003 07:58:41 -0000
> @@ -354,7 +354,7 @@ static struct pci_device_id agp_nvidia_p
>  
>  MODULE_DEVICE_TABLE(pci, agp_nvidia_pci_table);
>  
> -static struct __initdata pci_driver agp_nvidia_pci_driver = {
> +static struct pci_driver agp_nvidia_pci_driver = {
>  	.name		= "agpgart-nvidia",
>  	.id_table	= agp_nvidia_pci_table,
>  	.probe		= agp_nvidia_probe,
> Index: linux-2.5-devel/drivers/char/agp/sis-agp.c
> ===================================================================
> RCS file: /home/cvs/linux-2.5/drivers/char/agp/sis-agp.c,v
> retrieving revision 1.12
> diff -u -p -B -r1.12 sis-agp.c
> --- linux-2.5-devel/drivers/char/agp/sis-agp.c	11 May 2003 18:53:08 -0000	1.12
> +++ linux-2.5-devel/drivers/char/agp/sis-agp.c	19 May 2003 07:58:41 -0000
> @@ -240,7 +240,7 @@ static struct pci_device_id agp_sis_pci_
>  
>  MODULE_DEVICE_TABLE(pci, agp_sis_pci_table);
>  
> -static struct __initdata pci_driver agp_sis_pci_driver = {
> +static struct pci_driver agp_sis_pci_driver = {
>  	.name		= "agpgart-sis",
>  	.id_table	= agp_sis_pci_table,
>  	.probe		= agp_sis_probe,
> Index: linux-2.5-devel/drivers/char/agp/sworks-agp.c
> ===================================================================
> RCS file: /home/cvs/linux-2.5/drivers/char/agp/sworks-agp.c,v
> retrieving revision 1.13
> diff -u -p -B -r1.13 sworks-agp.c
> --- linux-2.5-devel/drivers/char/agp/sworks-agp.c	11 May 2003 18:53:08 -0000	1.13
> +++ linux-2.5-devel/drivers/char/agp/sworks-agp.c	19 May 2003 07:58:41 -0000
> @@ -532,7 +532,7 @@ static struct pci_device_id agp_serverwo
>  
>  MODULE_DEVICE_TABLE(pci, agp_serverworks_pci_table);
>  
> -static struct __initdata pci_driver agp_serverworks_pci_driver = {
> +static struct pci_driver agp_serverworks_pci_driver = {
>  	.name		= "agpgart-serverworks",
>  	.id_table	= agp_serverworks_pci_table,
>  	.probe		= agp_serverworks_probe,
> Index: linux-2.5-devel/drivers/char/agp/via-agp.c
> ===================================================================
> RCS file: /home/cvs/linux-2.5/drivers/char/agp/via-agp.c,v
> retrieving revision 1.16
> diff -u -p -B -r1.16 via-agp.c
> --- linux-2.5-devel/drivers/char/agp/via-agp.c	11 May 2003 18:53:08 -0000	1.16
> +++ linux-2.5-devel/drivers/char/agp/via-agp.c	19 May 2003 07:58:41 -0000
> @@ -466,7 +466,7 @@ static struct pci_device_id agp_via_pci_
>  MODULE_DEVICE_TABLE(pci, agp_via_pci_table);
>  
>  
> -static struct __initdata pci_driver agp_via_pci_driver = {
> +static struct pci_driver agp_via_pci_driver = {
>  	.name		= "agpgart-via",
>  	.id_table	= agp_via_pci_table,
>  	.probe		= agp_via_probe,
> 
> -- 
> function.linuxpower.ca

- -- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE+yK9gCQ1pa+gRoggRAkSVAJ46yUoSc/FmRzhdxOYqIru/ztslVQCgkiI+
uEbQyyQAALefm3elind1odU=
=Y+yP
-----END PGP SIGNATURE-----
