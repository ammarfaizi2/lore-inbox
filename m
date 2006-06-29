Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWF2LCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWF2LCO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbWF2LCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:02:14 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:55472 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751399AbWF2LCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:02:13 -0400
Date: Thu, 29 Jun 2006 13:01:58 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Russ Cox <rsc@swtch.com>
cc: Eric Sesterhenn <snakebyte@gmx.de>, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [Patch] Dead code in fs/9p/vfs_inode.c
In-Reply-To: <ee9e417a0606281555k3d954236y82b11336098762be@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0606291300010.30453@yvahk01.tjqt.qr>
References: <1151535167.28311.1.camel@alice>
 <ee9e417a0606281555k3d954236y82b11336098762be@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> --- linux-2.6.17-git11/fs/9p/vfs_inode.c.orig   2006-06-29
>> 00:50:53.000000000 +0200
>> +++ linux-2.6.17-git11/fs/9p/vfs_inode.c        2006-06-29
>> 00:51:11.000000000 +0200
>> @@ -386,9 +386,6 @@ v9fs_inode_from_fid(struct v9fs_session_
>> 
>> error:
>>        kfree(fcall);
>> -       if (ret)
>> -               iput(ret);
>> -
>>       return ERR_PTR(err);
>> }
>
> What about when someone changes the code and does have ret != NULL here?
> This seems like reasonable defensive programming to me.


How about a comment:

	kfree(fcall);

	/* Currently commented out because ret is NULL in any case.
	It is here to remind someone should this condition become
	false in future. */
	/* if(ret != NULL) */
		iput(ret);


Jan Engelhardt
-- 
