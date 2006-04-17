Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWDQWWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWDQWWv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 18:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWDQWWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 18:22:51 -0400
Received: from mailhub1.otago.ac.nz ([139.80.64.218]:37572 "EHLO
	mailhub1.otago.ac.nz") by vger.kernel.org with ESMTP
	id S1751326AbWDQWWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 18:22:51 -0400
In-Reply-To: <1145311760.2847.97.camel@laptopd505.fenrus.org>
References: <200604161443.21653.arvidjaar@mail.ru> <F77F3A5F-D618-4F7F-A266-14391E5DD739@cs.otago.ac.nz> <1145311760.2847.97.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2FB35689-F017-45B1-9B20-106A611572BD@cs.otago.ac.nz>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: zhiyi huang <hzy@cs.otago.ac.nz>
Subject: Re: Slab corruption after unloading a module
Date: Tue, 18 Apr 2006 10:23:25 +1200
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2006-04-18 at 10:08 +1200, zhiyi huang wrote:
>>>
>>>> There was no problem if I just load and unload the module. But if I
>>>> write to the device using "ls > /dev/temp" and then unload the
>>>> module, I would get slab corruption.
>>>
>>> you return different value as what has really been consumed:
>>>
>>>>         if (*f_pos + count > MAX_DSIZE)
>>>>                 count1 = MAX_DSIZE - *f_pos;
>>>>
>>>>         if (copy_from_user (temp_dev->data+*f_pos, buf, count1)) {
>
> this is still buggy.. what if f_pos is huge???

Well, if you look at my program, the complete code is like this:

         if (*f_pos > MAX_DSIZE)
                 goto wrap_up;
         if (*f_pos + count > MAX_DSIZE)
                 count1 = MAX_DSIZE - *f_pos;

         if (copy_from_user (temp_dev->data+*f_pos, buf, count1)) {

