Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTKDQVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 11:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbTKDQVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 11:21:10 -0500
Received: from gort.metaparadigm.com ([203.117.131.12]:43673 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S262353AbTKDQVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 11:21:08 -0500
Message-ID: <3FA7D1F2.6090702@metaparadigm.com>
Date: Wed, 05 Nov 2003 00:21:06 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.5-2
X-Accept-Language: en
MIME-Version: 1.0
To: ruben@puettmann.net
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
Subject: Re: Suspend and AGP in 2.6.0-test9
References: <NMa8.7uR.11@gated-at.bofh.it> <NN6b.pY.5@gated-at.bofh.it> <E1AH3Rg-00033v-00@baloney.puettmann.net>
In-Reply-To: <E1AH3Rg-00033v-00@baloney.puettmann.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/03 23:50, Ruben Puettmann wrote:
>         hy,
> 
> 
>>Suspend/Resume code in agpgart is virtually non-existant.
> 
> 
> Do you know if there is some work in progress? Without suspend and
> resume with XFree most laptop users will not be happy with 2.6.
> 
> Here on Thinkpad with ATI 7500 I can suspend but not resume if XFree is
> enabled.

Here on thinkpad with ATI 7500 I have APM suspend/resume working
in -test9 with the following workaround:

$ more /etc/apm/event.d/video
#!/bin/sh
case "$1" in
suspend)
         /bin/fgconsole > /var/tmp/fgconsole.save
         /usr/bin/chvt 1
         ;;
resume)
         /usr/bin/chvt `cat /var/tmp/fgconsole.save`
         ;;
esac

