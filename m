Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274944AbTHMNPj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 09:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274964AbTHMNPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 09:15:39 -0400
Received: from f16.mail.ru ([194.67.57.46]:7689 "EHLO f16.mail.ru")
	by vger.kernel.org with ESMTP id S274944AbTHMNPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 09:15:30 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Andrew Morton=?koi8-r?Q?=22=20?= <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: new dev_t printable convention and lilo
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Wed, 13 Aug 2003 17:15:19 +0400
In-Reply-To: <20030809161221.1a94eb2c.akpm@osdl.org>
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19mvTD-0007gz-00.arvidjaar-mail-ru@f16.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----

> 
> Andrey Borzenkov <arvidjaar@mail.ru> wrote:
> >
> > {pts/2}% cat /proc/cmdline
> > BOOT_IMAGE=260-t3smp2 ro root=345 devfs=mount
> > 
> > I guess it has to use 03:45 now? Does it mean lilo has to be updated to handle 
> > new convention?
> > 
> 
> I think we need to teach the parsing code to handle both styles.
> 
> It's a bit of a screwup.
> 

sorry for late reply.

I was wrong, the code that actually uses root= was unaffected.

It happens in name_to_dev_t:

 	if (strncmp(name, "/dev/", 5) != 0) {
 		res = (dev_t) simple_strtoul(name, &p, 16);
 		if (*p)
 			goto fail;
 		goto done;
 	}

it means handle-old-dev_t is meaningless and has to be removed ; and if we want people to use new format, it needs to go into name_to_dev_t.

sorry for confusion :(

