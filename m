Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130622AbRBEQPd>; Mon, 5 Feb 2001 11:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130775AbRBEQPX>; Mon, 5 Feb 2001 11:15:23 -0500
Received: from ip165-228.fli-ykh.psinet.ne.jp ([210.129.165.228]:8644 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S130622AbRBEQPP>;
	Mon, 5 Feb 2001 11:15:15 -0500
Message-ID: <3A7ED185.B9AEB000@yk.rim.or.jp>
Date: Tue, 06 Feb 2001 01:15:01 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: Re: /usr/src/linux/scripts/ver_linux prints out incorrect info when "ls" 
 is aliased.
In-Reply-To: <3A7D7210.EA87572A@yk.rim.or.jp> <20010205073929.A32155@cadcamlab.org>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:

> [Ishikawa]
> > I just noticed that running
> >
> >         .   /usr/src/linux/script/ver_linux
> >
> > prints out strange libc version
> [...]
> > I found that if the command "ls" is aliased to "ls -aF"
>
> So ... don't use '.' to execute scripts.  If there is some
> documentation somewhere that told you to do this, please notify the
> author that it is wrong.
>
>   sh scripts/ver_linux
>

This is a good observation.

I have no idea why I invoked ver_linux using "." : I must have
seen it somewhere and just followed it somehow.

Hard to tell where I have seen. I must have seen it in the last few
days.

Here is one URL where "." is used, but this was not where I saw the
usage.

http://oss.sgi.com/projects/devfs/mail/devfs/msg00261.html

I have found the same problem cropped up in the kernel mailing list
before.

    http://uwsg.iu.edu/hypermail/linux/kernel/0003.1/0898.html

The above thread showed that non-other than Alan Cox also chimed in the
thread.

So there must have been a reason to let people try "." for
invoking /usr/src/linux/scripts/ver_linux.

One theory might be that, as a root, people may run
    # ./ver_linux   (under scripts directory).

And then, when they try to show what they did, they may
create a report showing the FULL path name of the scripts so that
there is no mistaking ver_scripts for something else.
And in doing so, somebody might have forgotten to remove the
leading "."
    #./usr/src/linux/scripts/ver_linux
Somebody eles looked at the above and "figured" that the
leading "./" is a typo and thus corrects it to ". /"
and now we have
   #. /usr/src/linux/scripts/ver_linux

Anyway, I have found another  libc version output
in somebody's post. The poster must have similar problem as I did.
(See at the end for ver_linux output result. )
http://www.uwsg.indiana.edu/hypermail/linux/kernel/9906.3/0990.html

So in any case, I think protecting the
ver_linux from strange interaction of various
shell features might be a good idea after all.

(I was not convinced why "sh /usr/src/linux/scripts/ver_linux" works
since /bin/sh is a symlink to bash in my setup and it seems that
my ./bashrc includes the ls alias. But when I tried it, it works. )


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
