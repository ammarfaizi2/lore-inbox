Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVFUT5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVFUT5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 15:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVFUT4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 15:56:24 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:56449 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262281AbVFUT4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 15:56:04 -0400
Message-ID: <42B870CF.1010205@ammasso.com>
Date: Tue, 21 Jun 2005 14:55:59 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.8) Gecko/20050511 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: get_user_pages() and shared memory question
References: <42B82DF2.2050708@ammasso.com> <42B86DF1.7000102@ens-lyon.org>
In-Reply-To: <42B86DF1.7000102@ens-lyon.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin wrote:

> Preventing the driver from doing this would probably be the
> right solution here... If the driver called get_user_pages,
> it is its responsibility to release the pages.

The driver does release the pages, but only when asked to do so.  If the process dies, 
then the driver automatically cleans up, but otherwise how is the driver to know that the 
memory is no longer needed?

Perhaps you mean that the driver should release the pages before it exits.  Unfortunately, 
that defeats the purpose of calling get_user_pages() in the first place.  The driver needs 
to pin the application's buffers so that the subsequent DMA operations work.  This driver 
supports an RDMA adapter that transfer network data directly to the application's buffers.

You're probably now thinking, "Well, why doesn't the driver just allocate the buffers on 
behalf of the app?"  There are two reasons why we can't do that.  One, the app may need 
have gigabytes of memory for the RDMA operations.  Two, the APIs we need to support allow 
the app to allocate memory any way it sees fit.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
