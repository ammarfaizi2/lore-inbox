Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUFMEIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUFMEIx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 00:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264998AbUFMEIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 00:08:53 -0400
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:28580 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S264997AbUFMEIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 00:08:49 -0400
Message-ID: <40CBD34A.8030608@ThinRope.net>
Date: Sun, 13 Jun 2004 13:08:42 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: Koblinger Egmont <egmont@uhulinux.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: information leak in vga console scrollback buffer
References: <Pine.LNX.4.58L0.0406122137480.20424@sziami.cs.bme.hu> <20040612204352.GA22347@taniwha.stupidest.org> <Pine.LNX.4.58L0.0406122253580.25004@sziami.cs.bme.hu> <20040612205903.GA22428@taniwha.stupidest.org> <Pine.LNX.4.58L0.0406122301250.25004@sziami.cs.bme.hu> <40CBC094.6050901@ThinRope.net>
In-Reply-To: <40CBC094.6050901@ThinRope.net>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kalin KOZHUHAROV wrote:
> Koblinger Egmont wrote:
> 
>> On Sat, 12 Jun 2004, Chris Wedgwood wrote:
>>
>>
>>>> Rationale? (At least an rtfm-like pointer to that?)
>>>
>>>
>>> Maybe I didn't full understand you.  Generally I find it desirable to
>>> be able to read things that scrolled off the screen a long time ago.
>>> It's very useful for unattended machines if I need to 'look' back.
>>
>>
>>
>> Generally console's scrollback buffer disappears as soon as you switch to
>> another console.
>>
>> It'd be a really nice idea if all the consoles had a configurable amount
>> of scrollback buffer which is always remembered. IMHO with todays 
>> machines
>> having a scrollback buffer of 1000 lines for 6 or a little bit more
>> consoles (at most 63 IIRC) is affordable as well as the processor time
>> needed to copy the data from/to vga/normal memory on each console switch
>> and at every Nth Shift+PageUp (no matter what N is). But this is a whole
>> different story.
>>
>> What I'm talking about is: normally after people switch away from a
>> console they assume that the scrollback buffer is no longer available
>> since this is the behavior they experience normally. E.g. Z does a 'cat
>> my-long-private-file' and then logs out. Then even if getty clears the
>> screen, one can press Shift+PageUp to go back and read parts of this 
>> file.
>> Z is about to leave the computer but don't want others to be able to
>> scroll back with Shift+PageUp. So switches console (Alt+Fx) and the
>> scrollback buffer is gone. He is happy. But shouldn't be.
>>
>> With the trick I described it is possible to bring back some random parts
>> of previous texts, often some garbage with stupid flashing characters, 
>> but
>> maybe parts of Z's my-long-private-file. The behavior seems to be random
>> to me, uncontrollable by the user (I see no way to force private data to
>> be cleared from the vga buffer) and clearly not intentional.
>>
>> Please try what I wrote, I'm sure that you misunderstood me (I'm 
>> trying to
>> write as clear as I can but I'm not native English speaker and not even
>> good in English, so it might be that my bugreport is a little bit hard to
>> understand). I'm sure not talking about a feature, nor am I a Linux 
>> newbie
>> who has just seen Shift+PageUp a few days ago for the first time (even
>> though I'm very far from being a kernel hacker ;-))
>>
> OK, I think I got what you are trying to point out.
> To reproduce:
> 1. login to a (vga) console.
> 2. less /etc/services; press space t oscroll a few screens
> 3. logout
> 4. login again on the same console (possibly as a different user)
> 5. less /etc/resolv.conf
> 6. press UpArrow, then Shift+PgUp
> 
> What is expected:
> screen should not scroll past your file.
> 
> What happens:
> You can view the previous text (from /etc/services)!!!
> 
> So the point is that this buffer is persistend across logout/login, 
> which is a security bug.
> And I guess LKML is not the place for it, logout should clear the buffer 
> IMHO.
> 
> BTW, using agetty here.
> 
> Kalin.
> 
Ok, I changed agetty to mingetty (I was long waiting to do that).
However this didn't change things.
Now, playing with switching VT, however, the buffer was cleared!

So, I guess this is agetty problem then...

Also for point 2 you can do with:
2. cat /etc/services

When I logout a given box from the console, I repetedly do Alt+Left to check if there are some VT left logged in and thus I clear all the buffers as a side effect (now with mingetty).

Kalin.

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/
|||\/<" 
|||\\ ' 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
