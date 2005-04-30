Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVD3RYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVD3RYf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 13:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVD3RYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 13:24:35 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:62897 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261313AbVD3RYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 13:24:33 -0400
To: smfrench@austin.rr.com
CC: bfields@fieldses.org, miklos@szeredi.hu, hch@infradead.org, 7eggert@gmx.de,
       linux-kernel@vger.kernel.org
In-reply-to: <42739B26.8080005@austin.rr.com> (message from Steve French on
	Sat, 30 Apr 2005 09:50:14 -0500)
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
References: <3YLdQ-4vS-15@gated-at.bofh.it> <E1DRekV-0001RN-VQ@be1.7eggert.dyndns.org> <20050430073238.GA22673@infradead.org> <E1DRn70-0002AD-00@dorka.pomaz.szeredi.hu> <20050430082952.GA23253@infradead.org> <E1DRoBU-0002Fk-00@dorka.pomaz.szeredi.hu> <E1DRpfS-0002Nc-00@dorka.pomaz.szeredi.hu> <427387FB.4030901@austin.rr.com> <20050430145306.GA22276@fieldses.org> <42739B26.8080005@austin.rr.com>
Message-Id: <E1DRvgL-0002ng-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 30 Apr 2005 19:23:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But you bring up an interesting point about security policy.  For
> the case of evil user trying to mount to evil server (e.g. one under
> evil user's control), in one sense it is no different than allowing
> a user to mount an evil cdrom or usb storage device with evil
> contens - a device which may contain specially crafted data (file
> and directory contents and metadata) designed to crash the system,
> but there is a difference - for network filesystems the server also
> can delay the responses, throw away the responses or corrupt the
> frame headers (this can just as often happen due to buggy network
> hardware and routers too).

There's another difference.  Mounting a cdrom or usb stick needs
_physical_ access to the machine in question.  If you have physical
access you don't need to craft special filesystems to crash the
machine, just pull out the plug from the wall.

So network/userspace filesystems which allow the user to mount an
arbitrary server should be _extra_ careful to verify data from the
server.  Otherwise they can remotely crash the machine or gain
elevated privileges.

Miklos

