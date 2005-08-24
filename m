Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbVHXUOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVHXUOt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 16:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVHXUOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 16:14:48 -0400
Received: from mail.dvmed.net ([216.237.124.58]:53401 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932077AbVHXUOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 16:14:48 -0400
Message-ID: <430CD530.7000509@pobox.com>
Date: Wed, 24 Aug 2005 16:14:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] exterminate strtok - usr/gen_init_cpio.c
References: <200508242108.53198.jesper.juhl@gmail.com> <430CD4A1.80005@didntduck.org>
In-Reply-To: <430CD4A1.80005@didntduck.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> Jesper Juhl wrote:
> 
>> Convert strtok() use to strsep() in usr/gen_init_cpio.c
>>
>> I've compile tested this patch and it compiles fine.
>> I build a 2.6.13-rc6-mm2 kernel with the patch applied without 
>> problems, and
>> the resulting kernel boots and runs just fine (using it right now).
>> But despite this basic testing it would still be nice if someone would 
>> double-check that I haven't made some silly mistake that would break 
>> some other setup than mine.
>>
>>
>> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
>> ---
>>
>>  gen_init_cpio.c |   31 ++++++++++++++++++++++---------
>>  1 files changed, 22 insertions(+), 9 deletions(-)
>>
>> --- linux-2.6.13-rc6-mm2-orig/usr/gen_init_cpio.c    2005-06-17 
>> 21:48:29.000000000 +0200
>> +++ linux-2.6.13-rc6-mm2/usr/gen_init_cpio.c    2005-08-24 
>> 18:58:21.000000000 +0200
>> @@ -438,7 +438,7 @@ struct file_handler file_handler_table[]
>>  int main (int argc, char *argv[])
>>  {
>>      FILE *cpio_list;
>> -    char line[LINE_SIZE];
>> +    char *line, *ln;
>>      char *args, *type;
>>      int ec = 0;
>>      int line_nr = 0;
>> @@ -455,7 +455,14 @@ int main (int argc, char *argv[])
>>          exit(1);
>>      }
>>  
>> -    while (fgets(line, LINE_SIZE, cpio_list)) {
>> +    ln = malloc(LINE_SIZE);
> 
> 
> Why change to malloc()?  This is a userspace program.  It doesn't have 
> the kernel stack constraints.

Good catch, agreed.

I prefer the code as-is, with LINE_SIZE stack allocations.

	Jeff



