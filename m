Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKYGLg>; Sat, 25 Nov 2000 01:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129183AbQKYGL0>; Sat, 25 Nov 2000 01:11:26 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:24850 "EHLO saturn.cs.uml.edu")
        by vger.kernel.org with ESMTP id <S129153AbQKYGLL>;
        Sat, 25 Nov 2000 01:11:11 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011250541.eAP5f1s242513@saturn.cs.uml.edu>
Subject: Re: kernel-2.4.0-test11 crashed again; this time i send you the Oops-message
To: kaos@ocs.com.au (Keith Owens)
Date: Sat, 25 Nov 2000 00:41:01 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <3445.974945945@kao2.melbourne.sgi.com> from "Keith Owens" at Nov 23, 2000 01:19:05 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
> "Albert D. Cahalan" <acahalan@cs.uml.edu> wrote:

>> The infamous LINK_FIRST infrastructure was sort of half-way done.
>>
>> It would be best to cause drivers with an unspecified link order
>> to move around a bit, so that errors may be discovered more quickly.
>
> The "other" list in LINK_FIRST is sorted by name.  It could be changed
> to a random sort, probably based on a hash of size and mtime.  It would
> be relatively expensive so would have to be restricted to a "exercise
> the kernel" CONFIG option.

Yes, throwing out the low bits of mtime so that everybody gets the
same link order for a week. (must be able to reproduce failures)

>> LINK_FIRST is pretty coarse. One would want a topological sort,
>> or at least LINK_0 through LINK_9 _without_ anything else.
>
> There is no need for multiple LINK_n entries, the objects partition
> neatly into three groups.  LINK_FIRST objects, in the order they are
> defined.  The rest of the objects (object list - (LINK_FIRST +
> LINK_LAST), in an undefined order.  LINK_LAST objects, in the order
> they are defined.

Ah, but then Linus has an argument to crush you. There is no
reason left to have anything but LINK_FIRST, and so the rest
is redundant and you can just kill the whole idea.

Going with multiple LINK_n entries and nothing else makes it
possible to make order dynamic within any LINK_n group. This
forces eventual discovery of any problems.

> If you can come up with a concrete link order example that
> cannot be handled by a three partition model then I will
> listen.  Otherwise it is just over engineering.

The three-partition model is over-engineering, because it adds
extra complexity without getting rid of the fixed-order group.
Instead you get two fixed-order groups and one dynamic-order one.

If we are to leave the current model of a single fixed-order
group, then we ought to switch to something else uniform.
The three groups you desribe just isn't very regular.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
