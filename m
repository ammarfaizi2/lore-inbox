Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266114AbUA1RHF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 12:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266109AbUA1RHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 12:07:05 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:62671 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S266119AbUA1RGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 12:06:23 -0500
Date: Wed, 28 Jan 2004 12:04:34 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [PATCH 4/8] autofs4-2.6 - to support autofs 4.1.x
In-reply-to: <Pine.LNX.4.58.0401282321530.17471@raven.themaw.net>
To: raven@themaw.net
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Message-id: <4017EBA2.1080302@sun.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122
 Debian/1.6-1
References: <Pine.LNX.4.58.0401282321530.17471@raven.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

raven@themaw.net wrote:

> 
>Patch:
>
>4-autofs4-2.6.0-test9-waitq2.patch
>
>Adds a spin lock to serialize access to wait queue in the super block info
>struct.
>
>  
>
A while back I wrote up a patch for autofs3 that serialized waitq access 
and changed the waitq counters to atomic_t.  I never sent it out because 
I had realized that the changes I made weren't needed as all waitq 
code-paths were running under the BKL (the big ones were ->lookup and 
the ioctls). 

Looking briefly at autofs4, this appears to be the case as well, so this 
serializing probably isn't needed as long as care is made not block 
while walking the list.

-- 
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me, 
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 

