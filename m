Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267365AbUJNTVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267365AbUJNTVv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 15:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267361AbUJNTUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:20:53 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:52745 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267365AbUJNTJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:09:01 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Dave Jones <davej@redhat.com>, Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] General purpose zeroed page slab
Date: Thu, 14 Oct 2004 22:08:49 +0300
User-Agent: KMail/1.5.4
Cc: Brian Gerst <bgerst@didntduck.org>,
       "Martin K. Petersen" <mkp@wildopensource.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, akpm@osdl.org,
       tony.luck@intel.com
References: <yq1oej5s0po.fsf@wilson.mkp.net> <20041014173637.GQ16153@parcelfarce.linux.theplanet.co.uk> <20041014184915.GE18321@redhat.com>
In-Reply-To: <20041014184915.GE18321@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410142208.49831.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 October 2004 21:49, Dave Jones wrote:
> On Thu, Oct 14, 2004 at 06:36:37PM +0100, Matthew Wilcox wrote:
>  > On Thu, Oct 14, 2004 at 01:30:21PM -0400, Brian Gerst wrote:
>  > > This doesn't work as you expect it does.  The constructor is only called 
>  > > when a new slab is created, for each new object on the slab.  It is 
>  > > _not_ run again when an object is freed.  So if a page is freed then 
>  > > immediately reallocated it will contain garbage.
>  > 
>  > The user is responsible for zeroing the page before handing it back to
>  > the slab allocator.

BTW, zeroing with non-temporal stores may be a huge win here.
It is 300% faster on Athlon.

> That sounds like an accident waiting to happen.
> How about a CONFIG_DEBUG option to check its zeroed on free ?
--
vda

