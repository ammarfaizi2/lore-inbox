Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWF2PQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWF2PQa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 11:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWF2PQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 11:16:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:12587 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750776AbWF2PQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 11:16:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qlxnu0z04mr45MDaQbhEq53gI0mYQhYI1O7mti6Op43Fqk91QsPaiEebaCH2LFvCMytjaczxVBgm0FgWSwTECT05sSd0gWtt6MqVS586tpv01L7AS8ukDeFNthkZn/RDG8qesf9AQsJZ6PKDjcz8Jo3kEZ4k1ZouZ++Cq9sJz+M=
Message-ID: <f158dc670606290816p4a7add09mf6742d632ec12d28@mail.gmail.com>
Date: Thu, 29 Jun 2006 09:16:27 -0600
From: "Latchesar Ionkov" <lionkov@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: [V9fs-developer] [Patch] Dead code in fs/9p/vfs_inode.c
Cc: "Russ Cox" <rsc@swtch.com>, "Eric Sesterhenn" <snakebyte@gmx.de>,
       linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.61.0606291300010.30453@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1151535167.28311.1.camel@alice>
	 <ee9e417a0606281555k3d954236y82b11336098762be@mail.gmail.com>
	 <Pine.LNX.4.61.0606291300010.30453@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The comment is longer than the 10 bytes we save :)

I like defensive programming, but I am not sure it is required in this
case. The function is 30 lines long and it is going to be pretty hard
to make a mistake when it is modified.

I am for removing the if.

Thanks,
    Lucho

On 6/29/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >> --- linux-2.6.17-git11/fs/9p/vfs_inode.c.orig   2006-06-29
> >> 00:50:53.000000000 +0200
> >> +++ linux-2.6.17-git11/fs/9p/vfs_inode.c        2006-06-29
> >> 00:51:11.000000000 +0200
> >> @@ -386,9 +386,6 @@ v9fs_inode_from_fid(struct v9fs_session_
> >>
> >> error:
> >>        kfree(fcall);
> >> -       if (ret)
> >> -               iput(ret);
> >> -
> >>       return ERR_PTR(err);
> >> }
> >
> > What about when someone changes the code and does have ret != NULL here?
> > This seems like reasonable defensive programming to me.
>
>
> How about a comment:
>
>         kfree(fcall);
>
>         /* Currently commented out because ret is NULL in any case.
>         It is here to remind someone should this condition become
>         false in future. */
>         /* if(ret != NULL) */
>                 iput(ret);
>
>
> Jan Engelhardt
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
