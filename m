Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbUKIQYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbUKIQYV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 11:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbUKIQYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 11:24:20 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:26078 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S261574AbUKIQWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 11:22:50 -0500
Message-ID: <4190EED2.5040906@lsrfire.ath.cx>
Date: Tue, 09 Nov 2004 17:22:42 +0100
From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Move check for invalid chars to vfat_valid_longname()
References: <41901DD1.mail5VX1GOOYK@lsrfire.ath.cx>	<20041109013524.GB6835@neapel230.server4you.de> <87actr5ak8.fsf@devron.myhome.or.jp>
In-Reply-To: <87actr5ak8.fsf@devron.myhome.or.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:
> lsr@neapel230.server4you.de writes:
>>+	/* check for invalid characters */
>>+	for (p = name; p < name + len; p++) {
>>+		if (*p < 0x0020 || strchr("*?<>|\":\\", *p) != NULL)
>>+			return 0;
>>+	}
>>+
>> 	return 1;
>> }
>> 
>>@@ -636,10 +627,6 @@ static int vfat_build_slots(struct inode
>> 	if (res < 0)
>> 		goto out_free;
>> 
>>-	res = vfat_is_used_badchars(uname, ulen);
>>-	if (res < 0)
>>-		goto out_free;
>>-
>> 	res = vfat_create_shortname(dir, sbi->nls_disk, uname, ulen,
>> 				    msdos_name, &lcase);
>> 	if (res < 0)
> 
> 
> Some encodings is using the area of ascii code as second byte.

Yes. But..

> So, it can't.

We want to make sure filenames don't contain '*', '?' etc. It doesn't 
matter whether we check the VFS idea of the filename (a simple C string) 
or some other encoding of it, no?

Right now we check for 0x002A after xlate_to_uni(), after the patch we 
check for 0x2A (ASCII code of '*') before xlate_to_uni() etc. I just 
translated the Unicode chars back to ASCII and moved the check.

Am I missing something?

Thanks,
René
