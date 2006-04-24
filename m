Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWDXLTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWDXLTQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 07:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWDXLTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 07:19:16 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:41884 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750725AbWDXLTP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 07:19:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mu9QvikoWxOfXJ2vgvxzNC2o9CIqdE3EPo2TTat3/KZS2+20YSHg2rEhPrDlEGcItR5vHyAPMgigQskLEh9OzYl0TIPreaQKeWe9PkVnum7wkaXeBDMvtaojCflHXcHR+A/BB0sH1+DemCBu3a0vmnBzA2mlc8oZALm4Q5hJgD8=
Message-ID: <84144f020604240419w190d03cdld53432da8df6277b@mail.gmail.com>
Date: Mon, 24 Apr 2006 14:19:15 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Joshua Hudson" <joshudson@gmail.com>
Subject: Re: Filesystem & mutex
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bda6d13a0604232154r28f23212o55b15a065fe6d648@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bda6d13a0604232154r28f23212o55b15a065fe6d648@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/24/06, Joshua Hudson <joshudson@gmail.com> wrote:
> My filesystem has need of an extra mutex in the extended inode data area.
> From what I understand, the mutex can be initalized in inode_init_once, but
> I cannot determine how to free it.
>
> It looks wrong to destroy the mutex by just destroying the slab.
> It is wrong to destroy the inode in destroy_inode. Badness when
> an inode is reused.

There's no need to 'release' a mutex. If the mutex is unlocked, you
can do kmem_cache_free() on the owning inode. You need to do
mutex_init() in the object cache constructor (init_once) only because
the memory given to you can be arbitrary state. After the mutex has
been initialized, it will never go into an illegal state on its own
assuming you remember to unlock it before freeing the inode.

                                            Pekka
