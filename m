Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbTJNU7U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 16:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262554AbTJNU7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 16:59:20 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:24227 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262544AbTJNU7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 16:59:03 -0400
Message-ID: <3F8C639F.9000406@opensound.com>
Date: Tue, 14 Oct 2003 13:59:11 -0700
From: 4Front Technologies <dev@opensound.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Martin Josefsson <gandalf@wlug.westbo.se>, linux-kernel@vger.kernel.org
Subject: Re: mouse driver bug in 2.6.0-test7?
References: <3F8C3A99.6020106@opensound.com> <1066159113.12171.4.camel@tux.rsn.bth.se> <20031014193847.GA9112@ucw.cz> <3F8C56B3.1080504@opensound.com> <20031014201354.GA10458@ucw.cz>
In-Reply-To: <20031014201354.GA10458@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Tue, Oct 14, 2003 at 01:04:03PM -0700, 4Front Technologies wrote:
> 
> 
>>>Patch considered. I'll up the samplerate default to 80, but not more,
>>>since samplerates above that cause trouble for a lot of people (keyboard
>>>doesn't work when you're moving the mouse).
>>>
>>>The "set lower rate in case ..." part of the patch doesn't make sense.
>>>If the user gives a too low (less than 10) samples per second, then the
>>>original code will try to set 0, which is stupid, but harmless. The
>>>added code will try to access beyond the bounds of the rates[] array.
>>
>>
>>Hi Martin/Vojtech,
>>
>>Martin, many thanks for your fix - it works perfectly now.
>>
>>Oddly enough the sample rate of 200 seems to have fixed the problem.
>>Vojetech,  Martin's fixes are fully functional.
> 
> 
> Not completely. One reason wht the sample rate of 200 probably fixed the
> problem is that you have very high acceleration settings in X.
> 
> Since with report rate 200 you get a medium speed movement as
> 
> +1 +1 +1 +1 +1 +1 +1 +1 +1
> 
> events, and with report rate 60 you get
> 
>        +3      +3       +3
> 
> and the X mouse acceleration code is stupid enough to judge the mouse
> speed from the event VALUE only, it thinks the mouse is moving much
> faster in the second case.
> 
> You need to up the acceleration threshold (or disable acceleration
> completely).
> 
> This also means that with report rate of 200, mouse acceleration is more
> or less disabled, since you get +1's only even at quite high speeds of
> mouse movement.
> 


Vojtec/Martin

You're right, the original problem still remains. The tracking is still
2x compared to Linux 2.4.

Here's how I did the measurement.
Get a foot-scale and start xev. Ajust xev so that the coordiates of the
window are 0,y (y is y-axis - don't care) in the X root window (my res is 1024x768).

Now align the mouse so that it shows 0,0 on the top left corner in the xev window
and move the mouse exactly one 1 inch and you'll see that under Linux 2.6.0-test7
the x axis position is at something like 325. However repeating the same test under
Linux 2.4.22 puts the mouse at x axis position 170 (gives me a accelearation factor
of about 2x).

This is a horribly crude test but it explains my problem that the mouse driver isn't
tracking correctly.


Hope this helps figuring out the problem.


best regards

Dev Mazumdar
---------------------------------------------------------------------
4Front Technologies
4035 Lafayette Place, Unit F, Culver City, CA 90232, USA
Tel: 310 202 8530   Fax: 310 202 0496   URL: http://www.opensound.com
---------------------------------------------------------------------

