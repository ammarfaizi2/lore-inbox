Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUJAVmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUJAVmv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 17:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266749AbUJAVmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 17:42:44 -0400
Received: from mail0.lsil.com ([147.145.40.20]:33757 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S266756AbUJAVji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 17:39:38 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230C987@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "Ju, Seokmann" <sju@lsil.com>
Subject: RE: [PATCH]: megaraid 2.20.4: Fixes a data corruption bug
Date: Fri, 1 Oct 2004 17:39:26 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Understood. Thank you. I verified that module loads fine even without
CONFIG_COMPAT.

Thanks,
Sreenivas

>-----Original Message-----
>From: James Bottomley [mailto:James.Bottomley@SteelEye.com]
>Sent: Friday, October 01, 2004 4:58 PM
>To: Bagalkote, Sreenivas
>Cc: Mukker, Atul; 'linux-kernel@vger.kernel.org';
>'linux-scsi@vger.kernel.org'; 'bunk@fs.tum.de'; 'Andrew Morton';
>'Matt_Domsch@dell.com'; Ju, Seokmann
>Subject: RE: [PATCH]: megaraid 2.20.4: Fixes a data corruption bug
>
>
>On Fri, 2004-10-01 at 16:08, Bagalkote, Sreenivas wrote:
>> The submitted previous version of megaraid (2.20.3.1) had 
>> register_ioctl32_conversion & unregister_ioctl32_conversion 
>> defined to empty statements if CONFIG_COMPAT was _not_
>> defined.
>
>I know that.  However, when the empty statements were added to
>ioctl32.h, those had to be taken out of the megaraid driver.  That's
>this patch in the scsi-misc-2.6 tree:
>
> [PATCH] megaraid warning fix
>  
>  The ioctl32 conversion registration stubs are in ioctl32.h now.
>  
>  Signed-off-by: Andrew Morton <akpm@osdl.org>
>
>> But I think the preferred way was to have the occurances of 
>> (un)register_ioctl32_conversion in the code surrounded by 
>> #ifdef CONFIG_COMPAT ... #endif directly. In the kernel source
>> only register_ioctl32_conversion has these #ifdef .. #endif. The
>> unregister_ioctl32_conversion doesn't.
>
>The current preferred way is to use the empty definitions in
>linux/ioctl32.h which means there's no necessity for adding the #ifdef
>CONFIG_COMPAT.  The correct thing is to remove the #ifdef CONFIG_COMPAT
>from around the register_ioctl32... part.
>
>James
>
>
