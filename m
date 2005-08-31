Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbVHaN1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVHaN1X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 09:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVHaN1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 09:27:23 -0400
Received: from NS8.Sony.CO.JP ([137.153.0.33]:3215 "EHLO ns8.sony.co.jp")
	by vger.kernel.org with ESMTP id S964796AbVHaN1W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 09:27:22 -0400
Message-ID: <4315B032.2090502@sm.sony.co.jp>
Date: Wed, 31 Aug 2005 22:27:14 +0900
From: "Machida, Hiroyuki" <machida@sm.sony.co.jp>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][FAT] FAT dirent scan with hin take #3
References: <4313CBEF.9020505@sm.sony.co.jp> <4313E578.8070100@sm.sony.co.jp>	 <874q979qdj.fsf@devron.myhome.or.jp> <43156963.8020203@sm.sony.co.jp> <84144f0205083103031a858c15@mail.gmail.com>
In-Reply-To: <84144f0205083103031a858c15@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> On 8/31/05, Machida, Hiroyuki <machida@sm.sony.co.jp> wrote:
> 
>>+inline
>>+static int hint_index_body(const unsigned char *name, int name_len, int check_null)
>>+{
>>+       int i;
>>+       int val = 0;
>>+       unsigned char *p = (unsigned char *) name;
>>+       int id = current->pid;
>>+
>>+       for (i=0; i<name_len; i++) {
>>+               if (check_null && !*p) break;
>>+               val = ((val << 1) & 0xfe) | ((val & 0x80) ? 1 : 0);
>>+               val ^= *p;
>>+               p ++;
>>+       }
>>+       id = ((id >> 8) & 0xf) ^ (id & 0xf);
>>+       val = (val << 1) | (id & 1);
>>+       return val & (FAT_SCAN_NWAY-1);
> 
> 
> Couldn't you use jhash() from <linux/jhash.h> here?
> 
>                                  Pekka
Thanks, I'll replace it with functions in jhash.h, then
check performance again.

-- 
Hiroyuki Machida		machida@sm.sony.co.jp		

