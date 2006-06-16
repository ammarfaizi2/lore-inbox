Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWFPQjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWFPQjO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 12:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWFPQjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 12:39:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:14959 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751483AbWFPQjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 12:39:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=Fb6Qn0dFtJNYAbX0QGwcazE3WgKX8/DGrR24QvgfRINpTBSufZsFjpCU0EkpBQJa1CQjJ/2iAJaW/Z9TYJIIbPuKriAxLb2m8ShuGItTPAGHPwQzVf/LHgPqlrixRt+2hN8wbvQ5LaVThoaqfGIKdAcIJqGcBcKjoTQT0UhG0XQ=
Message-ID: <d5a2d4790606160939i50ca65dfn2a4d92bc9b4a0fb0@mail.gmail.com>
Date: Fri, 16 Jun 2006 10:39:12 -0600
From: "Mike Smullin" <mikesmullin@s161200816.onlinehome.us>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>, colin <colin@realtek.com.tw>
Subject: Re: Solve the problem that umount will fail when an opened file isn't closed
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 21fd113daf11ac05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for that, Jan. What a great idea!

> >I have implemented an auto-mount & auto-umount
> facility based on USB
> >hotplug.

Colin can you explain how you implemented this? I would like to try it, too.

Thanks,
Mike

--
Mike Smullin
"The day I come in front of the Gartner audience and say we have a
better Unix than Linux, that'll be a good day" -- Steve Ballmer
http://www.mikesmullin.com

--- Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> >
> >Hi all,
> >I have implemented an auto-mount & auto-umount
> facility based on USB
> >hotplug.
> >An annoying problem will occur when some process
> doesn't close its open file
> >and auto-umount is trying to umount that mount
> point after usb disk has been
> >unplugged.
> >Is there any way to force it to be umounted in this
> situation?
> >
>
> fs/super.c:
>
>     /* Forget any remaining inodes */
>     if (invalidate_inodes(sb)) {
>         printk("VFS: Busy inodes after unmount of
> %s. "
>            "Self-destruct in 5 seconds.  Have a nice
> day...\n",
>            sb->s_id);
>     }
>
> That's what happens if you eject a CD. The box won't
> explode though.
>
>
> Jan Engelhardt
> --
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
