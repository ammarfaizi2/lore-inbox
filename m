Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318814AbSICQwp>; Tue, 3 Sep 2002 12:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318815AbSICQwp>; Tue, 3 Sep 2002 12:52:45 -0400
Received: from mail.iolinc.net ([206.102.147.2]:47378 "EHLO
	iolmail.camelot.iolinc.net") by vger.kernel.org with ESMTP
	id <S318814AbSICQwh>; Tue, 3 Sep 2002 12:52:37 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Gene Heskett <gene_heskett@iolinc.net>
Organization: None that appears to be detectable by casual observers
To: jbradford@dial.pipex.com
Subject: Re: [kde-linux] Can't find qt libs...
Date: Tue, 3 Sep 2002 12:56:57 -0400
User-Agent: KMail/1.4.2
Cc: linux-kernel@vger.kernel.org, kde-linux@mail.kde.org
References: <200209031348.g83Dm0Jb003201@darkstar.example.net>
In-Reply-To: <200209031348.g83Dm0Jb003201@darkstar.example.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209031256.57995.gene_heskett@iolinc.net>
X-Note: This E-mail was scanned by Declude JunkMail (www.declude.com) for spam.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 September 2002 09:48, jbradford@dial.pipex.com wrote:

Sorry this turned into the weekly fishwrap, it got long.

>> And its not just kde. I have several things that won't configure
>> because the *&%&^%$ libqt-mt.so in >= qt-3.0.2 can't be found.
>> There are 4 copies of 3.0.4 scattered about my system.  Its a
>> real problem that so far everyone seems to think will go away if
>> our $QTDIR is set correctly, and/or we use the --with-qt-libs=
>> options.
>>
>> It doesn't go away no matter how much the rest of this list
>> wishes *we* would.
>
>Err, it sounds to me like you are not running ldconfig after
> installing a library.  Are you?

Probably overkill, but 50+ times I'd guess, each time as I re-arranged the order of the listing in /etc/ld.so.conf, which currently looks like this:

/usr/kerberos/lib
/usr/X11R6/lib
/usr/local/kde/lib
/usr/lib
/usr/lib/qt-2.3.1/lib
/usr/lib/qt-1.45/lib
/usr/lib/qt2/lib
/usr/local/lib
/usr/local/lib/sane
/usr/lib/qt-3.0.4/lib

Those libraries are, according to locate:
[root@coyote root]# ls -l `locate libqt-mt.so`
17 Jul  8 10:08 /usr/garnome/lib/libqt-mt.so -> libqt-mt.so.3.0.4
17 Jul  8 10:08 /usr/garnome/lib/libqt-mt.so.3 -> libqt-mt.so.3.0.4
17 Jul  8 10:08 /usr/garnome/lib/libqt-mt.so.3.0 -> libqt-mt.so.3.0.4
7317992 Jul  7 22:04 /usr/garnome/lib/libqt-mt.so.3.0.4

17 Aug 8  23:17 /usr/lib/qt-3.0.4/lib/libqt-mt.so -> libqt-mt.so.3.0.4  <-was missing
17 Aug  8 23:17 /usr/lib/qt-3.0.4/lib/libqt-mt.so.3 -> libqt-mt.so.3.0.4
17 Aug  8 23:17 /usr/lib/qt-3.0.4/lib/libqt-mt.so.3.0 -> libqt-mt.so.3.0.4
7689615 May  7 16:25 /usr/lib/qt-3.0.4/lib/libqt-mt.so.3.0.4

17 Jul  8 19:25 /usr/local/qt/lib/libqt-mt.so -> libqt-mt.so.3.0.4
17 Jul  8 19:25 /usr/local/qt/lib/libqt-mt.so.3 -> libqt-mt.so.3.0.4
17 Jul  8 19:25 /usr/local/qt/lib/libqt-mt.so.3.0 -> libqt-mt.so.3.0.4
7318821 Jul  8 19:25 /usr/local/qt/lib/libqt-mt.so.3.0.4

17 Jul  7 21:40 /usr/src/garnome-0.12.2/kde/qt-copy/work/qt-copy-3.0.4/lib/libqt-mt.so -> libqt-mt.so.3.0.4
17 Jul  7 21:40 /usr/src/garnome-0.12.2/kde/qt-copy/work/qt-copy-3.0.4/lib/libqt-mt.so.3 -> libqt-mt.so.3.0.4
17 Jul  7 21:40 /usr/src/garnome-0.12.2/kde/qt-copy/work/qt-copy-3.0.4/lib/libqt-mt.so.3.0 -> libqt-mt.so.3.0.4
7317992 Jul  7 21:40 /usr/src/garnome-0.12.2/kde/qt-copy/work/qt-copy-3.0.4/lib/libqt-mt.so.3.0.4
[root@coyote root]#

And I just rm'd the usual suspects in the mosfet-liquid src dir, reset QTDIR to the Aug 8th versions
and reran ./configure, getting this:
checking for Qt... configure: error: Qt (>= Qt 3.0.2) (library qt-mt) not found. Please check your installation!
For more details about this problem, look at the end of config.log.
Make sure that you have compiled Qt with thread support!

Now, from config.log, line 9454:

configure:9454: checking for Qt
configure: 9516: /usr/lib/qt-3.0.4//include/qstyle.h
configure: 9516: /usr/lib/qt-3.0.4//qstyle.h
configure: 9516: /usr/lib/qt3/include/qstyle.h
configure: 9516: /usr/lib/qt3/qstyle.h
configure: 9516: /usr/lib/qt/include/qstyle.h
configure: 9516: /usr/lib/qt/qstyle.h
configure: 9516: /usr/local/qt/include/qstyle.h
taking that
tried NO
configure:9621: rm -rf SunWS_cache; g++ -o conftest -O2 -fno-exceptions -fno-check-new -I/usr/local/qt/include -I.  -DQT_THREAD_SUPPORT
  -D_REENTRANT  -L/usr/lib/qt-3.0.4//lib -L/usr/X11R6/lib   conftest.cc  -lqt-mt -lpng -lz -lm -ljpeg -ldl  -lXext -lX11 -lSM -lICE  -l
resolv -lpthread 1>&5
In file included from /usr/local/qt/include/qmime.h:43,
                 from /usr/local/qt/include/qevent.h:45,
                 from /usr/local/qt/include/qobject.h:45,
                 from /usr/local/qt/include/qwidget.h:43,
                 from /usr/local/qt/include/qdesktopwidget.h:42,
                 from /usr/local/qt/include/qapplication.h:42,
                 from conftest.cc:3:
/usr/local/qt/include/qmap.h:49:20: iterator: No such file or directory

This report goes on for another 1000 or more lines
each one naming a different include.

It appears the real problem might be the includes, as in a
qt2 or older (1.45) version lives at /usr/local/qt/include

But, I just mv'd that /usr/local/qt dir to qt-orig, and made a link from qt to
/usr/lib/qt-3.0.4 and it fails for not finding anything qt related then.

Then i did a locate on 4/include/q and linked /usr/local/qt to that.
That was /usr/src/garnome-0.12.2/kde/qt-copy/work/qt-copy-3.0.4
apparently the only place valid includes lives for qt-3.0.4!  In 
other words, it fsking worked!  ./configure actually ran.

Now I'm seeing if it will make.

Nope, half a kajillion undefined references at collect2 time.
But I didn't set $QTDIR to that .
Didn't help...

I'm going out for a haircut and a monitor for my old vintage coco3.
Maybe someplace in all this blather, is a clue, he said pleadingly.
-- 
Cheers John, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.13% setiathome rank, not too shabby for a WV hillbilly
