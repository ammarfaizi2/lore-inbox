Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265973AbRF3NdI>; Sat, 30 Jun 2001 09:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265954AbRF3Nc7>; Sat, 30 Jun 2001 09:32:59 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:16009 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265915AbRF3Ncq>; Sat, 30 Jun 2001 09:32:46 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 30 Jun 2001 06:32:36 -0700
Message-Id: <200106301332.GAA14600@adam.yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 	Argh!  I just accidentally sent and older version of my
>> patch.  Here is the current version.  Sorry about that.

>This just breaks stuff

>> +for var in $(cat arch/*/config.in |
>> +	     egrep -w -v '^[ 	]*int' |
>> +             tr '   $"' '\n\n\n' |
>> +	     egrep '^CONFIG_[A-Z0-9_]*$' |
>> +	     sort -u) ; do
>> +	define_bool "$var" "n"
>> +done
>> +set -f
>>  

>You've changed the entire semantics of dep_tristate by doing this

	Please provide a real example.

	As far as I can tell, the only change would be to make
dep_tristate behave the way it was expected to, as in
drives/sound/Config.in:

      dep_tristate '    Netwinder WaveArtist' CONFIG_SOUND_WAVEARTIST $CONFIG_SOUND_OSS $CONFIG_ARCH_NETWINDER

	The current, unintended, behavior is to allow this module to be
built all all non-ARM architectures (and probably bomb out), as well
as the intended architecture of ARM-Netwinder, and not any other ARM
platforms.  The intended behavior, and the one that you would get with
either my change or Keith's is to only allow this module to be built
for ARM-Netwinder.


Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
