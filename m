Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129183AbQKYMt1>; Sat, 25 Nov 2000 07:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129228AbQKYMtR>; Sat, 25 Nov 2000 07:49:17 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:35077 "EHLO saturn.cs.uml.edu")
        by vger.kernel.org with ESMTP id <S129183AbQKYMtC>;
        Sat, 25 Nov 2000 07:49:02 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011251218.eAPCIpS204625@saturn.cs.uml.edu>
Subject: Re: silly [< >] and other excess
To: kaos@ocs.com.au (Keith Owens)
Date: Sat, 25 Nov 2000 07:18:51 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <6551.975150464@ocs3.ocs-net> from "Keith Owens" at Nov 25, 2000 10:07:44 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
> "Albert D. Cahalan" <acahalan@cs.uml.edu> wrote:

>> Somebody else posted a reasonable hack for the [<>] problem.
>> His proposal involved letting multiple values share the same
>> markers, something like this:
>>
>> [<c19a5cb4 c180234c c1801134 c1706550 c1800248 c1603310 c1934878 c1840324>]
>
> What happens if the line is wrapped before being fed to ksymoops?  That
> happens quite often.

You code handles far worse already, plus getting rid of all the
extra junk will make word wrapping far less common.

Robust tools don't fail just because the data isn't in one of 42
different hard-coded formats, and don't fail because of word-wrap.

> What happens with the IKD patch which adds values
> between the addresses from stack?

So use a different marker... those users with IKD are quite a bit
more likely to have a serial console anyway, so it matters little.
The current over-size format would be fine.

> Why am I even bothering to reply to
> these messages?

You are guilty of causing data loss via scrolling, and you know it.
It is not good that your choice of regular expressions should dictate
that we get stuck with oopses that don't fit on the standard screen.

> Trying to shrink the oops log to fit on a screen is an exercise in
> futility.  How do you propose to make this IA64 oops fit on 80x24?

I didn't have much trouble, even while keeping it somewhat readable.
The actual data is worth much more than register names that are
exactly the same for every oops, so it is obvious what to chop out.

> Or this one from arm?  Even without markers it is 82x47.

If the standard ARM console can hold 82x47 then that is OK.
If nearly all ARM systems are embedded devices with a serial
console, then again there is no problem. If VGA is common,
then this is a bug.

> Or this one from sparc, 106x26?  No, you cannot merge the callers
> onto multiple lines, on some traces the caller address is followed
> by the parameters to the function.

Oh yes I can merge them, using a '/' as a separator. There are plenty
of other options... but isn't the SPARC console usually 128-wide anyway?

> But hand copying an oops from an 80x24 screen
> is not going to work in the long term, see above.  Fiddling with the
> output format is a waste of time, instead work out how to capture the
> oops without relying on hand copying or a limited screen size.  Fix the
> problem, not the symptom.

The 80x25 screen really must work. Normal users don't have serial
consoles, JTAG connections, ROM-based debuggers, or anything else
reliable that can be used to capture a crash message.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
