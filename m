Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266465AbRGFMEl>; Fri, 6 Jul 2001 08:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266457AbRGFMEb>; Fri, 6 Jul 2001 08:04:31 -0400
Received: from akk4.akk.uni-karlsruhe.de ([129.13.131.4]:48132 "EHLO
	rzstud1.karlsruhe.org") by vger.kernel.org with ESMTP
	id <S266467AbRGFME1>; Fri, 6 Jul 2001 08:04:27 -0400
Date: Fri, 6 Jul 2001 14:04:26 +0200
From: Sven Paulus <sven@karlsruhe.org>
To: linux-kernel@vger.kernel.org
Subject: sudden timewarps when using gettimeofday()
Message-ID: <20010706140425.A14103@karlsruhe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm experiencing a strange problem on a Pentium III 600 MHz machine
running Linux 2.4.1: When doing a gettimeofday() close to a full
second, the time warps ~71 minutes into the future, only to come back
immediatly after this. Attached below is the output of a little program which
dumps the gettimeofday() result and sleeps for 25msec, I've marked the wrong
values.

This also happens with newer Linux kernels (but arch/i386/kernel/time.c
hasn't changed since 2.4.1, so this isn't a surprise). The whole thing
started quite suddenly - is this a software problem or broken hardware?

The kernel is compiled for the "Pentium-Pro/Celeron/Pentium-II" processor
family, so do_fast_gettimeoffset() is used. The difference between the
right and the wrong value is ~4294.757218 seconds - this seems to be close 
to 2^32/1e6 seconds.

In do_gettimeofday() there is a loop 
           while (usec >= 1000000) {
              usec -= 1000000;
              sec++;
           }
so if usec was set to -1 (or something like this) by accident, this might 
lead to a time offset. But I could not find any way how this could happen.

Btw. time() always gives the right time values. I've straced programs using
gettimeofday(), this shows the same behaviour, so it's not a libc issue.

So I'm really confused what is happening here - any hints?  Thanks! :-)

Sven

[...]
994418931.354487
994418931.392061
994418931.432122
994418931.471829
994418931.512524
994418931.551827
994418931.592122
994418931.631827
994418931.672123
994418931.711827
994418931.751958
994418931.792044
994418931.831909
994418931.871829
994418931.911908
994418931.952040
994423226.959258 <
994418932.032125
994418932.071906
994418932.111826
994418932.152125
994418932.193377
994418932.232119
994418932.271833
994418932.312119
994418932.351826
994418932.392123
994418932.431826
994418932.471906
994418932.513939
994418932.551906
994418932.591827
994418932.631905
994418932.672042
994418932.711905
994418932.752091
994418932.792123
994418932.832121
994418932.872119
994418932.912057
994418932.952126
994423227.960700 <
994418933.032059
994418933.072206
994418933.112058
994418933.152094
994418933.193635
994418933.232091
994418933.272062
994418933.312108
994418933.351830
994418933.392057
994418933.432058
994418933.472097
994418933.512569
994418933.551874
994418933.592043
994418933.632090
994418933.672044
994418933.711826
994418933.752283
994418933.791877
994418933.912322
994418933.942042
994423228.949440 <
994418934.022378
994418934.062058
994418934.103191
994418934.143251
994418934.183183
994418934.222059
994418934.263312
994418934.302116
994418934.343721
994418934.382123
994418934.423183
994418934.462057
994418934.503462
994418934.542368
994418934.583226
994418934.621919
994418934.663145
994418934.701836
994418934.743143
994418934.782162
994418934.823169
994418934.861827
994418934.902871
994418934.941827
994423229.952566 <
994418935.022056
994418935.061881
994418935.102040
994418935.142063
[...]
