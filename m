Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278351AbRJZLGe>; Fri, 26 Oct 2001 07:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278374AbRJZLGY>; Fri, 26 Oct 2001 07:06:24 -0400
Received: from axiom.anu.edu.au ([150.203.127.200]:30991 "EHLO
	axiom.anu.edu.au") by vger.kernel.org with ESMTP id <S278351AbRJZLGK>;
	Fri, 26 Oct 2001 07:06:10 -0400
Message-ID: <3BD943C0.8E7DB728@axiom.anu.edu.au>
Date: Fri, 26 Oct 2001 21:06:40 +1000
From: Gunnar Raetsch <raetsch@axiom.anu.edu.au>
Reply-To: Gunnar.Raetsch@anu.edu.au
Organization: ANU
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: reiserfs-list@namesys.com, nfs@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: hardlinks - knfsd - reiserfs bug
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've got problems with hard links when using the kernel-nfsd and
reiserfs. The nfs server gives e.g. the following error messages

Oct 25 08:59:09 hebb kernel: nfsd Security: sbin/init bad export.
Oct 25 08:59:10 hebb kernel: nfsd Security: bin/bash bad export.

and the client is not able to read the file. 

This only happens, if the exported files on the server are hard linked
with other files -- so I reckon it has something to do with the hard
links (other potentially interesting details attached below: raid, lvm
..)  
Furthermore, I did the same on another system using ext2-fs and 
it worked perfectly (but without raid&lvm).

So, it might be the combination of hard links & knfsd & reiserfs, which
has a bug somewhere. 

Do you know what to do??
Any help is appreciated!

Gunnar

PS: please CC me your answer.

Details: 

I'm running an single CPU (Athlon) server with six disks -- five of
them in a software raid (level 5). On top of the raid runs LVM to
split-up the big partitions (30+30+250Gb). On each of the partitions
is reiserfs 3.6.25 file system (converted from 3.5.x).  The server
runs a 2.4.10 kernel (originally a 2.4.5 kernel + reiserfs-quota-knfsd
patches; then patched up to 2.4.10).

The nfs-client runs the same kernel (with nfsroot option switched
on). The Root-fs of the client is on the server (on a
raid/lvm/reiserfs partition). When booting the client, if the server
uses hard links of the exported files, it does not find e.g. sbin/init
and booting the client fails. If there are no hard links everything
works.

I also tried the new 2.4.13 kernel (the original and also the 2.4.10
from before + three patches) on client and server. It worked a little 
bit better: now the client comes up, but very soon I get the same 
error messages for other essential files (ie. its not usable).

The directory structure of the server:

I have e.g. these directories (one for each client gauss, laplace,
poisson)

$$/gauss/
$$/laplace/
$$/poisson/

in each of them is a copy of a linux system (SuSE 7.1, without /usr
and /opt -- they are exported separately). The server exports
(ro,no_root_squash) each directory above to the particular client
only.

To save disk space I'd like to hard link the files in these
directories to each other. I created a new directory $$/generic,
copied the files to be hard linked and created hard-links from the
files in all other directories to the generic directory. After this
operation the clients do not boot anymore.


$$=/export/clients/7.1/


-- 
Gunnar R"atsch                     http://mlg.anu.edu.au/~raetsch 
Australian National University   mailto:Gunnar.Raetsch@anu.edu.au
