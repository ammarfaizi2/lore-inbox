Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVDSP0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVDSP0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 11:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVDSP0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 11:26:12 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:24899 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261610AbVDSP0H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 11:26:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sfyt6ZiQx3ierkK8/QCcTM4T2To160Ox143ft1tEVEUl0XFUaddzSdMibVITtZAEOPZ8oECUh/FbUIhJEyywH4h3NlWCQV59B+jsPGD482QxdOQmuD2zh0lom6VeZ0yQIIGKUUMpC79T9JxJzA/eO3bd8gRfI7dnZIcrkO8BQvA=
Message-ID: <a4e6962a05041908262df343f1@mail.gmail.com>
Date: Tue, 19 Apr 2005 10:26:06 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Bodo Eggert <7eggert@gmx.de>
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <Pine.LNX.4.58.0504191647320.3652@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3Ki1W-2pt-1@gated-at.bofh.it> <3S8oN-So-21@gated-at.bofh.it>
	 <3S8oN-So-23@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it>
	 <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it>
	 <3UmnD-6Fy-7@gated-at.bofh.it>
	 <E1DNJZD-0006vK-11@be1.7eggert.dyndns.org>
	 <a4e6962a050419045752cc8be0@mail.gmail.com>
	 <Pine.LNX.4.58.0504191647320.3652@be1.lrz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/05, Bodo Eggert <7eggert@gmx.de> wrote:
> >
> > Well, that would kinda be the intent behind the permissions file  --
> > it can specify what restricted set of images/devices/whatever the user
> > can mount, I suppose the sensible thing would be to always enforce
> > nosuid and nsgid, but I'd rather keep these as the default version of
> > options (allowing admins to shoot themselves in the foot perhaps, but
> > in the single-user workstation case, is seems like there's less reason
> > to be so paranoid).
> 
> I think you shouldn't help the admins by creating shoes with target marks.
>

Fair enough.  Since I don't really have any cases I can think of that
require this sort of behavior, I'll back off on allowing user mounts
with suid or sgid enabled.

> 
> Allowing user mounts with no* should be allways ok (no config needed
> besides the ulimit), and mounting specified files to defined locations
> is allready supported by fstab.
>

Do folks think that the limits should be per-user or per-process for
user-mounts, what about separate limits for # of private namespaces
and # of mounts?

The fstab support doesn't seem to provide enough flexibility for
certain situations, say I want to support mounting any remote file
system, as long as its in the user's private hierarchy?   What if I
want user's to be able to mount FUSE, v9fs, etc. user-space file
systems, but only in a private namespace and only in their private
hierarchy?  Or are these situations which you think should "always be
okay" as long as nosuid and nogid (and newns?) are implicit?

     -eric
