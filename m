Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318018AbSGWKR6>; Tue, 23 Jul 2002 06:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318021AbSGWKR6>; Tue, 23 Jul 2002 06:17:58 -0400
Received: from fw.2d3d.co.za ([66.8.28.230]:62869 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S318018AbSGWKRz>;
	Tue, 23 Jul 2002 06:17:55 -0400
Date: Tue, 23 Jul 2002 12:22:44 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Cc: Allen Van Der Ross <allen@ct.spi.co.za>
Subject: Fwd: [allen@ct.spi.co.za: Re: [CLUG-tech] statfs()  vs. df]
Message-ID: <20020723122244.A3839@crystal.2d3d.co.za>
Mail-Followup-To: Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Allen Van Der Ross <allen@ct.spi.co.za>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.17-pre4 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 12:15pm  up 34 days, 20:55, 11 users,  load average: 0.06, 0.11, 0.06
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wxDdMuZNg1r63Hyj
Content-Type: multipart/mixed; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Can anyone explain this? He's got 2.4.2 with libc6 2.2.x. df -k returns the
correct results for his partition. Both statfs() and statvfs() returns bogus
values. From his last email it looks like it's actually returning stats for
/dev/hda8 instead of /dev/hda9.

Is this a (known) bug?

Here is the source for the program mentioned in the email:

------------< snip <------< snip <------< snip <------------
root@crystal:~# cat /tmp/t.c

#include <stdio.h>
#include <sys/vfs.h>
#include <sys/statvfs.h>

static const char part[] =3D "/dev/hda9";

int main ()
{
        struct statfs stat;
        struct statvfs vfs;

        if (statfs (part,&stat) < 0) {
                perror ("statfs");
                return(1);
        }
        printf("f_blocks: %ld, f_bsize: %d\n",stat.f_blocks,stat.f_bsize);

        if (statvfs (part,&vfs) < 0) {
                perror ("statvfs");
                return(1);
        }
        printf("f_bsize: %lu, f_blocks: %lu\n",vfs.f_bsize,vfs.f_blocks);

        return(0);
}

------------< snip <------< snip <------< snip <------------

--=20

Regards
 Abraham

Avoid Quiet and Placid persons unless you are in Need of Sleep.
		-- National Lampoon, "Deteriorata"

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--4SFOXa2GPu3tIq4H
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <clug-tech-admin@clug.org.za>
Delivered-To: abz@crystal.local.2d3d.co.za
Received: (qmail 3821 invoked by alias); 23 Jul 2002 10:15:28 -0000
Delivered-To: abraham@crystal.local.2d3d.co.za
Received: (qmail 3818 invoked from network); 23 Jul 2002 10:15:28 -0000
Received: from trinity.local.2d3d.co.za (HELO mail.2d3d.co.za) (192.168.200.1)
  by crystal.local.2d3d.co.za with SMTP; 23 Jul 2002 10:15:28 -0000
Received: (qmail 28302 invoked by uid 1001); 23 Jul 2002 10:13:35 -0000
Delivered-To: abraham@2d3d.co.za
Received: (qmail 28299 invoked from network); 23 Jul 2002 10:13:33 -0000
Received: from dreamcoat.che.uct.ac.za (137.158.228.85)
  by mail.2d3d.co.za with SMTP; 23 Jul 2002 10:13:33 -0000
Received: from localhost (dreamcoat.che.uct.ac.za) [127.0.0.1] (list)
	by dreamcoat.che.uct.ac.za with esmtp (Exim 2.11 #1 (Debian/Virtual-hack-#04))
	id 17WwYS-0006p0-00; Tue, 23 Jul 2002 12:06:08 +0200
Received: from rapier.b-i.co.za [66.8.25.34] 
	by dreamcoat.che.uct.ac.za with smtp (Exim 2.11 #1 (Debian/Virtual-hack-#04))
	id 17WwYC-0006oj-00; Tue, 23 Jul 2002 12:05:52 +0200
Received: (qmail 24497 invoked from network); 23 Jul 2002 10:05:49 -0000
Received: from unknown (HELO condor) (10.10.33.30)
  by 0 with SMTP; 23 Jul 2002 10:05:49 -0000
Message-ID: <01bb01c2322f$c1591e10$1e210a0a@spi.co.za>
From: "Allen Van Der Ross" <allen@ct.spi.co.za>
To: <clug-tech@clug.org.za>
References: <010701c23190$d8b69050$1e210a0a@spi.co.za> <20020723095452.C1055@crystal.2d3d.co.za> <018b01c23226$3dd265a0$1e210a0a@spi.co.za> <20020723113918.B2674@crystal.2d3d.co.za>
Subject: Re: [CLUG-tech] statfs()  vs. df
Organization: SPI
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: clug-tech-admin@clug.org.za
Errors-To: clug-tech-admin@clug.org.za
X-BeenThere: clug-tech@clug.org.za
X-Mailman-Version: 2.0.8
Precedence: bulk
Reply-To: clug-tech@clug.org.za
X-Reply-To: "Allen Van Der Ross" <allen@ct.spi.co.za>
List-Help: <mailto:clug-tech-request@clug.org.za?subject=help>
List-Post: <mailto:clug-tech@clug.org.za>
List-Subscribe: <http://www2.clug.org.za/mailman/listinfo/clug-tech>,
	<mailto:clug-tech-request@clug.org.za?subject=subscribe>
List-Id: Technical Questions and Answers <clug-tech.clug.org.za>
List-Unsubscribe: <http://www2.clug.org.za/mailman/listinfo/clug-tech>,
	<mailto:clug-tech-request@clug.org.za?subject=unsubscribe>
List-Archive: <http://www2.clug.org.za/mailman/private/clug-tech/>
Date: Tue, 23 Jul 2002 12:00:16 +0200

> allen@eagle:~$ uname -a
> Linux eagle.spi.co.za 2.4.2-2 #1 Sun Apr 8 20:41:30 EDT 2001 i686 unknown

I just had a look at the source for the df from fileutils 4.0.37 and it can
get the filesystem stats in a number of ways

1. statfs()
2. reading a filsys structure directly from the superblock of the
filesystem.
3. statvfs()

I've modified my test program to display both. See if you get different
output. Also try compiling the program with -D_LARGEFILE64_SOURCE and see if
that makes a difference (shouldn't since your partition is quite small).

<
< I have also played with options 1 and 3, using statfs() and statvfs()
which
< both display the same information.
< Compiling t.c with -D_LARGEFILE64_SOURCE doesn't make a differance
< as you thought. I was hoping not to get involved with option 2 for now,
< since time does not permit and I'm on the verge of execing("df -k").

(Which reminds me. How big is your partition really? I take it df gave the
correct output which makes it a 2.8G partition?)

< Yep, its quite small. I have to re-install this machine this weekend and
that's
< one of the things I need to fix. :)

Also, what filesystem do you have on there?

< ext2fs is all I use on this machine.

If this is the same I give up. In that case I suggest you grab a copy of the
latest fileutils, compile it with debugging and run df through the debugger.
(break on get_fs_usage and step through the function to see what method it
uses on your system).

< yes it is the same. I will check out fileutils.
< yet I saw something very interesting...hmmm....
< don't understand it, but all the programs (we) wrote
< did return valid values, but for / (root) partition, which
< is on /dev/hda8 (even tho I explicitly tested with /dev/hda9)
< see this:

gcc t.c  (your latest t.c)
allen@eagle:~$ ./a.out
f_blocks: 350021, f_bsize: 1024
f_bsize: 1024, f_blocks: 350021

allen@eagle:~$ ./fs /dev/hda
/dev/hda:       total blocks 350021     free blocks 217464

allen@eagle:~$ ./fs /dev/hda9
/dev/hda9:      total blocks 350021     free blocks 217458

allen@eagle:~$ df -k
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda8               350021    132578    199372  40% /
/dev/hda9              3028080   2575624    298636  90% /usr
...

What can you make of it?

-Allen


-- 
Clug-tech mailing list
Clug-tech@clug.org.za
To (un)subscribe:
http://www2.clug.org.za/mailman/listinfo/clug-tech

--4SFOXa2GPu3tIq4H--

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9PS50zNXhP0RCUqMRAmtVAJ4iW87AkjRcRL9MxDWtB84CWsRlGACfXCcN
+sy6whvM6Wxc4h8J6JgC7A4=
=dFMp
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
