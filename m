Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264987AbUFMDrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264987AbUFMDrx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 23:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264989AbUFMDrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 23:47:53 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:31175 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S264987AbUFMDrt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 23:47:49 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Kalin KOZHUHAROV <kalin@ThinRope.net>
Cc: Koblinger Egmont <egmont@uhulinux.hu>, LKML <linux-kernel@vger.kernel.org>
Date: Sat, 12 Jun 2004 20:47:26 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: information leak in vga console scrollback buffer
In-Reply-To: <40CBC094.6050901@ThinRope.net>
Message-ID: <Pine.LNX.4.60.0406122045510.11624@dlang.diginsite.com>
References: <Pine.LNX.4.58L0.0406122137480.20424@sziami.cs.bme.hu>
 <20040612204352.GA22347@taniwha.stupidest.org> <Pine.LNX.4.58L0.0406122253580.25004@sziami.cs.bme.hu>
 <20040612205903.GA22428@taniwha.stupidest.org> <Pine.LNX.4.58L0.0406122301250.25004@sziami.cs.bme.hu>
 <40CBC094.6050901@ThinRope.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

no, that isn't what he's talking about.

the console scrollback has never had any concept of login/logout so what 
you did is per spec and is a feature

if you switch to a different console between steps 3 and 4 and then switch 
back you will see what Koblinger is talking about.

David Lang


On Sun, 13 Jun 2004, Kalin KOZHUHAROV wrote:

> Date: Sun, 13 Jun 2004 11:48:52 +0900
> From: Kalin KOZHUHAROV <kalin@ThinRope.net>
> To: Koblinger Egmont <egmont@uhulinux.hu>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Subject: Re: information leak in vga console scrollback buffer
> 
> Koblinger Egmont wrote:
>> On Sat, 12 Jun 2004, Chris Wedgwood wrote:
>> 
>> 
>>>> Rationale? (At least an rtfm-like pointer to that?)
>>> 
>>> Maybe I didn't full understand you.  Generally I find it desirable to
>>> be able to read things that scrolled off the screen a long time ago.
>>> It's very useful for unattended machines if I need to 'look' back.
>> 
>> 
>> Generally console's scrollback buffer disappears as soon as you switch to
>> another console.
>> 
>> It'd be a really nice idea if all the consoles had a configurable amount
>> of scrollback buffer which is always remembered. IMHO with todays machines
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
>> screen, one can press Shift+PageUp to go back and read parts of this file.
>> Z is about to leave the computer but don't want others to be able to
>> scroll back with Shift+PageUp. So switches console (Alt+Fx) and the
>> scrollback buffer is gone. He is happy. But shouldn't be.
>> 
>> With the trick I described it is possible to bring back some random parts
>> of previous texts, often some garbage with stupid flashing characters, but
>> maybe parts of Z's my-long-private-file. The behavior seems to be random
>> to me, uncontrollable by the user (I see no way to force private data to
>> be cleared from the vga buffer) and clearly not intentional.
>> 
>> Please try what I wrote, I'm sure that you misunderstood me (I'm trying to
>> write as clear as I can but I'm not native English speaker and not even
>> good in English, so it might be that my bugreport is a little bit hard to
>> understand). I'm sure not talking about a feature, nor am I a Linux newbie
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
> So the point is that this buffer is persistend across logout/login, which is 
> a security bug.
> And I guess LKML is not the place for it, logout should clear the buffer 
> IMHO.
>
> BTW, using agetty here.
>
> Kalin.
>
> -- 
> ||///_ o  *****************************
> ||//'_/>     WWW: http://ThinRope.net/
> |||\/<" |||\\ ' ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
