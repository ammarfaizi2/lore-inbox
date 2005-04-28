Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVD1N2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVD1N2t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 09:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVD1N2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 09:28:49 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:23377 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262124AbVD1N2n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 09:28:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d5nPSrQqMXStXzu8YRwztraRw32w+mCkvFA/cqF4TPz4qTvrtOsVB80U15UesgZqbu7tF/TD1/JxzuBgsty7HlnsbPZQ42jhDrZ4H9LcLIgx9vgUqhjhBFQ9HTOktJr+HT2uSElwDOP1eLaavhBmC1gn6PhltzjAGq8b424+qHg=
Message-ID: <a4e6962a050428062821838bcb@mail.gmail.com>
Date: Thu, 28 Apr 2005 08:28:43 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH] private mounts
Cc: Pavel Machek <pavel@ucw.cz>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <20050426140715.GA10833@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1DPnOn-0000T0-00@localhost> <E1DPo3I-0000V0-00@localhost>
	 <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk>
	 <E1DPoCg-0000W0-00@localhost>
	 <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk>
	 <20050424213822.GB9304@mail.shareable.org>
	 <20050425152049.GB2508@elf.ucw.cz>
	 <20050425190734.GB28294@mail.shareable.org>
	 <20050426092924.GA4175@elf.ucw.cz>
	 <20050426140715.GA10833@mail.shareable.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Looking closer, I think we already have it.
> 
> It's called /proc/NNN/root.
> 
> Does chroot into /proc/NNN/root cause the chroot'ing process to adopt
> the namespace of NNN?  Looking at the code, I think it does.
> 
    ...
> 
> So no new system calls are needed.  A daemon to hand out per-user
> namespaces (or any other policy) can be written using existing
> kernels, and those namespaces can be joined using chroot.
> 
> That's the theory anyway.  It's always possible I misread the code (as
> I don't use namespaces and don't have tools handy to try them).
> 

I've been thinking about this a bit more...would you even need chroot?
(wouldn't exposing chroot functionality to a user incur additional
security risk?  I guess it would be okay as long as you were only
chrooting to one of your other process' roots?)

If you were organized about where the mounts in your private namespace
were done, you could just mount -bind them from
/proc/NNN/root/home/$USER/mnt (or something).  That requries a certain
amount of discipline in your mounts (or maybe not -- just diff
/proc/NNN/mounts to see what you are missing and bind the
differences).

         -eric
