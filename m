Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUD3Hwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUD3Hwu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 03:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbUD3Hwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 03:52:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20414 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265093AbUD3Hwr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 03:52:47 -0400
Message-ID: <409205C1.7000700@pobox.com>
Date: Fri, 30 Apr 2004 03:52:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andy Isaacson <adi@hexapodia.org>, pj@sgi.com, vonbrand@inf.utfsm.cl,
       nickpiggin@yahoo.com.au, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <40904A84.2030307@yahoo.com.au>	<200404292001.i3TK1BYe005147@eeyore.valparaiso.cl>	<20040429133613.791f9f9b.pj@sgi.com>	<20040429141947.1ff81104.akpm@osdl.org>	<20040429143403.35a7a550.pj@sgi.com>	<20040429145725.267ea7b8.akpm@osdl.org>	<20040430000408.GA29096@hexapodia.org> <20040429173223.3ea4d0c5.akpm@osdl.org>
In-Reply-To: <20040429173223.3ea4d0c5.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Andy Isaacson <adi@hexapodia.org> wrote:
> 
>> But in a related case, I have a background daemon that does a lot of IO
>> (mostly sequential, one page at a time read/modify/write of a multi-GB
>> file) to a filesystem on a separate spindle from my main filesystems.
>> I'd like to use a similar mechanism to say "don't let this program eat
>> my pagecache" that will let the daemon crunch away without severely
>> impacting my desktop work.
> 
> 
> fadvise(POSIX_FADV_DONTNEED) is ideal for this.  Run it once per megabyte
> or so.


Sweet.  I'm so happy you added posix_fadvise (way back when), and even 
happier to hear this.

Does our fadvise support len==0 ("I mean the whole file")?  That's 
defined in POSIX, and would allow a compliant app to simply 
POSIX_FADV_DONTNEED once at the beginning.

	Jeff



