Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313159AbSC1OBF>; Thu, 28 Mar 2002 09:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313160AbSC1OA5>; Thu, 28 Mar 2002 09:00:57 -0500
Received: from pc132.utati.net ([216.143.22.132]:32401 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S313159AbSC1OAr>; Thu, 28 Mar 2002 09:00:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Sean Neakums <sneakums@zork.net>, linux-kernel@vger.kernel.org
Subject: Re: ssh won't work from initial ram disk in 2.4.18
Date: Thu, 28 Mar 2002 09:00:50 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020328124257.99FD54FF@merlin.webofficenow.com> <6uadssbzh4.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020328141543.AD0274FF@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 March 2002 08:20 am, Sean Neakums wrote:
> commence  Rob Landley quotation:
> > If this is an ssh problem I'll be happy to go bug those guys, but
> > why would it be different from initrd than from an actual mounted
> > partition?  (Permissions are the same, I checked.)
>
> Have you tried running ssh with the -v switch?  That will dump a bunch
> of debug info that's often very helpful with investigating problems
> such as these.

Yup.  I broke out the ssh source code to see what the messages meant, too.  
(It's a linux from scratch system.  Comes in handy at times like these. :)

Cutting and pasting from this test case is a bit problematic, but the most 
interesting message was the one where it was complaining I hadn't entered the 
passphrase for the public key.  (The key doesn't HAVE a passphrase.  Yes I 
compared the id_dsa files, authorized_keys, etc.)  This is probably a red 
herring though, since the non-passphrase version (ssh 10.0.0.1 as root) has a 
similar behavior of complaining I hadn't entered a password it had never 
prompted me for.  It seems to get an immediate eof (or some other kind of 
error) on input whenever it wants a password.

Again, the exact same code and data files work after initrd exits.

It MIGHT have something to do with the fact that ptys don't seem to be 
initialized before initrd exits.  ssh gets a little strange when there are no 
ptys.  (When I mount /dev/pts, it's empty.  However, the success case of 
booting the same code from /dev/hda1doesn't even need /dev/pts mounted to 
work, so...?)

I can probably cut this test case down to fit on a bootable floppy given 
about eight hours of sleep.  :)

Rob
