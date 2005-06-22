Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVFVQhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVFVQhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVFVQhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:37:23 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:40336 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261589AbVFVQeX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:34:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bozrbtJOkaGbZsWXdaZzct1awon7e7n0vBQnSYCSKv8A02btxJ5hlAjHqDS42Nq1nLC6CRBGpPZ0WsU80mkXhMZ+sIp8Rqbxd7cuyo2jnaLMmQnT3e2cq004JS9Rc1zuciwPQ75r5CCtmPbMet4xWctp8hibZpjVzderE8eH0XQ=
Message-ID: <a4e6962a05062209343a040c1f@mail.gmail.com>
Date: Wed, 22 Jun 2005 11:34:18 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Cc: Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <a4e6962a050622085021cdfb9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620235458.5b437274.akpm@osdl.org>
	 <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
	 <20050621142820.GC2015@openzaurus.ucw.cz>
	 <E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu>
	 <20050621220619.GC2815@elf.ucw.cz>
	 <a4e6962a05062207435dd16240@mail.gmail.com>
	 <20050622150839.GB1881@elf.ucw.cz>
	 <a4e6962a050622085021cdfb9d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/05, Eric Van Hensbergen <ericvh@gmail.com> wrote:
    ...
> 
> If you combine these two restrictions with only allowing unprivileged
> mounts in private name space I think you get 90% there.  The only
> thing left to resolve is the best way to allow sharing private name
> spaces between threads/users -- and I still view this as more of
> extended functionality than a hard-requirement.
> 

Reviewing my notes, there were a few subtle restrictions I forgot
(most of which originally suggested by Miklos):

(a) User's can't mount file system types not deemed "safe" (via  flag
in the file system type) -- this should help mitigate user's
exploiting bugs in existing file systems to interfere with the system.
 Judging when a file system type is "safe" is a nasty kettle of fish
though...
(b) Enforce NODEV along with NOSUID so that user-based synthetics
can't have device inodes with compromised permissions, etc.

       -eric
