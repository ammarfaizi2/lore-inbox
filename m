Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317946AbSHGPw2>; Wed, 7 Aug 2002 11:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318099AbSHGPw2>; Wed, 7 Aug 2002 11:52:28 -0400
Received: from mail.zmailer.org ([62.240.94.4]:23688 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S317946AbSHGPw1>;
	Wed, 7 Aug 2002 11:52:27 -0400
Date: Wed, 7 Aug 2002 18:56:06 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: UNIX domain socket hanging around when not closed
Message-ID: <20020807155606.GH32427@mea-ext.zmailer.org>
References: <20020807153251.GD27745@vagabond>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020807153251.GD27745@vagabond>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 05:32:51PM +0200, Jan Hudec wrote:
> Hello,
> 
> I have a (possibly stupid) question. Is it OK, that dentries created by
> binding unix-domain sockets remain in filesystem?

   That is the classical behaviour, possibly because of tradition
   where they relate to named pipes created with mknod(1) command.

     http://www.ecst.csuchico.edu/~beej/guide/ipc/usock.html

> What I do is create a unix socket in /tmp and wait for clients to
> connect in. The program removes the socket dentry when it shuts down,
> but it sometimes crashes and the socket remains there.
> 
> Is there some reason the socket should remain unless explicitely
> removed?

   Traditional is also to   unlink() the socket name just prior
   to bind(3):ing it just in case there is a left-over entity
   with that name.


   The object name (it is NAMED entity, after all) space is
   filesystem name space.   I don't see any reason why not:

      - There could pre-exist the named socket (at a R/O
        filesystem), and no new name needs to be allocated
        in the filesystem for it.

      - The entire named entity would not be allowed to
        exist purely in VFS space, that is: creation wise
        the permission verification could ignore location
        directory being on a read/only file system, and
        just use directory permissions.  (Questions about
        memory expenditure, etc.  all kinds of trade-offs.)

  What the new POSIX writes about the issue, that I haven't
  yet looked into.

> 			 Jan 'Bulb' Hudec <bulb@ucw.cz>

/Matti Aarnio
