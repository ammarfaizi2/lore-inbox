Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWGCLg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWGCLg1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 07:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWGCLg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 07:36:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:1209 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751106AbWGCLg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 07:36:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Aai3GWMJyif4G8O+pm2oZbGye3fuBefHuEg8IOm3Q1HHuWETLfNT4DFL/bZZrSUsw8d8AEpfPaLgyb/FpvJkBL0IkzG/IKSZR87gcvtAshfk3caAfLSFoWAcNLcv3TYugYZrfrX7UxeNifnYBskHb+2SUD5GPZGBmmjNYAFlZNs=
Message-ID: <44A9013C.6070902@gmail.com>
Date: Mon, 03 Jul 2006 13:36:28 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: tigran@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org>	<6bffcb0e0607030350l497fdeb9ucb924e883fdad29@mail.gmail.com> <20060703035644.eccdd078.akpm@osdl.org>
In-Reply-To: <20060703035644.eccdd078.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 3 Jul 2006 12:50:26 +0200
> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
> 
>> Hi,
>>
>> On 03/07/06, Andrew Morton <akpm@osdl.org> wrote:
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/
>>>
>> Something is missing in drivers/base/firmware_class.c?
>>
>> WARNING: /lib/modules/2.6.17-mm6/kernel/arch/i386/kernel/microcode.ko
>> needs unknown symbol release_firmware
>> WARNING: /lib/modules/2.6.17-mm6/kernel/arch/i386/kernel/microcode.ko
>> needs unknown symbol request_firmware
>> WARNING: /lib/modules/2.6.17-mm6/kernel/arch/i386/kernel/microcode.ko
>> needs unknown symbol release_firmware
>> WARNING: /lib/modules/2.6.17-mm6/kernel/arch/i386/kernel/microcode.ko
>> needs unknown symbol request_firmware
>>
> 
> Presumably you'll need CONFIG_FW_LOADER?
> 

Yes, thanks. How about this patch?

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-mm/Documentation/dontdiff linux-mm-clean/arch/i386/Kconfig linux-mm/arch/i386/Kconfig
--- linux-mm-clean/arch/i386/Kconfig	2006-07-03 12:35:16.000000000 +0200
+++ linux-mm/arch/i386/Kconfig	2006-07-03 13:26:51.000000000 +0200
@@ -399,6 +399,7 @@ config X86_REBOOTFIXUPS

 config MICROCODE
 	tristate "/dev/cpu/microcode - Intel IA32 CPU microcode support"
+	depends on FW_LOADER
 	---help---
 	  If you say Y here and also to "/dev file system support" in the
 	  'File systems' section, you will be able to update the microcode on

