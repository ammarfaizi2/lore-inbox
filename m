Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268060AbUJNWvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268060AbUJNWvA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268120AbUJNWsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:48:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:5081 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S268090AbUJNWnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:43:06 -0400
Message-ID: <416EFEF2.8040005@osdl.org>
Date: Thu, 14 Oct 2004 15:34:26 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Panin <pazke@donpac.ru>
CC: Raj <inguva@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: [PATCH] VISWS: disable APM
References: <b2fa632f04101204385c09459f@mail.gmail.com>	    <416CB8FC.9020503@osdl.org> <b2fa632f041012222745006916@mail.gmail.com>    <416CBC9C.8010905@osdl.org> <21579.80.80.111.240.1097745358.squirrel@80.80.111.240>
In-Reply-To: <21579.80.80.111.240.1097745358.squirrel@80.80.111.240>
Content-Type: multipart/mixed;
 boundary="------------070905020801050308040405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070905020801050308040405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

(full email thread here:
   http://marc.theaimsgroup.com/?t=109758139300007&r=1&w=2
)

Andrey Panin wrote:
>>Raj wrote:
>>
>>>>>The build failed with an error 'Undefined reference to
>>>>>machine_real_restart'
>>>>
>>>>Yep, I see that also.
>>>>
>>>>>Can this be fixed ?? At the very least, hide APM options #if
>>>>>!(CONFIG_PC) ??
>>>>
>>>i am not aware much about the apm dependencies. maintainers might answer
>>>this more correctly.
>>
>>True.  I should have copied Andrey on it earlier.
>>
>>Andrey, any thoughts about how to keep VISWS from building APM
>>support?  use Kconfig?  or does VISWS support APM?
>
> IMHO Kconfig is the best choise. VISWS has no PC compatible BIOS at all,
> it uses ARC compilant firmware for startup and configuration. Even though
> this firmware does limited BIOS emulation for running ROMs on PCI cards, i
> dont think it has working APM BIOS implementation.

Raj, can you test this patch?  It WorksForMe.

It disables APM & P4THERMAL support for X86_VISWS so that VISWS
builds correctly.

-- 
~Randy

--------------070905020801050308040405
Content-Type: text/x-patch;
 name="visws_noapm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="visws_noapm.patch"


Prevent X86_VISWS config from building APM support.
APM isn't supported and it won't build if attempted.
Also disable P4THERMAL for VISWS.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 arch/i386/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./arch/i386/Kconfig~visws_noapm ./arch/i386/Kconfig
--- ./arch/i386/Kconfig~visws_noapm	2004-10-11 10:54:31.019559744 -0700
+++ ./arch/i386/Kconfig	2004-10-14 09:52:24.131743344 -0700
@@ -584,7 +584,7 @@ config X86_MCE_NONFATAL
 
 config X86_MCE_P4THERMAL
 	bool "check for P4 thermal throttling interrupt."
-	depends on X86_MCE && (X86_UP_APIC || SMP)
+	depends on X86_MCE && (X86_UP_APIC || SMP) && !X86_VISWS
 	help
 	  Enabling this feature will cause a message to be printed when the P4
 	  enters thermal throttling.
@@ -879,7 +879,7 @@ source kernel/power/Kconfig
 source "drivers/acpi/Kconfig"
 
 menu "APM (Advanced Power Management) BIOS Support"
-depends on PM
+depends on PM && !X86_VISWS
 
 config APM
 	tristate "APM (Advanced Power Management) BIOS support"

--------------070905020801050308040405--
