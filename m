Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbVLVIYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbVLVIYx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 03:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbVLVIYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 03:24:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55002 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965134AbVLVIYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 03:24:52 -0500
Date: Thu, 22 Dec 2005 00:24:23 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usb: replace __setup("nousb") with __module_param_call
Message-Id: <20051222002423.1791d38b.zaitcev@redhat.com>
In-Reply-To: <200512220110.52466.dtor_core@ameritech.net>
References: <20051220141504.31441a41.zaitcev@redhat.com>
	<200512220110.52466.dtor_core@ameritech.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.8; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005 01:10:52 -0500, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> On Tuesday 20 December 2005 17:15, Pete Zaitcev wrote:

> > Fedora users complain that passing "nousbstorage" to the installer causes
> > the rest of the USB support to disappear. The installer uses kernel command
> > line as a way to pass options through Syslinux. The problem stems from the
> > use of strncmp() in obsolete_checksetup().

> I wonder if that strncmp() should be changed into something like
> this (untested):
> 
> --- work.orig/init/main.c
> +++ work/init/main.c
> @@ -167,7 +167,7 @@ static int __init obsolete_checksetup(ch
>  	p = __setup_start;
>  	do {
>  		int n = strlen(p->str);
> -		if (!strncmp(line, p->str, n)) {
> +		if (!strncmp(line, p->str, n) && !isalnum(line[n])) {
>  			if (p->early) {

Are you sure that your fix works well in case of __setup("foo=")?
It probably breaks all of those.

-- Pete
