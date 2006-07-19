Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbWGSI41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWGSI41 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 04:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWGSI41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 04:56:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:29489 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932532AbWGSI41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 04:56:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=IFI7z5FKVcyVxxnlhWA1iUpje8v5KgXH3pUfNgrFUsEC+ugFnO26fCLaNzbog7P1H84TwRE8Xl9MDSh7DVGNeYg/40wdxYcdK7ywUoxX0M0H28cLFASgeBL4Hm+OHxQwQOm73cbW1qlRQ62F4bDRctwlnNwUIO8BJa8t9q5Gsmw=
Message-ID: <84144f020607190156q1de9893ek3e5b800ee181e1a@mail.gmail.com>
Date: Wed, 19 Jul 2006 11:56:25 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: chinmaya@innomedia.soft.net
Subject: Re: How to mount own file system in linux
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <44BDF21B.60207@innomedia.soft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44BDF21B.60207@innomedia.soft.net>
X-Google-Sender-Auth: c7ff547aff25b416
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/19/06, Chinmaya Mishra <chinmaya4@gmail.com> wrote:
> Can you suggest me where I can get some good documents to proceed or any
> dummy code if any.

See fs/ramfs/ for an example. There's also Documentation/filesystems/vfs.txt.

On 7/19/06, Chinmaya Mishra <chinmaya4@gmail.com> wrote:
> I have tried this with the following code but it gives some warning
> messages during compilation. The file system is registered but during
> the mount command segmentation fault occurs.

So maybe pay attention to the warnings?

> static struct super_block *rfs_read_super( struct super_block *sb, void
> *buf, int size);
> static struct file_system_type rfs = {"rfs", 0, rfs_read_super, NULL};

There's no read_super in struct file_system_type. See
include/linux/fs.h for details.

> int init_module(void) {

[snip]

> void cleanup_module(void) {

[snip]

This is the old way. You really want to be using module_init and
module_exit macros.
