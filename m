Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbSJHXny>; Tue, 8 Oct 2002 19:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261760AbSJHXnY>; Tue, 8 Oct 2002 19:43:24 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:63500 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S261401AbSJHXmM>;
	Tue, 8 Oct 2002 19:42:12 -0400
Subject: Re: Mouse/Keyboard problems with 2.5.38
From: Stian Jordet <liste@jordet.nu>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021008192512.B26021@ucw.cz>
References: <20020926185717.B27676@ucw.cz>
	<1033080648.593.12.camel@chevrolet> <20020927091040.B1715@ucw.cz>
	<1033127503.589.6.camel@chevrolet> <20021007150052.A1380@ucw.cz>
	<1034020510.1499.8.camel@chevrolet> <20021007220106.A1640@ucw.cz>
	<1034036449.688.8.camel@chevrolet> <20021008101711.F4290@ucw.cz>
	<1034097546.902.13.camel@chevrolet>  <20021008192512.B26021@ucw.cz>
Content-Type: multipart/mixed; boundary="=-YlyojWXtk3d03D23SKIt"
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Oct 2002 01:48:11 +0200
Message-Id: <1034120899.855.9.camel@chevrolet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YlyojWXtk3d03D23SKIt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

tir, 2002-10-08 kl. 19:25 skrev Vojtech Pavlik:
> On Tue, Oct 08, 2002 at 07:18:06PM +0200, Stian Jordet wrote:
> > tir, 2002-10-08 kl. 10:17 skrev Vojtech Pavlik:
[snip]
> > > I really wonder what your keyboard sends for those keys. To avoid the
> > > freeze (and rescanning of the keyboard), you should be able to
> > > comment-out these lines in atkbd.c:
> > > 
> > >          case ATKBD_KEY_BAT:
> > >                  serio_rescan(atkbd->serio);
> > >                  return;
> > >  
> > It didn't help at all. I just tried 2.5.41 instead of .40, and now I get
> > an Oops. Earlier it just froze. Should I write it down?
> 
> Yes!
It won't oops anymore (?) This is really weird, I don't know what I did
last night, I was terribly tired, so that must be the reason. .41 and
your alt-alt patch, does NOT crash my computer now. No oops, nothing.
Attached is a parts of my syslog with debug enabled (and with your
alt-alt patch). I logged in, did a echo cut-here >> /var/log/syslog to
know what to send you (didn't want everyone at lkml to know my root
password, for instance). Then I did this:

Right Shift+Pageup
Right Shift+Pageup
Right Shift+Pagedown
Right Shift+Pagedown
Left Shift+Pageup
Left Shift+Pageup
Left Shift+Pagedown
Left Shift+Pagedown
Right Shift+Pageup
Right Shift+Pageup
Right Shift+Pagedown
Right Shift+Pagedown
Left Shift+Pageup
Left Shift+Pageup
Left Shift+Pagedown
Left Shift+Pagedown

ARROW-UP (to get the echo-line back)
ENTER (to make a new mark in syslog).

What I have attached is what is between those cut-here marks.

When I press the right-shift and Page up, I first get unknown scancode
0x1b6. Then, I'll get 0x1aa on every button I press untill I started to
press the left-shift instead. After that, the right shift works like it
should. I'm totally confused. But I guess you're better reading the logs
than I'm. 

> > I'm starting to feel a little embarassed since I'm the only one with
> > this problem. It's not reallt a big deal, I can boot with i8042_direct,
> > and it works fine.
> 
> Once 2.5 is more public, more people will be bitten by the problem you
> have, so we need to fix it. Thanks a lot for your cooperation, and
> please pardon my confusion about who sumbitted which problem, and if I
> solved it already. :)
Well, as I'm still the only one with the problem, I'm very, very
greatful you're taking the time to try to solve this :) Sorry for the
delay.

Best regards,
Stian Jordet



--=-YlyojWXtk3d03D23SKIt
Content-Disposition: attachment; filename=syslog.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=syslog.txt; charset=ISO-8859-1

Oct  9 01:23:21 chevrolet kernel: i8042.c: 9c <- i8042 (interrupt, kbd, 1) =
[30571]
Oct  9 01:23:26 chevrolet kernel: i8042.c: 36 <- i8042 (interrupt, kbd, 1) =
[35162]
Oct  9 01:23:26 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[35357]
Oct  9 01:23:26 chevrolet kernel: i8042.c: b6 <- i8042 (interrupt, kbd, 1) =
[35363]
Oct  9 01:23:26 chevrolet kernel: atkbd.c: Unknown key (set 2, scancode 0x1=
b6, on isa0060/serio0) pressed.
Oct  9 01:23:26 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[35366]
Oct  9 01:23:26 chevrolet kernel: i8042.c: aa <- i8042 (interrupt, kbd, 1) =
[35372]
Oct  9 01:23:26 chevrolet kernel: atkbd.c: Unknown key (set 2, scancode 0x1=
aa, on isa0060/serio0) pressed.
Oct  9 01:23:26 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[35375]
Oct  9 01:23:26 chevrolet kernel: i8042.c: 49 <- i8042 (interrupt, kbd, 1) =
[35378]
Oct  9 01:23:26 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[35438]
Oct  9 01:23:26 chevrolet kernel: i8042.c: c9 <- i8042 (interrupt, kbd, 1) =
[35444]
Oct  9 01:23:26 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[35447]
Oct  9 01:23:26 chevrolet kernel: i8042.c: 36 <- i8042 (interrupt, kbd, 1) =
[35450]
Oct  9 01:23:26 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[35688]
Oct  9 01:23:26 chevrolet kernel: i8042.c: b6 <- i8042 (interrupt, kbd, 1) =
[35694]
Oct  9 01:23:26 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[35697]
Oct  9 01:23:26 chevrolet kernel: i8042.c: aa <- i8042 (interrupt, kbd, 1) =
[35703]
Oct  9 01:23:26 chevrolet kernel: atkbd.c: Unknown key (set 2, scancode 0x1=
aa, on isa0060/serio0) pressed.
Oct  9 01:23:26 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[35706]
Oct  9 01:23:26 chevrolet kernel: i8042.c: 49 <- i8042 (interrupt, kbd, 1) =
[35710]
Oct  9 01:23:26 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[35779]
Oct  9 01:23:26 chevrolet kernel: i8042.c: c9 <- i8042 (interrupt, kbd, 1) =
[35785]
Oct  9 01:23:26 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[35788]
Oct  9 01:23:26 chevrolet kernel: i8042.c: 36 <- i8042 (interrupt, kbd, 1) =
[35791]
Oct  9 01:23:26 chevrolet kernel: i8042.c: b6 <- i8042 (interrupt, kbd, 1) =
[35930]
Oct  9 01:23:28 chevrolet kernel: i8042.c: 36 <- i8042 (interrupt, kbd, 1) =
[37621]
Oct  9 01:23:28 chevrolet kernel: i8042.c: 36 <- i8042 (interrupt, kbd, 1) =
[37849]
Oct  9 01:23:28 chevrolet kernel: i8042.c: 36 <- i8042 (interrupt, kbd, 1) =
[37875]
Oct  9 01:23:28 chevrolet kernel: i8042.c: 36 <- i8042 (interrupt, kbd, 1) =
[37901]
Oct  9 01:23:28 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[37931]
Oct  9 01:23:28 chevrolet kernel: i8042.c: b6 <- i8042 (interrupt, kbd, 1) =
[37938]
Oct  9 01:23:28 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[37941]
Oct  9 01:23:28 chevrolet kernel: i8042.c: aa <- i8042 (interrupt, kbd, 1) =
[37948]
Oct  9 01:23:28 chevrolet kernel: atkbd.c: Unknown key (set 2, scancode 0x1=
aa, on isa0060/serio0) pressed.
Oct  9 01:23:28 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[37951]
Oct  9 01:23:28 chevrolet kernel: i8042.c: 51 <- i8042 (interrupt, kbd, 1) =
[37954]
Oct  9 01:23:29 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[38033]
Oct  9 01:23:29 chevrolet kernel: i8042.c: d1 <- i8042 (interrupt, kbd, 1) =
[38040]
Oct  9 01:23:29 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[38043]
Oct  9 01:23:29 chevrolet kernel: i8042.c: 36 <- i8042 (interrupt, kbd, 1) =
[38046]
Oct  9 01:23:29 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[38229]
Oct  9 01:23:29 chevrolet kernel: i8042.c: b6 <- i8042 (interrupt, kbd, 1) =
[38236]
Oct  9 01:23:29 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[38239]
Oct  9 01:23:29 chevrolet kernel: i8042.c: aa <- i8042 (interrupt, kbd, 1) =
[38245]
Oct  9 01:23:29 chevrolet kernel: atkbd.c: Unknown key (set 2, scancode 0x1=
aa, on isa0060/serio0) pressed.
Oct  9 01:23:29 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[38248]
Oct  9 01:23:29 chevrolet kernel: i8042.c: 51 <- i8042 (interrupt, kbd, 1) =
[38251]
Oct  9 01:23:29 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[38338]
Oct  9 01:23:29 chevrolet kernel: i8042.c: d1 <- i8042 (interrupt, kbd, 1) =
[38344]
Oct  9 01:23:29 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[38347]
Oct  9 01:23:29 chevrolet kernel: i8042.c: 36 <- i8042 (interrupt, kbd, 1) =
[38350]
Oct  9 01:23:29 chevrolet kernel: i8042.c: b6 <- i8042 (interrupt, kbd, 1) =
[38727]
Oct  9 01:23:33 chevrolet kernel: i8042.c: 2a <- i8042 (interrupt, kbd, 1) =
[42221]
Oct  9 01:23:33 chevrolet kernel: i8042.c: 2a <- i8042 (interrupt, kbd, 1) =
[42448]
Oct  9 01:23:33 chevrolet kernel: i8042.c: 2a <- i8042 (interrupt, kbd, 1) =
[42469]
Oct  9 01:23:33 chevrolet kernel: i8042.c: 2a <- i8042 (interrupt, kbd, 1) =
[42505]
Oct  9 01:23:33 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[42513]
Oct  9 01:23:33 chevrolet kernel: i8042.c: aa <- i8042 (interrupt, kbd, 1) =
[42519]
Oct  9 01:23:33 chevrolet kernel: atkbd.c: Unknown key (set 2, scancode 0x1=
aa, on isa0060/serio0) pressed.
Oct  9 01:23:33 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[42522]
Oct  9 01:23:33 chevrolet kernel: i8042.c: 49 <- i8042 (interrupt, kbd, 1) =
[42526]
Oct  9 01:23:33 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[42605]
Oct  9 01:23:33 chevrolet kernel: i8042.c: c9 <- i8042 (interrupt, kbd, 1) =
[42612]
Oct  9 01:23:33 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[42615]
Oct  9 01:23:33 chevrolet kernel: i8042.c: 2a <- i8042 (interrupt, kbd, 1) =
[42618]
Oct  9 01:23:33 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[42834]
Oct  9 01:23:33 chevrolet kernel: i8042.c: aa <- i8042 (interrupt, kbd, 1) =
[42840]
Oct  9 01:23:33 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[42843]
Oct  9 01:23:33 chevrolet kernel: i8042.c: 49 <- i8042 (interrupt, kbd, 1) =
[42846]
Oct  9 01:23:33 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[42921]
Oct  9 01:23:33 chevrolet kernel: i8042.c: c9 <- i8042 (interrupt, kbd, 1) =
[42928]
Oct  9 01:23:33 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[42931]
Oct  9 01:23:33 chevrolet kernel: i8042.c: 2a <- i8042 (interrupt, kbd, 1) =
[42934]
Oct  9 01:23:34 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[43501]
Oct  9 01:23:34 chevrolet kernel: i8042.c: aa <- i8042 (interrupt, kbd, 1) =
[43507]
Oct  9 01:23:34 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[43510]
Oct  9 01:23:34 chevrolet kernel: i8042.c: 51 <- i8042 (interrupt, kbd, 1) =
[43514]
Oct  9 01:23:34 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[43582]
Oct  9 01:23:34 chevrolet kernel: i8042.c: d1 <- i8042 (interrupt, kbd, 1) =
[43588]
Oct  9 01:23:34 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[43591]
Oct  9 01:23:34 chevrolet kernel: i8042.c: 2a <- i8042 (interrupt, kbd, 1) =
[43594]
Oct  9 01:23:34 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[43805]
Oct  9 01:23:34 chevrolet kernel: i8042.c: aa <- i8042 (interrupt, kbd, 1) =
[43812]
Oct  9 01:23:34 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[43814]
Oct  9 01:23:34 chevrolet kernel: i8042.c: 51 <- i8042 (interrupt, kbd, 1) =
[43818]
Oct  9 01:23:34 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[43902]
Oct  9 01:23:34 chevrolet kernel: i8042.c: d1 <- i8042 (interrupt, kbd, 1) =
[43909]
Oct  9 01:23:34 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[43912]
Oct  9 01:23:34 chevrolet kernel: i8042.c: 2a <- i8042 (interrupt, kbd, 1) =
[43916]
Oct  9 01:23:35 chevrolet kernel: i8042.c: aa <- i8042 (interrupt, kbd, 1) =
[44218]
Oct  9 01:23:35 chevrolet kernel: i8042.c: 36 <- i8042 (interrupt, kbd, 1) =
[44548]
Oct  9 01:23:35 chevrolet kernel: i8042.c: 36 <- i8042 (interrupt, kbd, 1) =
[44772]
Oct  9 01:23:35 chevrolet kernel: i8042.c: 36 <- i8042 (interrupt, kbd, 1) =
[44807]
Oct  9 01:23:35 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[44838]
Oct  9 01:23:35 chevrolet kernel: i8042.c: b6 <- i8042 (interrupt, kbd, 1) =
[44844]
Oct  9 01:23:35 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[44847]
Oct  9 01:23:35 chevrolet kernel: i8042.c: aa <- i8042 (interrupt, kbd, 1) =
[44853]
Oct  9 01:23:35 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[44856]
Oct  9 01:23:35 chevrolet kernel: i8042.c: 49 <- i8042 (interrupt, kbd, 1) =
[44859]
Oct  9 01:23:35 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[44938]
Oct  9 01:23:35 chevrolet kernel: i8042.c: c9 <- i8042 (interrupt, kbd, 1) =
[44944]
Oct  9 01:23:35 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[44948]
Oct  9 01:23:35 chevrolet kernel: i8042.c: 36 <- i8042 (interrupt, kbd, 1) =
[44951]
Oct  9 01:23:36 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[45129]
Oct  9 01:23:36 chevrolet kernel: i8042.c: b6 <- i8042 (interrupt, kbd, 1) =
[45135]
Oct  9 01:23:36 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[45138]
Oct  9 01:23:36 chevrolet kernel: i8042.c: aa <- i8042 (interrupt, kbd, 1) =
[45144]
Oct  9 01:23:36 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[45147]
Oct  9 01:23:36 chevrolet kernel: i8042.c: 49 <- i8042 (interrupt, kbd, 1) =
[45150]
Oct  9 01:23:36 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[45241]
Oct  9 01:23:36 chevrolet kernel: i8042.c: c9 <- i8042 (interrupt, kbd, 1) =
[45247]
Oct  9 01:23:36 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[45250]
Oct  9 01:23:36 chevrolet kernel: i8042.c: 36 <- i8042 (interrupt, kbd, 1) =
[45253]
Oct  9 01:23:36 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[45562]
Oct  9 01:23:36 chevrolet kernel: i8042.c: b6 <- i8042 (interrupt, kbd, 1) =
[45568]
Oct  9 01:23:36 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[45571]
Oct  9 01:23:36 chevrolet kernel: i8042.c: aa <- i8042 (interrupt, kbd, 1) =
[45577]
Oct  9 01:23:36 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[45580]
Oct  9 01:23:36 chevrolet kernel: i8042.c: 51 <- i8042 (interrupt, kbd, 1) =
[45583]
Oct  9 01:23:36 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[45668]
Oct  9 01:23:36 chevrolet kernel: i8042.c: d1 <- i8042 (interrupt, kbd, 1) =
[45674]
Oct  9 01:23:36 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[45677]
Oct  9 01:23:36 chevrolet kernel: i8042.c: 36 <- i8042 (interrupt, kbd, 1) =
[45680]
Oct  9 01:23:36 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[45837]
Oct  9 01:23:36 chevrolet kernel: i8042.c: b6 <- i8042 (interrupt, kbd, 1) =
[45844]
Oct  9 01:23:36 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[45847]
Oct  9 01:23:36 chevrolet kernel: i8042.c: aa <- i8042 (interrupt, kbd, 1) =
[45853]
Oct  9 01:23:36 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[45856]
Oct  9 01:23:36 chevrolet kernel: i8042.c: 51 <- i8042 (interrupt, kbd, 1) =
[45859]
Oct  9 01:23:36 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[45978]
Oct  9 01:23:36 chevrolet kernel: i8042.c: d1 <- i8042 (interrupt, kbd, 1) =
[45985]
Oct  9 01:23:37 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[45988]
Oct  9 01:23:37 chevrolet kernel: i8042.c: 36 <- i8042 (interrupt, kbd, 1) =
[45991]
Oct  9 01:23:37 chevrolet kernel: i8042.c: b6 <- i8042 (interrupt, kbd, 1) =
[46075]
Oct  9 01:23:40 chevrolet kernel: i8042.c: 2a <- i8042 (interrupt, kbd, 1) =
[49722]
Oct  9 01:23:40 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[49889]
Oct  9 01:23:40 chevrolet kernel: i8042.c: aa <- i8042 (interrupt, kbd, 1) =
[49895]
Oct  9 01:23:40 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[49898]
Oct  9 01:23:40 chevrolet kernel: i8042.c: 49 <- i8042 (interrupt, kbd, 1) =
[49901]
Oct  9 01:23:40 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[49970]
Oct  9 01:23:40 chevrolet kernel: i8042.c: c9 <- i8042 (interrupt, kbd, 1) =
[49976]
Oct  9 01:23:40 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[49979]
Oct  9 01:23:40 chevrolet kernel: i8042.c: 2a <- i8042 (interrupt, kbd, 1) =
[49982]
Oct  9 01:23:41 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[50105]
Oct  9 01:23:41 chevrolet kernel: i8042.c: aa <- i8042 (interrupt, kbd, 1) =
[50111]
Oct  9 01:23:41 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[50114]
Oct  9 01:23:41 chevrolet kernel: i8042.c: 49 <- i8042 (interrupt, kbd, 1) =
[50117]
Oct  9 01:23:41 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[50198]
Oct  9 01:23:41 chevrolet kernel: i8042.c: c9 <- i8042 (interrupt, kbd, 1) =
[50204]
Oct  9 01:23:41 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[50207]
Oct  9 01:23:41 chevrolet kernel: i8042.c: 2a <- i8042 (interrupt, kbd, 1) =
[50210]
Oct  9 01:23:41 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[50486]
Oct  9 01:23:41 chevrolet kernel: i8042.c: aa <- i8042 (interrupt, kbd, 1) =
[50493]
Oct  9 01:23:41 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[50496]
Oct  9 01:23:41 chevrolet kernel: i8042.c: 51 <- i8042 (interrupt, kbd, 1) =
[50499]
Oct  9 01:23:41 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[50579]
Oct  9 01:23:41 chevrolet kernel: i8042.c: d1 <- i8042 (interrupt, kbd, 1) =
[50585]
Oct  9 01:23:41 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[50588]
Oct  9 01:23:41 chevrolet kernel: i8042.c: 2a <- i8042 (interrupt, kbd, 1) =
[50591]
Oct  9 01:23:41 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[50726]
Oct  9 01:23:41 chevrolet kernel: i8042.c: aa <- i8042 (interrupt, kbd, 1) =
[50732]
Oct  9 01:23:41 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[50735]
Oct  9 01:23:41 chevrolet kernel: i8042.c: 51 <- i8042 (interrupt, kbd, 1) =
[50738]
Oct  9 01:23:41 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[50834]
Oct  9 01:23:41 chevrolet kernel: i8042.c: d1 <- i8042 (interrupt, kbd, 1) =
[50840]
Oct  9 01:23:41 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[50843]
Oct  9 01:23:41 chevrolet kernel: i8042.c: 2a <- i8042 (interrupt, kbd, 1) =
[50846]
Oct  9 01:23:42 chevrolet kernel: i8042.c: aa <- i8042 (interrupt, kbd, 1) =
[51344]
Oct  9 01:23:43 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[52184]
Oct  9 01:23:43 chevrolet kernel: i8042.c: 48 <- i8042 (interrupt, kbd, 1) =
[52187]
Oct  9 01:23:43 chevrolet kernel: i8042.c: e0 <- i8042 (interrupt, kbd, 1) =
[52283]
Oct  9 01:23:43 chevrolet kernel: i8042.c: c8 <- i8042 (interrupt, kbd, 1) =
[52290]
Oct  9 01:23:45 chevrolet kernel: i8042.c: 1c <- i8042 (interrupt, kbd, 1) =
[54255]
--=-YlyojWXtk3d03D23SKIt--

