Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVC2V7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVC2V7P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 16:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVC2V7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 16:59:14 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:54868 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261502AbVC2V7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 16:59:01 -0500
Message-ID: <4249CFA1.7050907@tls.msk.ru>
Date: Wed, 30 Mar 2005 01:58:57 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] embarassing typo
References: <1112128584.25954.6.camel@tux.lan> <yw1xd5ti17z6.fsf@ford.inprovide.com>
In-Reply-To: <yw1xd5ti17z6.fsf@ford.inprovide.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> "Ronald S. Bultje" <rbultje@ronald.bitfreak.net> writes:
> 
>>--- linux-2.6.5/drivers/media/video/zr36050.c.old	16 Sep 2004 22:53:27 -0000	1.2
>>+++ linux-2.6.5/drivers/media/video/zr36050.c	29 Mar 2005 20:30:23 -0000
>>@@ -419,7 +419,7 @@
>> 	dri_data[2] = 0x00;
>> 	dri_data[3] = 0x04;
>> 	dri_data[4] = ptr->dri >> 8;
>>-	dri_data[5] = ptr->dri * 0xff;
>>+	dri_data[5] = ptr->dri & 0xff;
> 
> Hey, that's a nice obfuscation of a simple negation.

It's not a negation.  This statement always assigns zero to
dri_data[5] if dri_data is char[].  Looks like gcc isn't catching
this problem.

> BTW, when assigning to a char type, is the masking really necessary at
> all?  I can't see that it should make a difference.  Am I missing
> something subtle?

Well, it's a matter of readability mostly.  For now at least, when
char is always 8 bytes...

/mjt
