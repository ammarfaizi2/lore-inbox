Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbTIUN2P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 09:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbTIUN2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 09:28:14 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:30688 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S262406AbTIUN2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 09:28:02 -0400
Message-ID: <0a5f01c38043$f9c35c80$44ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Cc: <linux-kernel@vger.kernel.org>, "John Bradford" <john@grabjohn.com>
References: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60> <20030921110125.GB18677@ucw.cz>
Subject: Re: 2.6.0-test5 vs. Japanese keyboards
Date: Sun, 21 Sep 2003 22:26:04 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

> I'd like to include the japanese keyboard fixes and have it working,
> however the reports I'm getting are quite confusing. It seems that there
> isn't just one kind of japanese keyboards out there ...

The most common kinds are:

1.  PS/2 JP106 layout.  Electrically it is the same as any other PS/2
keyboard.

In the upper left, near the Esc key, is the hankaku/zenkaku key.  The scan
code is the same as the US backquote tilde key.  In Japanese Monopolysoft
systems it turns the IME on or off.  This key does not produce input by
itself, but of course the scan code is used in turning the IME on or off.
In Linux traditionally it does not produce input, but I think that the
"ATOK" IME might need to be informed of keypresses.

(Historically this key used to switch between half-width and full-width
characters, but Alt + hankaku/zenkaku turned the IME on or off.  Now the use
of Alt with this key is optional for this purpose, and a different operation
is needed to get half-width characters.)

To the left of the space key is the muhenkan key.  To the right of the space
key are the henkan key and hiragana/katakana key.  In Monopolysoft systems
these affect the IME.  They do not produce input by themselves but the scan
codes are used in controlling the IME.  In Linux traditionally they do not
produce input, but I think that the "ATOK" IME might need to be informed of
keypresses.

Near the upper right is the yen bar key.  The scan code is one which doesn't
exist on a US keyboard.  In Japanese character sets, the half-width
single-byte yen symbol is 0x5C, the same as the ASCII backslash.  If a US
font is used then the character displays as a backslash.  C programs and
Monopolysoft filesystems and everything interpret it the same as a backslash
because the codepoint is the same (0x5C).  When shifted it is an or bar, the
same code point as an ASCII or bar.

Near the lower right is the backslash underscore key.  The scan code is one
which doesn't exist on a US keyboard.  If a Japanese font is used then the
backslash displays as a half-width single-byte yen symbol because the code
is the same (0x5C).  In other words, the unshifted yen key and unshifted
backslash key are redundant, only one is needed, but this is not true of the
shifted versions.  When shifted this one is an underscore, the same code
point as an ASCII underscore.

Regarding the caret tilde key, traditionally this was a caret overbar key.
In Japanese character sets, the overbar is the same code point as the ASCII
tilde.  But no one displays it as an overbar any more, everyone displays it
as a tilde.  The overbar graphic is virtually forgotten, though on some
keyboards the label still displays it as an overbar, just to cause confusion
between the underscore and the overbar.  The scan code is the same as a US
keyboard's plus and equal key.

Regarding the 0 key (digit 0), it is most common for the keyboard's label to
display a tilde above the 0.  When unshifted this key inputs a 0.  When
shifted this key normally does not input anything, though the scan code is
observed and discarded by the driver.  The exception is that Linux accepts
the scan code even when shifted, and inputs a tilde, the same code point as
the overbar or tilde mentioned above.  Linux added this redundancy which
does not hurt, but it's really irrelevant.

Other keys have pretty much obvious meanings.  The alphabetic QWERTY layout
is the same as a US keyboard but all the punctuation marks are moved around.

(Mr. Bradford's keyboard is strange.  If his shifted 0 produces a tilde as
input even to Monopolysoft operating systems, well then OK I believe him,
but we already know his keyboard is strange.)

(By the way, NEC no longer makes old 9800 machines.  Modern NEC PS/2
keyboards are the same as other PS/2 keyboards.)

2.  USB JP106 layout.  The scan codes of the yen bar, backslash underscore,
muhenkan, henkan, and hiragana/katakana keys are different from the PS/2
keyboard's scan codes.  The driver's mapping of scan codes from USB scan
codes to PS/2 scan codes must map these keys to match what keyboards do.
When you invented other International scan codes for them, they did not
work.  In the middle of the 2.4 series this was finally accepted, though I'm
not sure if you were the one who finally accepted it, or if Dr. Fabian
persuaded others.

(By the way, NEC no longer makes old 9800 machines.  Modern NEC USB
keyboards are the same as other USB keyboards.  But Macintosh is different
from other USB keyboards.)

3.  Old NEC 9800 keyboards.  Some old 9800 machines are powerful enough to
run Linux, and some can even run XFree86.  So some people have even made the
old keyboards work with Linux.  I don't know details though.  I have never
bought nor mailed one of these.

4.  Macintosh keyboards.  They use USB but their scan codes are different
from everyone else's.  My understanding is that the 2.4 kernel correctly
mapped Macintosh's scan codes earlier than it did for ordinary USB
keyboards.  But I never tried it myself, don't know details, and have never
bought nor mailed one.

> If you manage to tell me what exactly is what key supposed to produce,
> what scancode it does have on PS/2 and what HID event it sends on USB,
> I'll be more than happy to fix it all.

I'm relieved to see your present opinion.  Thank you.  But I think you can
look in 2.4 kernels to see the answer.

In addition, if you use showkey -s to view scan codes, you must use a 2.4
kernel.  2.6 is broken enough to even make showkey -s output garbage.

> I'll try to dig and find the patches posted on the list

One message-id is <qwxq.74V.3@gated-at.bofh.it> but I don't think this is an
original LKML message-id.  Because of the hack I had to use in posting (to
preserve tab characters instead of letting Monopolysoft Lookout change them
to spaces), I don't have any other message-id for it.  The date was
2003.8.31 and subject line was:  [PATCH] 2.6.0-test4, Japanese USB
keyboards, keycodes 181 and 183.

> however they often break other (non-jp) stuff.

I sincerely doubt that.  I think that the scan codes involved here are not
used in conflicting manners on other keyboards.

> If anyone would send me samples of Japanese keyboards, you can be sure
> I'd test them.

Thank you!  I was afraid to ask in advance because I thought that you would
either refuse or you would ignore the suggestion.  Dr. Brouwer did refuse,
about 3 years ago or so.  I could not take a chance on you refusing, because
I know that you really really need them.  I sent a sea mail package on
2003.8.31 (same date as posting that patch).  It should arrive in a few more
weeks.  It is addressed to you at the address of SuSE, copied from your
company's web site.

> > In particular the troublesome keys are yen bar and backslash underscore.
> > You don't need a Japanese font.  If you use an ASCII font then the keys
> > display as backslash bar and backslash underscore.
>
> IIRC these now generate proper key evens (KEY_INTL*),

I commented on this above.

> which are missing in the default keymap,

Yes.

> because the event codes are above 255,

I don't understand your event codes very well.  But showkey -s still
produces garbage, so there is still something broken between scan codes and
event codes.  On a Japanese PS/2 keyboard, all scan codes are below (or
maybe equal to) 127.  On a Japanese USB keyboard, scan codes can go up to
255.  The troublesome keys are in the range from 128 to 255.

> Thus this requires more work than just patching up some table. And a lot
> of thinking, too, so that we both don't break older setups and make the
> transition easy for new ones.

I can't speak for future transitions, but the present breakage does break
current machines exactly in the way you say you can't.

