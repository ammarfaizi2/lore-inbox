Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWFAHVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWFAHVF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 03:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWFAHVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 03:21:05 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:5791 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750740AbWFAHVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 03:21:04 -0400
Date: Thu, 1 Jun 2006 03:21:02 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: Tony Griffiths <tonyg@agile.tv>, linux-kernel@vger.kernel.org
Subject: Re: Some socket syscalls fail to return an error on bad file-descriptor#
 argument
In-Reply-To: <20060531214116.ef2d1c3e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606010320140.12929@d.namei>
References: <447E614F.3090905@agile.tv> <20060531214116.ef2d1c3e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006, Andrew Morton wrote:

> Confused.  That patch cannot make any difference to this function:

Yep, the code definitely looks correct in current LT git.

> static struct socket *sockfd_lookup_light(int fd, int *err, int *fput_needed)
> {
> 	struct file *file;
> 	struct socket *sock;
> 
> 	*err = -EBADF;
> 	file = fget_light(fd, fput_needed);
> 	if (file) {
> 		sock = sock_from_file(file, err);
> 		if (sock)
> 			return sock;
> 		fput_light(file, *fput_needed);
> 	}
> 	return NULL;
> }



- James
-- 
James Morris
<jmorris@namei.org>
