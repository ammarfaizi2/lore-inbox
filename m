Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVBXNTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVBXNTa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 08:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVBXNTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 08:19:30 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:4234 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262340AbVBXNT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 08:19:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TC+Z6eue66Kb3xK9vU9IKsFPYtRAYSOcZ9Jr1/LYVetTSg7IXHZuoVmcdDSt7q7BqGJSP64hqwXTNsQDd1gtwh0JVkZJsRGn9KvlAzRXzffGCAFkXmhw44DgqnZhFtSAMRe8QysvGcJrBmCPCrj+AS7IU/IRf+61TMd+m29c9n0=
Message-ID: <58cb370e05022405192b2e91da@mail.gmail.com>
Date: Thu, 24 Feb 2005 14:19:25 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-rc4-mm1 (VFS: Cannot open root device "301")
Cc: elenstev@mesatop.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050223162539.2bd605b4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050223014233.6710fd73.akpm@osdl.org>
	 <421CB161.7060900@mesatop.com> <20050223121759.5cb270ee.akpm@osdl.org>
	 <421CFF5E.4030402@mesatop.com> <421D09AE.4090100@mesatop.com>
	 <20050223161653.7cb966c3.akpm@osdl.org>
	 <20050223162539.2bd605b4.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2005 16:25:39 -0800, Andrew Morton <akpm@osdl.org> wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Could someone try this?
> 
> Let's turn that into a real patch.
> 
> --- 25/drivers/ide/ide-probe.c~ide_init_disk-fix        Wed Feb 23 16:24:44 2005
> +++ 25-akpm/drivers/ide/ide-probe.c     Wed Feb 23 16:24:55 2005
> @@ -1269,7 +1269,7 @@ EXPORT_SYMBOL_GPL(ide_unregister_region)
>  void ide_init_disk(struct gendisk *disk, ide_drive_t *drive)
>  {
>         ide_hwif_t *hwif = drive->hwif;
> -       unsigned int unit = drive->select.all & (1 << 4);
> +       unsigned int unit = (drive->select.all >> 4) & 1;
> 
>         disk->major = hwif->major;
>         disk->first_minor = unit << PARTN_BITS;

thanks Andrew

fscking bitfields hopefully viro will kill them soon
