Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWANPqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWANPqN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 10:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWANPqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 10:46:13 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:37761 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932218AbWANPqM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 10:46:12 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jim MacBaine <jmacbaine@gmail.com>
Subject: Re: /proc/sys/vm/swappiness == 0 makes OOM killer go beserk
Date: Sat, 14 Jan 2006 17:45:56 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Nick Craig-Wood <nick@craig-wood.com>
References: <5uzvD-8tr-19@gated-at.bofh.it> <20060114110231.06B6F14C6FD@irishsea.home.craig-wood.com> <3afbacad0601140553u374273bao71c0cb74108354d8@mail.gmail.com>
In-Reply-To: <3afbacad0601140553u374273bao71c0cb74108354d8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601141745.56368.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 January 2006 15:53, Jim MacBaine wrote:
> On 1/14/06, Nick Craig-Wood <nick@craig-wood.com> wrote:
> 
> > On my home workstation I do a lot of stuff with very large video
> > files, so set swappiness to 0 some time ago so using these large files
> > would stop all the applications getting pushed out into swap.
> 
> My motivation was similar: My desktop usually runs 24 hrs and I leave
> large applications which I use from time to time always open. Like
> OpenOffice, Firefox, Emacs with large buffers, etc.  In the night, the
> machine performs two disk-intensive tasks.  First a backup then
> updatedb. And every morning about 650 MB of 1 GB RAM is used for
> caches and all my application need to be swapped in before I can use
> them.
> 
> Of course, the increase of disk cache is reasonable for those tasks,
> but honestly, I don't care whether the updatedb process takes 10 or 20
> minutes in the night. But I do care if switching between applications
> needs >10 seconds in the morning.
>
> Would it be possible to trigger paging in specific applications from
> userspace? So I might run something like
> 
> echo -n firefox-bin > /proc/sys/vm/page-in
> echo -n soffice-bin > /proc/sys/vm/page-in
> ...

Crude, but may work:

swapoff -a
swapon -a

> after my nightly cron jobs have filled the memory with disk cache data
> that won't be useful anymore, because in my daily work I rarely touch
> 10% of the filesystem.
--
vda
