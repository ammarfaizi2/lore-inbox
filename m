Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbTKZLvI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 06:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264156AbTKZLvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 06:51:07 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:42913 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264155AbTKZLvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 06:51:06 -0500
Subject: Re: 2.4.20-18 size-4096 memory leaks
From: "Stephen C. Tweedie" <sct@redhat.com>
To: yuval yeret <yuval_yeret@hotmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <BAY2-F65DwLK4adtttY00010f98@hotmail.com>
References: <BAY2-F65DwLK4adtttY00010f98@hotmail.com>
Content-Type: text/plain
Organization: 
Message-Id: <1069847462.2031.3.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Nov 2003 11:51:02 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2003-11-26 at 09:29, yuval yeret wrote:

> I saw a discussion around similar problems in 2.6.0 (2.6.0-test5/6 (and 
> probably 7 too) size-4096 memory leak - http://lkml.org/lkml/2003/10/17/5 )
> and an ext3 patch was suggested by Andrew Morton.
> 
> From a brief look the code in 2.4 it seems like the patch might be relevant 
> here as well. Is the size-4096 leak a known issue for 2.4 ?
> Is the 2.6 patch applicable in 2.4 as well ?

No.  The journal_release_buffer() code is not used, or even enabled, on
2.4.  There is one set of patches which can use it on 2.4 --- the EA/ACL
code does, but only for extended attributes, and the leak mentioned
above only affects release_buffer() on bitmap buffers.

Cheers,
 Stephen


