Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281990AbRKZSFv>; Mon, 26 Nov 2001 13:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281987AbRKZSFo>; Mon, 26 Nov 2001 13:05:44 -0500
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:33031 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S281961AbRKZSFb> convert rfc822-to-8bit; Mon, 26 Nov 2001 13:05:31 -0500
From: Steve Brueggeman <xioborg@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Date: Mon, 26 Nov 2001 12:05:43 -0600
Message-ID: <0f050uosh4lak5fl1r07bs3t1ecdonc4c0@4ax.com>
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de> <20011124103642.A32278@vega.ipal.net> <20011124184119.C12133@emma1.emma.line.org> <tgy9kwf02c.fsf@mercury.rus.uni-stuttgart.de> <4.3.2.7.2.20011124150445.00bd4240@10.1.1.42> <3C002D41.9030708@zytor.com>
In-Reply-To: <3C002D41.9030708@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Nov 2001 15:29:05 -0800, you wrote:

>Stephen Satchell wrote:
>
>> 
>> It is the responsibility of the power monitor to detect a power-fail 
>> event and tell the drive(s) that a power-fail event is occurring.  If 
>> power goes out of specification before the drive completes a commanded 
>> write, what do you expect the poor drive to do?  ANY glitch in the write 
>> current will corrupt the current block no matter what -- the final CRC 
>> isn't recorded.  Most drives do have a panic-stop mode when they detect 
>> voltage going out of range so as to minimize the damage caused by an 
>> out-of-specification power-down event, and more importantly use the 
>> energy in the spinning platter to get the heads moved to a safe place 
>> before the drive completely spins down.  The panic-stop mode is EXACTLY 
>> like a Linux OOPS -- it's a catastrophic event that SHOULD NOT OCCUR.
>> 
>
Correct, sort-of.  The storage is not allowed to corrupt any data that
is unrelated to the currently active operation, (ie adjacent tracks or
sectors).  Of course write-caching is asking for trouble.
>
>There is no "power monitor" in a PC system (at least not that is visible 
>to the drive) -- if the drive needs it, it has to provide it itself.
>
>It's definitely the responsibility of the drive to recover gracefully 
>from such an event, which means that it writes anything that it has 
>committed to the host to write; 
Correct.  If a write gets interrupted in the middle of it's operation,
it has not yet returned any completion status, (unless you've enabled
write-caching, in which case, you're already asking for trouble)  A
subsequent read of this half-written sector can return uncorrectable
status though, which would be unfortunate if this sector was your
allocation table, and the write was a read-modify-write.

>anything it hasn't gotten committed to 
>write (but has received) can be written or not written, but must not 
>cause a failure of the drive.
Reading a sector that was a partial-write because of a power-loss, and
returning UNCORRECTABLE status, is not a failure of the drive.

>
>A drive is a PERSISTENT storage device, and as such has responsibilities 
>the other devices don't.
>
>Anything else is brainless rationalization.
>
>	-hpa


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

