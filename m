Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSETFJs>; Mon, 20 May 2002 01:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315780AbSETFJr>; Mon, 20 May 2002 01:09:47 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:50955 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S315779AbSETFJq>;
	Mon, 20 May 2002 01:09:46 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200205200509.g4K59a9494917@saturn.cs.uml.edu>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
To: mfedyk@matchmail.com (Mike Fedyk)
Date: Mon, 20 May 2002 01:09:36 -0400 (EDT)
Cc: Wayne.Brown@altec.com, linux-kernel@vger.kernel.org,
        kaos@ocs.com.au (Keith Owens)
In-Reply-To: <20020520043101.GA502@matchmail.com> from "Mike Fedyk" at May 19, 2002 09:31:01 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk writes:
> On Sat, May 18, 2002 at 12:32:25PM -0500, Wayne.Brown@altec.com wrote:

>> I never expected everyone to abandon their own needs to satisfy mine.
>> It would be nice if they tried to accomodate my needs while satisfying
>> their own, but I didn't expect that either.  
>
> IIRC, Kbuild-2.5 already silently accepts all of the old kbuild-2.4
> commands without problems.
>
> As long as you end up running "make install" the rest of the old commands
> will be ignored.  You can go on with all of the old commands, if you want
> without any trouble.

Well, not everybody trusts "make install" to do something useful.
I'd do something like this:

make clean
bzip2 -dc ../foo.bz2 | patch -E -s -p1
make menuconfig
time script build-log
make vmlinux && make modules && make modules_install && exit
cp vmlinux /boot/vmlinux-2.5.16
cp System.map /boot/System.map-2.5.16
cp .config /boot/config-2.5.16
sync
su -
joe /etc/yaboot.conf
sync
exit
