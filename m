Return-Path: <linux-kernel-owner+w=401wt.eu-S1750804AbXAKQK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbXAKQK5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 11:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbXAKQK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 11:10:57 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:50731 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbXAKQK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 11:10:56 -0500
Subject: Re: O_DIRECT question
From: Badari Pulavarty <pbadari@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, lkml <linux-kernel@vger.kernel.org>,
       hch@infradead.org, kenneth.w.chen@intel.com, torvalds@osdl.org,
       mjt@tls.msk.ru
In-Reply-To: <20070110205157.4aca3689.akpm@osdl.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
	 <20070110205157.4aca3689.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 11 Jan 2007 08:09:41 -0800
Message-Id: <1168531781.4881.119.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-10 at 20:51 -0800, Andrew Morton wrote:
> On Thu, 11 Jan 2007 10:57:06 +0800
> Aubrey <aubreylee@gmail.com> wrote:
> 
> > Hi all,
> > 
> > Opening file with O_DIRECT flag can do the un-buffered read/write access.
> > So if I need un-buffered access, I have to change all of my
> > applications to add this flag. What's more, Some scripts like "cp
> > oldfile newfile" still use pagecache and buffer.
> > Now, my question is, is there a existing way to mount a filesystem
> > with O_DIRECT flag? so that I don't need to change anything in my
> > system. If there is no option so far, What is the right way to achieve
> > my purpose?
> 
> Not possible, basically.
> 
> O_DIRECT reads and writes must be aligned to the device's block size
> (usually 512 bytes) in memory addresses, file offsets and read/write request
> sizes.  Very few applications will bother to do that and will hence fail if
> their files are automagically opened with O_DIRECT.

I worked on patches to take away the 512-byte restriction for memory
addresses a while ago - but had to use 4-byte alignment for some 
drivers to make it work. I gave up since, there was no way for me
to methodically prove that it will work on all drivers :(

O_DIRECT mount option is the one our software group people keep
asking for (since they use it on Solaris) - we keep telling them
NO !! Their basic complaint *was* - use/population of pagecache 
by other applications (tar, ftp, scp, backup) in the system, 
causing performance degrade for their application. But again,
2.6.x had gotten lot better and we have hundreds of tunables
to control various behaviours and problem can be *theoritically*
worked around with these tunables.

Thanks,
Badari

