Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265544AbTFRVfl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 17:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265547AbTFRVfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 17:35:41 -0400
Received: from host204.cisp.cc ([65.196.203.204]:44045 "EHLO
	nocmailsvc004.allthesites.org") by vger.kernel.org with ESMTP
	id S265544AbTFRVff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 17:35:35 -0400
From: "Thomas Molina" <tmolina@copper.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Panic while upgrading from 2.4.20 to 2.5.70
Date: Wed, 18 Jun 2003 17:48:03 -0400
Message-ID: <MIECJFNNBOIGKGCCGDDECEANCBAA.tmolina@copper.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Sourabh Ladha (EED) wrote:
>> Hi,
>>
>> [I know this has been discussed before but I tried the previous fixes
proposed without luck..so]
>>
>> I was trying to upgrade my kernel from 2.4.20 to 2.5.70. (I am running
RedHat 9). After getting the sources I did:
>>
>> make clean; make mrproper; make distclean; make menuconfig; make bzImage;
make modules; make modules_install; make install   >(got past all of these)
>>
>> The make install updated my grub.conf as well...
>
>Just a wild guess:  did you upgrade modutils to module-init-tools?  2.5.x
won't be happy
>until you do.


Actually, I have seen similar before.  It happens when you install a new
kernel on a RedHat system which requires an initrd to boot.  It happens
specifically because you upgrade module-init-tools.  The upgraded
module-init-tools replaces files used by the previous version of the
utilities and creating links to them.  It appears that the RedHat system
fails to find the proper version of the files it needs to build the initrd
image and therefor fails when it tries to load the ext3 modules.  It then
can't find the init on the disk because it can't read the filesystem and
gives the error seen.

The two options are either build a kernel with everything required to boot
built in rather than modular, or else reinstll the old module tools, install
the new kernel (this allows RedHat to create a good initrd image), and then
reinstall the new module init tools.

