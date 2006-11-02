Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWKBOZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWKBOZn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 09:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWKBOZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 09:25:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:10930 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750807AbWKBOZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 09:25:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=cyTiyBLuW0w+V1CoDqqEHADLqOsZkBm52nCSzChVgCii4eBF5N6VxHJTjC3hhOjjfVnMYtUI+WhqXtb9BkYxF0UNPeJwcPHVfOptuO5Ta8QIy9QroGJ6HyyoP/PpjAJvZe89SpHMPcoB3WK2mTy25dgS3lOePDzxtfaknJuakf8=
Message-ID: <454A0006.4090505@innova-card.com>
Date: Thu, 02 Nov 2006 15:26:14 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Miguel Ojeda <maxextreme@gmail.com>
CC: Franck <vagabon.xyz@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH update6] drivers: add LCD support
References: <20061101014057.454c4f43.maxextreme@gmail.com>	 <4549B19C.70304@innova-card.com> <653402b90611020544l6e5ded94hc4c932fc1442fcb0@mail.gmail.com>
In-Reply-To: <653402b90611020544l6e5ded94hc4c932fc1442fcb0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda wrote:
> On 11/2/06, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
>> Hi
>>
>> Miguel Ojeda Sandonis wrote:
>> > Andrew, here it is the coding style fixes. Thanks you.
>> >
>> > I think the driver is getting ready for freeze until
>> > 2.6.20-rc1 (if anyone sees something wrong), so I will
>> > try to send just minor fixes like this.
>>
>> :)
>>
>> Again, any thoughts on cache aliasing ?
>>
> 
> If you have seen something wrong, please tell. What are you thinking about?

Sorry for the short/fast question. I'm wondering how does the cache
behave here. You have 2 virtual addresses that point to the same
location in physical RAM: kernel frame buffer which has a kernel
virtual address and the vma you're returning when an application mmap
the device. This last address is a user virtual address and is
different from the first one.

Now let's say that some of the kernel frame buffer data are in the
data cache and never be invalidate during this example. The
application updates its mmapped frame buffer. During the refresh time,
the kernel take a look to its frame buffer to check if something
change. Since the 'old' data are still in the data cache and are
valid, the kernel will use them instead of the new one set by the
application.

		Franck
