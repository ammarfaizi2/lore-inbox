Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268666AbTBZPmC>; Wed, 26 Feb 2003 10:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268712AbTBZPmC>; Wed, 26 Feb 2003 10:42:02 -0500
Received: from franka.aracnet.com ([216.99.193.44]:60067 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268666AbTBZPmA>; Wed, 26 Feb 2003 10:42:00 -0500
Date: Wed, 26 Feb 2003 07:52:06 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       William Lee Irwin III <wli@holomorphy.com>
cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       mingo@redhat.com
Subject: Re: [BUG] 2.5.63: ESR killed my box!
Message-ID: <2880000.1046274724@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.44.0302260713210.1423-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0302260713210.1423-100000@home.transmeta.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> I put an esr_disable flag in there a while back ... does that
>> >> workaround it?
>> 
>> On Wed, Feb 26, 2003 at 06:14:42PM +1100, Rusty Russell wrote:
>> > Yes.  Hmm.  Wonder if that helps my SMP wierness, too.
>> 
>> It shouldn't be set on anything but NUMA-Q and "bigsmp".
> 
> Hmm.. Why is it right on those, but not on normal machines? The APIC is 
> the same, and if the big machines need it, apparently at least _one_
> small  machine needs it too..
> 
> Also, if we find that the ESR value was non-zero, it sounds a bit stupid 
> to enable error delivery at bootup. We already know there was an error,
> we  don't need to be told.

There's bugs in the APIC that mean that once we get an error, we never
manage to get rid of it, I believe. I don't believe Intel have ever
acknowledged that or worked around it, but I think Sequent engineers spent
a lot of time with bus analysers, etc looking at this, and that was the
ultimate conclusion. It's not like we do anything with the error anyway, so
disabling it seemed like the prudent thing to do.

Now in the case Rusty has, would be nice to find why it's changed, this was
just a workaround. On the NUMA-Qs, this always happened, so it's not so
interesting ;-)

M.

