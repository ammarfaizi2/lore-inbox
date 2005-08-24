Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVHXUjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVHXUjO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 16:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbVHXUjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 16:39:13 -0400
Received: from quark.didntduck.org ([69.55.226.66]:26032 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932162AbVHXUjN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 16:39:13 -0400
Message-ID: <430CDAFF.8070201@didntduck.org>
Date: Wed, 24 Aug 2005 16:39:27 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] exterminate strtok - usr/gen_init_cpio.c
References: <200508242108.53198.jesper.juhl@gmail.com>	 <430CD4A1.80005@didntduck.org> <430CD530.7000509@pobox.com> <9a87484905082413312b5a603a@mail.gmail.com>
In-Reply-To: <9a87484905082413312b5a603a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 8/24/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Brian Gerst wrote:
>>
>>>Jesper Juhl wrote:
>>>
>>>
>>>>Convert strtok() use to strsep() in usr/gen_init_cpio.c
>>>>
>>>>I've compile tested this patch and it compiles fine.
>>>>I build a 2.6.13-rc6-mm2 kernel with the patch applied without
>>>>problems, and
>>>>the resulting kernel boots and runs just fine (using it right now).
>>>>But despite this basic testing it would still be nice if someone would
>>>>double-check that I haven't made some silly mistake that would break
>>>>some other setup than mine.
>>>>
>>>>
>>>>Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
>>>>---
>>>>
>>>> gen_init_cpio.c |   31 ++++++++++++++++++++++---------
>>>> 1 files changed, 22 insertions(+), 9 deletions(-)
>>>>
>>>>--- linux-2.6.13-rc6-mm2-orig/usr/gen_init_cpio.c    2005-06-17
>>>>21:48:29.000000000 +0200
>>>>+++ linux-2.6.13-rc6-mm2/usr/gen_init_cpio.c    2005-08-24
>>>>18:58:21.000000000 +0200
>>>>@@ -438,7 +438,7 @@ struct file_handler file_handler_table[]
>>>> int main (int argc, char *argv[])
>>>> {
>>>>     FILE *cpio_list;
>>>>-    char line[LINE_SIZE];
>>>>+    char *line, *ln;
>>>>     char *args, *type;
>>>>     int ec = 0;
>>>>     int line_nr = 0;
>>>>@@ -455,7 +455,14 @@ int main (int argc, char *argv[])
>>>>         exit(1);
>>>>     }
>>>>
>>>>-    while (fgets(line, LINE_SIZE, cpio_list)) {
>>>>+    ln = malloc(LINE_SIZE);
>>>
>>>
>>>Why change to malloc()?  This is a userspace program.  It doesn't have
>>>the kernel stack constraints.
>>
>>Good catch, agreed.
>>
>>I prefer the code as-is, with LINE_SIZE stack allocations.
>>
> 
> The reason I did it like that was that strsep takes offense at
> strsep(&line, ...) when line is allocated on the stack. So I just
> changed it around to being malloc()'ed and things were good.
> 

Do this instead:
	char ln[LINE_SIZE], *line;

--
				Brian Gerst
