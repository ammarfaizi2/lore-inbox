Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWFGMRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWFGMRA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 08:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWFGMRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 08:17:00 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:41263 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932221AbWFGMQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 08:16:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=nkzYG3EwZUB5KA0BjX9XaFgPOELcniUGgBij5zWhO9p7sRGlmp7mbot/MjW7SP4HcmqxScRibJynm50G4iAU5Xu9Fj8GcPyMJ4enVkZqG6LmAUqgL0KXBPyL7LbdIOGqD+v2FOEc1CjpFZIFcIpyPTO9Lonc3F1P0fOqfy4bqoo=
Message-ID: <84144f020606070516m4bccdecdr998941ee74744a83@mail.gmail.com>
Date: Wed, 7 Jun 2006 15:16:58 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Xin Zhao" <uszhaoxin@gmail.com>
Subject: Re: Linux SLAB allocator issue
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <4ae3c140606061358j140eec9fl45e22f8a9e673215@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4ae3c140606061358j140eec9fl45e22f8a9e673215@mail.gmail.com>
X-Google-Sender-Auth: c5f97e954c80f3df
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/06, Xin Zhao <uszhaoxin@gmail.com> wrote:
> I am trying to check how many slabs are used for inode_cache, but
> found that all slabs are added to slabs_full list, and slabs_partial
> is always empty. Even if the active object number does not exactly
> occupy all slabs.
>
> Does that mean Linux 2.6 remove the use of slabs_partial?

No. If slabs_partial is really empty, the number of active objects
should match the number of objects in a slab; otherwise you should see
an error message when you do cat /proc/slabinfo (see s_show in
mm/slab.c for details).

How are you verifying that the partial list is empty?

On 6/6/06, Xin Zhao <uszhaoxin@gmail.com> wrote:
> Another question, the constructor transfered to the
> kmem_cache_create() function is called for every object in a slab when
> it is created. Is this true? Is there any way to call back a function
> _only once_ when a new slab is allocated?

We don't have per-slab constructors. Only per-object. What do you need it for?

                                            Pekka
