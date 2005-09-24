Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbVIXFwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbVIXFwe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 01:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbVIXFwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 01:52:34 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:64268 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751435AbVIXFwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 01:52:34 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <20050923122834.659966c4.akpm@osdl.org> (message from Andrew
	Morton on Fri, 23 Sep 2005 12:28:34 -0700)
Subject: Re: [PATCH] open: O_DIRECTORY and O_CREAT together should fail
References: <E1EIonQ-0006Ts-00@dorka.pomaz.szeredi.hu> <20050923122834.659966c4.akpm@osdl.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <E1EJ2xC-0007SZ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 24 Sep 2005 07:52:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Current behavior is inconsistent with documentation: 
> > open(..., O_DIRECTORY|O_CREAT) succeeds if file didn't exist, and
> > returned descriptor does not refer to a directory.
> > 
> > No other error value quite fits this case: 
> > 
> >   ENOTDIR - the file doesn't exist, so this is slightly misleading
> >   ENOENT - yes, but we asked for an O_CREAT so why wasn't it created
> > 
> > But EINVAL - invalid combination of flags, is quite good IMO.
> > 
> 
> We could be a bit screwed here.  If there are any apps out there which are
> using this combination, we just broke them.  Essentially the patch is
> assuming that nobody is currently using O_CREAT|O_DIRECTORY, but one day in
> the future someone will do that.

Well yes.  But I don't think anybody is using it, and if so they are
clearly breaking the rules in man open(2):

       O_DIRECTORY
              If pathname is not a directory, cause the open  to  fail.   This
              flag is Linux‐specific, and was added in kernel version 2.1.126,
              to avoid denial‐of‐service problems if opendir(3) is called on a
              FIFO  or  tape  device,  but  should  not be used outside of the
              implementation of opendir.

So if someone uses this outside of opendir() and uses it to create a
non-directory, I think they deserve to be screwed.

Miklos
