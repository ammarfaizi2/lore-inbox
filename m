Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTIULBe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 07:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbTIULBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 07:01:34 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:36749 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262360AbTIULBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 07:01:32 -0400
Date: Sun, 21 Sep 2003 13:01:25 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.0-test5 vs. Japanese keyboards
Message-ID: <20030921110125.GB18677@ucw.cz>
References: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 12:51:32PM +0900, Norman Diamond wrote:
> In thread "Re: Trying to run 2.6.0-test3", Alan Cox replied to me:
> 
> > > What will it take this time?
> >
> > Posting the patch with any luck ?
> 
> I knew that that would not be sufficient.  On 2003.07.24, I think in the
> days of 2.6.0-test1, junkio@cox.net posted a patch for Japanese PS/2
> keyboards.  On 2003.08.31, in the days of 2.6.0-test4, I posted a revised
> patch to include Japanese USB keyboards.  2.6.0-test5 includes neither of
> them because the keyboard driver maintainers don't personally depend on
> Japanese keyboards.
> 
> Since posting has not been sufficient, I beg Mr. Pavlik, just once per
> release, please try pretending that you might have to depend on a Japanese
> keyboard.

I'd like to include the japanese keyboard fixes and have it working,
however the reports I'm getting are quite confusing. It seems that there
isn't just one kind of japanese keyboards out there ...

If you manage to tell me what exactly is what key supposed to produce,
what scancode it does have on PS/2 and what HID event it sends on USB,
I'll be more than happy to fix it all.

I'll try to dig and find the patches posted on the list and make sense
out of them in the meantime, however they often break other (non-jp)
stuff.

> You don't have to use one daily as your colleague Dr. Fabian
> does. Just twice per release, once in a plain text console and once under
> X11, please try testing a Japanese PS/2 keyboard and Japanese USB keyboard.

This might be a little problematic - I don't have any Japanese keyboard
and I don't have any idea about how to buy one.

If anyone would send me samples of Japanese keyboards, you can be sure
I'd test them.

> In particular the troublesome keys are yen bar and backslash underscore.
> You don't need a Japanese font.  If you use an ASCII font then the keys
> display as backslash bar and backslash underscore.  If you use a Japanese
> font then the keys display as yen bar and yen underscore.  In all cases the
> ASCII backslash or JIS-Romaji yen character are code point 0x5C.

IIRC these now generate proper key evens (KEY_INTL*), which are missing
in the default keymap, because the event codes are above 255, which
current 'loadkeys' utility cannot handle.

Thus this requires more work than just patching up some table. And a lot
of thinking, too, so that we both don't break older setups and make the
transition easy for new ones.

> (Don't worry about the labels on the right-hand side of each key, for direct
> kana input. 

I have yet to see a Japanese keyboard to be able to worry about it. I've
seen some pictures on the web, and that's all I've seen.

> Less than 0.1% of Japanese and other residents of Japan ever
> use direct kana input under Monopolysoft Windows, and probably none at all
> under Linux.  When inputting Japanese, common practice is to input the
> pronunciation in Italian characters and let the OS convert first to kana and
> then to Kanji.  We depend on the labels on the left-hand side of each key,
> including the two mentioned above.  Exception 1:  yen and backslash are
> really the same character even though the keys have different labels.
> Exception 2:  a shifted 0 doesn't really produce a ~ but it is enough that a
> shifted ^ does so, but it doesn't matter that Linux has added real input for
> a shifted 0.)
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
