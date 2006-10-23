Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWJWEAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWJWEAY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 00:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWJWEAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 00:00:24 -0400
Received: from web55602.mail.re4.yahoo.com ([206.190.58.226]:62846 "HELO
	web55602.mail.re4.yahoo.com") by vger.kernel.org with SMTP
	id S1751404AbWJWEAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 00:00:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=GcoDwmyksJn0PmmPe2aDxP9FfBsLdQeBN3I5NObLXokLa/PmGVx7iyDoCYqJeaT8sKnRZcDw/Nlgm05AdF3x3Aw9BU9O1QXcdXyW6yCDX/Q9e+OKSzqMLX7Y/hj5LniCW56feJrnFOEZP5x0fYt/70/tYRUSjwi9OY74JPL/VNM=  ;
Message-ID: <20061023040018.28823.qmail@web55602.mail.re4.yahoo.com>
Date: Sun, 22 Oct 2006 21:00:17 -0700 (PDT)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: Hopefully, kmalloc() will always succeed, but if it doesn't then....
To: Roland Dreier <rdreier@cisco.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
In-Reply-To: <adalkn7j2th.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Roland Dreier <rdreier@cisco.com> wrote:

>  >         struct mixart_enum_connector_resp *connector;
>  >         struct mixart_audio_info_req  *audio_info_req;
>  >         struct mixart_audio_info_resp *audio_info;
>  > 
>  >         connector = kmalloc(sizeof(*connector), GFP_KERNEL);
>  >         audio_info_req = kmalloc(sizeof(*audio_info_req), GFP_KERNEL);
>  >         audio_info = kmalloc(sizeof(*audio_info), GFP_KERNEL);
>  >         if (! connector || ! audio_info_req || ! audio_info) {
>  >                 err = -ENOMEM;
>  >                 goto __error;
>  >         }
> 
> This is not a bug.  All of the pointers are initialized, and if

Yes, this is not a bug. Although the case for arrays go unnoticed by gcc. Something like this:

        char *abcd[20];
        int i;

        for (i = 0; i < 20; i++) {
                abcd[i] = kmalloc(10, GFP_KERNEL);
                if (!abcd[i])
                        goto error;
        }
 error:
        for (i = 0; i < 20; i++)
                kfree(abcd[i]);

-Amit

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
