Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135549AbRDXRb2>; Tue, 24 Apr 2001 13:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135576AbRDXRbI>; Tue, 24 Apr 2001 13:31:08 -0400
Received: from sirius-giga.rz.uni-ulm.de ([134.60.246.36]:11721 "EHLO
	mail.rz.uni-ulm.de") by vger.kernel.org with ESMTP
	id <S135549AbRDXRaz> convert rfc822-to-8bit; Tue, 24 Apr 2001 13:30:55 -0400
Date: Tue, 24 Apr 2001 19:30:40 +0200 (MEST)
From: Markus Schaber <markus.schaber@student.uni-ulm.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: CaT <cat@zip.com.au>, Alexander Viro <viro@math.psu.edu>,
        "Mohammad A. Haque" <mhaque@haque.net>,
        <ttel5535@artax.karlin.mff.cuni.cz>,
        "Mike A. Harris" <mharris@opensourceadvocate.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
In-Reply-To: <E14s57p-0002LM-00@the-village.bc.nu>
Message-ID: <Pine.SOL.4.33.0104241916420.8272-100000@lyra.rz.uni-ulm.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 24 Apr 2001, Alan Cox wrote:

> > Now, in order for step 4 to be done safely, procmail should be running
> > as the user it's meant to deliver the mail for. for this to happen
> > sendmail needs to start it as that user in step 3 and to do that it
> > needs extra privs, above and beyond that of a normal user.
>
> 	email -> sendmail
> 	sendmail 'its local' -> spool
>
> user:
> 	get_mail | procmail
> 	mutt
>
> The mail server doesnt need to run procmail. If you wanted to run mail batches
> through on a regular basis you can use cron for it, or leave a daemon running

Oh, well, cron is just another suid program.

This example would just be the ideal scenario for posix- or novell-style
ACLs in the filesystem.

You run the MDA/MTA under some mailerdaemon uid. And then a user can
explicitly give this daemon read access to .procmail etc. You can also
give the MTA (and nobody else) write access to /var/spool/mail. The MDA
then gives the specifical user full access to the spoolfile when creating
it, or adding mail to it. And the user can fetch his mail and truncate or
delete the file just as he and his software is used to.

There are much more things with ACLs, especially in workgroup environments
(That's why I loved the old Novel server in our university), but they
never got into the kernel.  And as far as I (as a non-hacker) understand,
the fields reserved for this feature were dropped for the large file
support, so we may never see ACLs.

Gruß,
Markus
-- 
| Gluecklich ist, wer vergisst, was nicht aus ihm geworden ist.
+---------------------------------------.     ,---------------->
http://www.uni-ulm.de/~s_mschab/         \   /
mailto:markus.schaber@student.uni-ulm.de  \_/


