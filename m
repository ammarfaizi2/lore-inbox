Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWHHGLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWHHGLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 02:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWHHGLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 02:11:53 -0400
Received: from gw.goop.org ([64.81.55.164]:10732 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751241AbWHHGLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 02:11:53 -0400
Message-ID: <44D82B28.6010709@goop.org>
Date: Mon, 07 Aug 2006 23:11:52 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LOADER_TYPE for Xen in boot_params?
References: <44D3C261.6040800@goop.org> <44D3C397.6010202@zytor.com>
In-Reply-To: <44D3C397.6010202@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
>>
>> Should I be poking some Xen-specific value into the LOADER_TYPE 
>> field?  If so, what value?  Should I just claim 5?  And should this 
>> be Xen in particular, or reserve a value for 'hypervisor' and then 
>> have some other mechanism to distinguish which one?
>>
>
> It probably should be Xen in particular.  Send me a patch allocating 9 
> for Xen, and use that.

Claim an ID number for Xen in the LOADER_TYPE field.

Also, keep the table in zero-page.txt consistent with boot.txt.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>

diff -r 4f3c59461622 Documentation/i386/boot.txt
--- a/Documentation/i386/boot.txt	Mon Aug 07 12:01:49 2006 -0700
+++ b/Documentation/i386/boot.txt	Mon Aug 07 23:06:45 2006 -0700
@@ -181,6 +181,7 @@ filled out, however:
 	5  ELILO
 	7  GRuB
 	8  U-BOOT
+	9  Xen
 
 	Please contact <hpa@zytor.com> if you need a bootloader ID
 	value assigned.
diff -r 4f3c59461622 Documentation/i386/zero-page.txt
--- a/Documentation/i386/zero-page.txt	Mon Aug 07 12:01:49 2006 -0700
+++ b/Documentation/i386/zero-page.txt	Mon Aug 07 23:07:30 2006 -0700
@@ -63,6 +63,10 @@ 0x210	char		LOADER_TYPE, = 0, old one
 				2 for bootsect-loader
 				3 for SYSLINUX
 				4 for ETHERBOOT
+				5 for ELILO
+				7 for GRuB
+				8 for U-BOOT
+				9 for Xen
 				V = version
 0x211	char		loadflags:
 			bit0 = 1: kernel is loaded high (bzImage)


