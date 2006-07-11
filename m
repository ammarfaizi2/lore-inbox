Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWGKWcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWGKWcm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWGKWcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:32:42 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:17142 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP id S932220AbWGKWcl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:32:41 -0400
Message-ID: <44B426CB.4010405@pg.gda.pl>
Date: Wed, 12 Jul 2006 00:31:39 +0200
From: =?ISO-8859-2?Q?Adam_Tla=B3ka?= <atlka@pg.gda.pl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; pl-PL; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Valdis.Kletnieks@vt.edu, alsa-devel@alsa-project.org,
       linux-kernel@vger.kernel.org, perex@suse.cz, alan@lxorguk.ukuu.org.uk
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round (v2)
References: <20060707231716.GE26941@stusta.de>	 <p737j2potzr.fsf@verdi.suse.de> <1152458300.28129.45.camel@mindpipe>	 <20060710132810.551a4a8d.atlka@pg.gda.pl>	 <1152571717.19047.36.camel@mindpipe> <44B2E4FF.9000502@pg.gda.pl>	 <200607110209.k6B29psN007504@turing-police.cc.vt.edu>	 <20060711081528.4d3ab197.atlka@pg.gda.pl>	 <200607111430.k6BEUUus006736@turing-police.cc.vt.edu> <1152637064.21909.61.camel@mindpipe>
In-Reply-To: <1152637064.21909.61.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Lee Revell napisa³:
> On Tue, 2006-07-11 at 10:30 -0400, Valdis.Kletnieks@vt.edu wrote:
>> On Tue, 11 Jul 2006 08:15:28 +0200, Adam =?ISO-8859-2?B?VGxhs2th?= said:
>>> Sorry to say but it is just not that way. Window manager is for managing windows
>>> and it shouldn't depend on any audio system. It should use an external app using exec call
>>> to play sounds (aplay, sox, wavplay etc.) configured by some config option.
>> So what you're saying is that something like 'esd' *is* needed.  (It's
>> certainly silly to keep doing fork/exec for every little sound sample when
>> you can just leave the app running and hand it requests...)
> 
> That approach also won't be reliable as it ignores the realtime
> constraint that is inherent in audio playback.  It will probably work on
> a fast/lightly loaded machine but will glitch out under load.

Yes, that is true. It was just simple example how you can get simple 
sound effects without many lines of code. In case of heavy load or too 
many events in short period of time this method is not working correctly 
but this is not the main functionality of a window manager program.
Anyway you can aggregate events if there are too many of them and play 
only one sound or not play anything at all. For this kind of program
it is quite acceptable and not breaks main functionality.

> It's how GDM plays startup/shutdown sounds and it sucks - on shutdown
> the sound is choppy.  You either need a dedicated daemon running
> SCHED_FIFO or an RT thread for reliable audio playback.

True - and that makes things more complicated. I don't know if it is 
worth it just for bells and whistles. In other cases you do need to 
program more sophisticated sound support and RT thread probably will be 
your solution. Or some kind of sound server which holds your sound 
samples so you can fire them at the proper time.
ALSA lib is a low level library. Sometimes we need more abstract 
functions like load(s, "sound.wav) and then play(s) without bothering 
about all these parameters settings. So maybe OpenAL is a some kind of a 
solution but I don't know its current status.

Regards
-- 
Adam Tla³ka       mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
Computer Center,  Gdañsk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl
