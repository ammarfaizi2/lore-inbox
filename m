Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132104AbQLHUs3>; Fri, 8 Dec 2000 15:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132739AbQLHUsT>; Fri, 8 Dec 2000 15:48:19 -0500
Received: from [212.137.214.171] ([212.137.214.171]:5648 "EHLO
	Consulate.UFP.CX") by vger.kernel.org with ESMTP id <S132104AbQLHUsO>;
	Fri, 8 Dec 2000 15:48:14 -0500
Date: Fri, 8 Dec 2000 10:33:18 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: That horrible hack from hell called A20
In-Reply-To: <3A2D91F0.D8FE8BBC@transmeta.com>
Message-ID: <Pine.LNX.4.21.0012081022410.16041-100000@Consulate.MemAlpha.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter.

On Tue, 5 Dec 2000, H. Peter Anvin wrote:

> Linus Torvalds wrote:

>> Actually, I bet I know what's up.
>>
>> Want to bet $5 USD that suspend/resume saves the keyboard A20 state,
>> but does NOT save the fast-A20 gate information?
>>
>> So anything that enables A20 with only the fast A20 gate will find
>> that A20 is disabled again on resume.
>>
>> Which would make Linux _really_ unhappy, needless to say. Instant
>> death in the form of a triple fault (all of the Linux kernel code is
>> in the 1-2MB area, which would be invisible), resulting in an
>> instant reboot.
>>
>> Peter, we definitely need to do the keyboard A20, even if fast-A20
>> works fine.

> Yup.  It's a BIOS bug, oh what a shocker... (that never happens,
> right)?

One alternative would presumably be to reserve a block in the 0-1M
region for a routine to be called on resume that makes sure everything
is set up correctly.  However, from the various comments, I gather that
such is not viable as it's already been excluded for other reasons, but
nobody seems to say precicely what the problems with this idea are?

I would presume such a routine would be set up such that when it's time
to suspend, a call is made to that routine at its 0-1M address, so when
the resume kicks in, it sees an IP in the 0-1M region to resume to.

As part of the kernel start-up, the kernel would reserve the page in
question, then copy the suspend/resume code to it, and only then would
it enable the suspend/resume facility.

Best wishes from Riley.

---
 * Why didn't Linus Torvalds write the resume specification,
 * rather than those idiots at MacroHard !!!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
