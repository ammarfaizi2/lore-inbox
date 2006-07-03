Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWGCPTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWGCPTu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 11:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWGCPTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 11:19:50 -0400
Received: from terminus.zytor.com ([192.83.249.54]:9182 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751198AbWGCPTt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 11:19:49 -0400
Message-ID: <44A93563.70601@zytor.com>
Date: Mon, 03 Jul 2006 08:18:59 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 7/8] inode-diet: Use a union for i_blocks and i_size,
 i_rdev and i_devices
References: <20060703005333.706556000@candygram.thunk.org> <20060703010023.720991000@candygram.thunk.org> <20060703090642.GB8242@infradead.org> <20060703140217.GA8099@thunk.org>
In-Reply-To: <20060703140217.GA8099@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> On Mon, Jul 03, 2006 at 10:06:42AM +0100, Christoph Hellwig wrote:
>> On Sun, Jul 02, 2006 at 08:53:40PM -0400, Theodore Ts'o wrote:
>>> The i_blocks and i_size fields are only used for regular files.  So we
>>> move them into the union, along with i_rdev and i_devices, which are
>>> only used by block or character devices.
>> Can we please make this a named instead of unnamed union so everyone still
>> using the fields will trip up?  To reduce the impact a few more imajor/iminor
>> conversions might be needed were direct references to i_rdev crept back in.
> 
> I did that originally but when I sent out my first version of patches
> for review, other developers asked me to use an unnamed union ---
> since otherwise the patch would be much, much larger (lots of changes
> would need to be made) and that makes it much harder to merge into
> either Andrew's or Linus's tree.
> 
> What do other people think?  I can go either way on this one.
> 

I think people need to know they're using a union, and hence it should 
be named.  Otherwise it's really easy to stare blindly at a piece of 
code, not understanding why touching i_foo affects i_bar.

	-hpa
