Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265346AbUAFWVz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 17:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUAFWVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 17:21:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64518 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265346AbUAFWVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 17:21:53 -0500
Message-ID: <3FFB34C9.5010305@zytor.com>
Date: Tue, 06 Jan 2004 14:20:57 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: autofs <autofs@linux.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
References: <3FFB12AD.6010000@sun.com> <3FFB223A.8000606@zytor.com> <20040106215018.GA911@sun.com> <3FFB316A.6000004@zytor.com> <20040106221502.GA7398@hockin.org>
In-Reply-To: <20040106221502.GA7398@hockin.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> On Tue, Jan 06, 2004 at 02:06:34PM -0800, H. Peter Anvin wrote:
> 
>>>Can you maybe share some details?  I think this deign moves MORE state to
>>>userspace (expiry aside).  The "state" in kernel is really mostly sent back
>>>to userspace.  No more passing pipes into the kernel (state) or tracking the
>>>pgid of the daemon (state).
>>
>>If you want to fire up a new daemon, all that state that was supposed to
>>be kept in userspace has to be reconstructed.  That means the kernel has
>>to have all that information; this would include stuff like what kind of
>>umount policy you want for each key entry (the current daemon doesn't do
>>that because it doesn't have the proper state.)
> 
> I'm not really sure what you're saying., here.  I'm sorry.  Not trying to be
> thick, just not understanding.
> 
> What umount policy?  What state is supposed to be kept in userspace that isn't?
> 

The current autofs daemon, for example, does not handle different
procedures on umount.  This is particularly important when you have
mount trees.

> 
>>>The daemon as it stands does NOT handle namespaces, does NOT handle expiry
>>>well, and is a pretty sad copy of an old design.
>>
>>First of all, I'll be blunt: namespaces currently provide zero benefit
>>in Linux, and virtually noone uses them.  I have discussed this with
>>Linus in the past, and neither one of us see namespaces as being worth
> 
> Let's get rid of them, then.  Make life that much easier.
> 

That's what the Linux community is doing, de facto.  The Linux userspace
simply is not set up to handle namespaces, and the autofs daemon is no
exception.  Consider such a simple thing as /etc/mtab - /proc/mounts
which is necessary for most of the mount(8) functionality to work.  It
doesn't support namespaces and really cannot be made to.

namespace support in Linux is at the best a far-off future goal.  It is
one thing to put in infrastructure, especially since it has some other
nice benefits; it's another thing to revamp all of userspace to use it;
it's nowhere close and autofs is no exception.

	-hpa

