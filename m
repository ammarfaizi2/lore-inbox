Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVKBRid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVKBRid (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 12:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVKBRic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 12:38:32 -0500
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:56992 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751092AbVKBRic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 12:38:32 -0500
Message-ID: <4368F966.20901@gmail.com>
Date: Wed, 02 Nov 2005 11:37:42 -0600
From: Hareesh Nagarajan <hnagar2@gmail.com>
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
CC: Linux Kernel Development <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] register_filesystem() must return -EEXIST if the filesystem
 with the same name is already registered
References: <43687BE4.3000708@gmail.com> <20051102090656.GA12912@localhost.localdomain>
In-Reply-To: <20051102090656.GA12912@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> On Wed, Nov 02, 2005 at 02:42:12AM -0600, Hareesh Nagarajan wrote:
>> If we have a look at the register_filesystem() function defined in 
>> fs/filesystems.c, we see that if a filesystem with a same name has 
>> already been registered then the find_filesystem() function will return 
>> NON-NULL otherwise it will return NULL.
>>
>> Hence, register_filesystem() should return EEXIST instead of EBUSY. 
>> Returning EBUSY is misleading (unless of course I'm missing something 
>> obvious) to the caller of register_filesystem().
> 
> This `slot' is buy, so EBUSY makes sense. Filesytem is not file, hence
> EEXIST doesn't apply IMHO.

Earlier this week, my calls to register_filesystem(struct 
file_system_type * fs) were failing returning an -EBUSY. Now I didn't 
know if it was failing because of:
	if (fs->next)	return -EBUSY;
Or:
	p = find_filesystem(fs->name);
         if (*p)	res = -EBUSY;
	...
	return res;

It is for this reason I thought it would make sense to differentiate 
between the two points of failure.

Hareesh Nagarajan
