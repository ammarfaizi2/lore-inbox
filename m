Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbTIHStW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 14:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263485AbTIHStW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 14:49:22 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:55961 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S263484AbTIHStQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 14:49:16 -0400
Date: Mon, 8 Sep 2003 14:46:11 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Sam Ravnborg <sam@ravnborg.org>
cc: <zippel@linux-m68k.org>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [BK PATCH] build: config vs. everything else
In-Reply-To: <20030908181929.GA3627@mars.ravnborg.org>
Message-ID: <Pine.GSO.4.33.0309081439140.13584-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Sep 2003, Sam Ravnborg wrote:
>> The "bk send" is attached.  Below is the diff.  Excuse the "@/bin/true"...
>> It's the fastest way to get make to shutup.
>@: is faster, and used by kbuld today.

Noted.

>> +scripts/fixdep:
>> +	$(Q)$(MAKE) $(build)=scripts fixdep
>Try to avoid special targets when the full name is OK.
>No need for the fixdep target in scripts/Makefile

I seem to recall doing it this way for some reason.  But, the logic is the
same.  Oh, now I remember... there has to be an explicit target to get
make to not say "already up to date."

>>  targets += elfconfig.h
>> +
>Avoid random white space changes.

Then leave a blank line at the end of the file :-)

>> --- 1.9/scripts/kconfig/Makefile	Sun Aug 31 19:13:49 2003
>> +++ 1.10/scripts/kconfig/Makefile	Fri Sep  5 22:25:25 2003
>> @@ -21,7 +21,7 @@
>>  	$< -o arch/$(ARCH)/Kconfig
>>
>>  silentoldconfig: $(obj)/conf
>> -	$< -s arch/$(ARCH)/Kconfig
>> +	$(Q)$< -s arch/$(ARCH)/Kconfig
>Unrelated change.

Strictly speaking...

>> --- 1.9/scripts/kconfig/conf.c	Fri Jun  6 10:51:38 2003
>> +++ 1.10/scripts/kconfig/conf.c	Fri Sep  5 22:25:25 2003
>> @@ -532,7 +532,8 @@
>>  		}
>>  		break;
>>  	case ask_silent:
>> -		if (stat(".config", &tmpstat)) {
>> +		name = ".config";
>> +		if (stat(name, &tmpstat)) {
>>  			printf("***\n"
>>  				"*** You have not yet configured your kernel!\n"
>>  				"***\n"
>> @@ -541,6 +542,8 @@
>>  				"***\n");
>>  			exit(1);
>>  		}
>> +		conf_read(name);
>> +		break;
>
>What is the purpose of this change?
>If it fixes kconfig behaviour it should go separate to Roman Zippel.

"-s" (silent) should actually *be* silent.  If conf_read() is called without
a config file, it isn't silent. (The use of 'name' is merely an optimization.)

--Ricky


