Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVDQT6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVDQT6N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 15:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVDQT6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 15:58:12 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:54550 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261452AbVDQT5z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 15:57:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iGDuGNPySutA9F6rrR/behwBJinDW0tspAEkBqXl7n4D2xfPCWctmO8TbkxQy/76ZdL7+2rnQ9dGcSeYcCJDFX5w9Bkpgu7h+QoEMIH7256lQDSQTDC89CiqspigQVB7wqqUpR194Au9eih2e8eE1VtxnJIQXwEF044y+zuLEXk=
Message-ID: <a4e6962a0504171257715cffc0@mail.gmail.com>
Date: Sun, 17 Apr 2005 14:57:54 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <E1DNElp-0005JD-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050320151212.4f9c8f32.akpm@osdl.org>
	 <E1DEmYC-0008Qg-00@dorka.pomaz.szeredi.hu>
	 <20050331112427.GA15034@infradead.org>
	 <E1DH13O-000400-00@dorka.pomaz.szeredi.hu>
	 <20050331200502.GA24589@infradead.org>
	 <E1DJsH6-0004nv-00@dorka.pomaz.szeredi.hu>
	 <20050411114728.GA13128@infradead.org>
	 <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu>
	 <a4e6962a050417110160a464d8@mail.gmail.com>
	 <E1DNElp-0005JD-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/05, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > >   1) Only allow mount over a directory for which the user has write
> > >      access (and is not sticky)
> > >
> > >   2) Use nosuid,nodev mount options
> > >
> > > [ parts deleted ]
> >
> > Do these solve all the security concerns with unprivileged mounts, or
> > are there other barriers/concerns?  Should there be ulimit (or rlimit)
> > style restrictions on how many mounts/binds a user is allowed to have
> > to prevent users from abusing mount privs?
> 
> Currently there is a (configurable) global limit for all non-root FUSE
> mounts.  An additional per-user limit would be nice, but from the
> security standpoint it doesn't matter.
> 
> > I was thinking about this a while back and thought having a user-mount
> > permissions file might be the right way to address lots of these
> > issues.  Essentially it would contain information about what
> > users/groups were allowed to mount what sources to what destinations
> > and with what mandatory options.
> 
> I haven't yet seen the need for such a great flexibility.  Debian
> installs fusermount (the FUSE mount utility) "-rwsr-x--- root fuse",

These are both well and good, but I was looking for a more global
system (for things other than FUSE).

> 
> > Is this unnecessary?  Is this not enough?
> 
> Maybe it is necessary, but why bother until somebody actually wants
> it?  I'm a great believer of the "lazy" development philosophy ;)
> 

Yeah, I guess I'm motivated in that I want to use normal mount to
handle v9fs user file systems, local private mounts, and local private
resource shares.  I'd also like normal users to be able to take better
advantage of -o bind.  I think its kinda silly that we have special
purpose mounts for cifs, samba, fuse, v9fs, etc -- but I suppose
that's more of a user-space util-linux dilemma than a kernel dilemma.

     -eric
