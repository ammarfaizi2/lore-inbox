Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289928AbSAKMNO>; Fri, 11 Jan 2002 07:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289926AbSAKMNA>; Fri, 11 Jan 2002 07:13:00 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:44809 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S289923AbSAKMMz> convert rfc822-to-8bit; Fri, 11 Jan 2002 07:12:55 -0500
X-Envelope-From: martin.macok@underground.cz
Date: Fri, 11 Jan 2002 13:12:52 +0100
From: =?iso-8859-2?Q?Martin_Ma=E8ok?= <martin.macok@underground.cz>
To: linux-kernel@vger.kernel.org
Subject: low latency versus sched O(1)
Message-ID: <20020111131252.A1366@sarah.kolej.mff.cuni.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5.1i
X-Echelon: GRU NSA GCHQ CIA Pentagon nuclear conspiration war teror anthrax
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tested Andrew Morton's low latency patch versus Ingo's sched
O(1) patch a bit:

"O1" is 2.4.18-pre2 + sched-O1-2.4.17-G1

"LL" is 2.4.18-pre3 + 2.4.17-low-latency + riel's 2.4.3ac4-largenice

(Red Hat 7.2 Linux, UP Athlon CPU 850MHz)

Comparison:

Tuxracer:
 - reports same framerate on both when no other load is on the
   machine and the game is smooth in both cases.

Tuxracer + kernel compilation (both nice 0):
 LL: the game skips a lot, ugly :(
 O1: the game skips much less than LL, playable

Tuxracer + kernel compilation with nice +19:
 LL: no skipping, almost same as without kernel compilation
 O1: skips a little less then with kernel compilation (nice 0)
     but skips much more than LL in this case.

Xmms/Jess visual plugin:
 - same framerate when no load
 (LL: maybe a little bit larger (+10%) framerate than O1)

Xmms/Jess + kernel compilation:
 LL: almost doesn't work, very bad :(
 O1: lower framerate (1/3), skips a little, but works

Xmms/Jess + kernel (nice +19):
 LL: almost exactly same as LL without kernel compilation!
 O1: framerate somewhere between.. skips ocassionaly

Conclusion:
This is not a real test nor real benchmark, only a little stupid luser
test, but it can show that LL is much better in interactivity and
smoothness but you HAVE to setup priorities (nice levels) of tasks by
hand (explicitely). When you don't setup priorities explicitely than
sched O1 makes the job for you but don't achieve same
interactivity/smoothness performance as LL.

So I suggest a combination of some conservative LL + O(1) scheduler
will make linux desktop kicking ass! :)

-- 
         Martin Maèok                 http://underground.cz/
   martin.macok@underground.cz        http://Xtrmntr.org/ORBman/
